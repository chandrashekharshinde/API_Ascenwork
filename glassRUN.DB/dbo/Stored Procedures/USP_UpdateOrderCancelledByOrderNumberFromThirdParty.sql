CREATE PROCEDURE [dbo].[USP_UpdateOrderCancelledByOrderNumberFromThirdParty]

@xmlDoc XML


AS
BEGIN

	DECLARE @intPointer INT;
	EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	DECLARE @orderId  bigint ;

	Declare @orderNumber  nvarchar(250)
	declare @orderType nvarchar(250)
	declare @CompanyCode nvarchar(250)


	
	
	select  
	@orderNumber =tmp.OrderNumber,
	@orderType =tmp.OrderType,
	@CompanyCode =tmp.CompanyCode

	FROM OPENXML(@intpointer,'Json/Order',2)
	WITH
	(
		OrderNumber  nvarchar(250) ,
		CompanyCode  nvarchar(250),
		OrderType  nvarchar(250)
		) tmp

	
	
	SELECT * INTO #tmpOrderProduct
	FROM OPENXML(@intpointer,'Json/Order/OrderProductList',2)
	WITH
    (
	ProductCode  nvarchar(250) ,
	ItemShortCode  nvarchar(250),
	LastStatus  nvarchar(250) ,
	NextStatus  nvarchar(250) ,
	LineNumber nvarchar(250)

	) tmp




	set @orderId=(select  top 1  OrderId From [Order] where OrderNumber=@orderNumber and OrderType=@orderType and CompanyCode=@CompanyCode)




	
	

	DECLARE @CurrentJDEState as bigint
	
	SELECT @CurrentJDEState = (SELECT TOP 1 #tmpOrderProduct.Laststatus FROM #tmpOrderProduct)
	
	if(@CurrentJDEState =980)
	begin


	-- Update Order
	UPDATE [order]   SET  
	
	CurrentState  = @CurrentJDEState
	WHERE OrderId=@orderId



	-------update isactive  =false   from main  enquiry and main order

	 update EnquiryProduct 
   set IsActive=0
     
   where AssociatedOrder !=0 and EnquiryId in (select EnquiryId From [Order] where  currentState =980 and OrderId=@orderId )
   
   
   update OrderProduct 
   set IsActive=0
     
   where AssociatedOrder !=0 and OrderId in (select OrderId From [Order] where  currentState =980 and OrderId=@orderId )
   

	end
	
	
	if(@CurrentJDEState =537) 
	begin
	-- Update Order
	UPDATE [order]   SET  
	
	CurrentState  = @CurrentJDEState
	WHERE OrderId=@orderId
	end
	
	
	SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
	
END
