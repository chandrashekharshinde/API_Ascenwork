CREATE PROCEDURE [dbo].[USP_UpdateOrderDetailByOrderNumberFromThirdParty]

@xmlDoc XML


AS
BEGIN

	DECLARE @intPointer INT;
	EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	DECLARE @orderId  bigint ;

	SELECT * INTO #tmpOrder
	FROM OPENXML(@intpointer,'Json/Order',2)
	WITH
	(
		OrderNumber  nvarchar(250) ,
		CompanyCode  nvarchar(250),
		OrderType  nvarchar(250),
		LoadNumber  nvarchar(250),
		RedInvoiceNumber  nvarchar(250)
	) tmp

	SELECT * INTO #tmpOrderProduct
	FROM OPENXML(@intpointer,'Json/Order/OrderProductList',2)
	WITH
    (
	ProductCode  nvarchar(250) ,
	ItemShortCode  nvarchar(250),
	LastStatus  nvarchar(250) ,
	NextStatus  nvarchar(250) ,
	LineNumber nvarchar(250),
	PickNumber  nvarchar(250),
	ShipmentNumber  nvarchar(250),
	InvoiceNumber  nvarchar(250)
	) tmp

	----------get orderid  from tmpOrder table-------------------
	UPDATE [order]
	SET @orderId = o.orderid,
	LoadNumber = #tmpOrder.LoadNumber,
	RedInvoiceNumber  = #tmpOrder.RedInvoiceNumber
	FROM   [order] o join   #tmpOrder   ON #tmpOrder.OrderNumber =o.OrderNumber
	and #tmpOrder.OrderType = o.OrderType 
	WHERE o.OrderId is not null

	--------update order product   -------------------
	UPDATE OrderProduct
	SET LastStatus =#tmpOrderProduct.LastStatus,
	NextStatus =#tmpOrderProduct.NextStatus
	FROM   OrderProduct  op join #tmpOrderProduct  ON 
	op.LineNumber = #tmpOrderProduct.LineNumber and op.OrderId =@orderId 

	-- Checking if current state of an order is JDE is already passed in glassRUN
	DECLARE @CurrentState as bigint
	DECLARE @CurrentGRState as bigint
	DECLARE @GRStateSequenceNumber as bigint
	SELECT @CurrentGRState = CurrentState FROM [ORDER] WITH (NOLOCK) WHERE OrderId = @OrderId
	SELECT @GRStateSequenceNumber = SequenceNo FROM WorkflowStep WHERE StatusCode = @CurrentGRState

	DECLARE @CurrentJDEState as bigint
	DECLARE @JDEStateSequenceNumber as bigint
	SELECT @CurrentJDEState = (SELECT TOP 1 #tmpOrderProduct.Laststatus FROM #tmpOrderProduct)
	SELECT @JDEStateSequenceNumber = SequenceNo FROM WorkflowStep WHERE StatusCode = @CurrentJDEState
	
	IF @GRStateSequenceNumber > @JDEStateSequenceNumber
		SET @CurrentState = @CurrentGRState
	ELSE IF @JDEStateSequenceNumber = 999
		SET @CurrentState = @CurrentJDEState
	ELSE
		SET @CurrentState = @CurrentJDEState
	 
	-- Update Order
	UPDATE [order]   SET  
	PickNumber  = (SELECT TOP 1 #tmpOrderProduct.PickNumber FROM #tmpOrderProduct),
	InvoiceNumber  = (SELECT TOP 1 #tmpOrderProduct.InvoiceNumber FROM #tmpOrderProduct),
	CurrentState  = @CurrentState
	WHERE OrderId=@orderId

	--- update ordermovement when order shipped
	EXEC [dbo].[USP_OrderCollectedWhenOrderShipmentFromThirdParty] @orderid	
	
	
	----send notifcation when load buid  is created
	

	if(not exists(select   *From EventNotification  where ObjectId=@orderId  and EventCode='LoadBuildCreated'))
	begin


	INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='LoadBuildCreated' and IsActive=1),'LoadBuildCreated',@orderId,'Order',1,1,GETDATE()

	end

	
				
			
	SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
	
END
