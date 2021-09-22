CREATE PROCEDURE [dbo].[ISP_OrderTripCost]-- '<Json><ServicesAction>SaveEmailEvent</ServicesAction><EmailEventList><EmailEventId>0</EmailEventId><EventName>test1</EventName><EventCode>00036</EventCode><Description>testdesc</Description><CreatedBy>12</CreatedBy><IsActive>true</IsActive></EmailEventList></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @Action NVARCHAR(255);
	DECLARE @OrderId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


        
		SELECT * INTO #tmpOrderTripCostList 
        FROM OPENXML(@intpointer,'Json/OrderTripCostList',2)
        WITH
        (
		[OrderId] bigint,
		[TransporterId] bigint,
		[OrderNumber] nvarchar(200) ,
		[TripCost] decimal(18, 4) ,
		[TripRevenue] decimal(18, 4) ,
		[Action] nvarchar(max),
		[IsActive] bit,
		[CreatedDate] datetime
          
        )tmp
        
	SELECT @Action=[Action],@OrderId=OrderId from #tmpOrderTripCostList

	if @Action='TripCost'
	begin
		 INSERT INTO [OrderTripCost]
        (
			[OrderId]
			,[OrderNumber]
			,[TripCost]
			,[TripRevenue]
			,[IsActive]
			,[CreatedDate]
        
        )

       SELECT 
			 tmp.[OrderId]
			 ,tmp.[OrderNumber]
			 ,tmp.[TripCost]
			 ,tmp.[TripRevenue]
			 ,tmp.[IsActive]
			 ,GETDATE()
		From #tmpOrderTripCostList tmp where tmp.[OrderId] not in (Select otc.orderid from dbo.[OrderTripCost] otc)

		 UPDATE dbo.[OrderTripCost]
			 SET [TripCost]=tmp.[TripCost],[TripRevenue]=tmp.[TripRevenue]
			 FROM #tmpOrderTripCostList tmp
			 WHERE 
		dbo.[OrderTripCost].[OrderId]=tmp.[OrderId] and 
		dbo.[OrderTripCost].[OrderNumber]=tmp.[OrderNumber]
	end
	else if @Action='AssignTransporter'
	begin

			 UPDATE dbo.[orderMovement]
			 SET TransportOperatorId=tmp.TransporterId
			 FROM #tmpOrderTripCostList tmp
			 WHERE 
		    dbo.[orderMovement].[OrderId]=tmp.[OrderId] 


		 UPDATE dbo.[Order]
			 SET CarrierNumber=tmp.TransporterId
			 FROM #tmpOrderTripCostList tmp
			 WHERE 
		dbo.[Order].[OrderId]=tmp.[OrderId] 

	end


--------Insert into trip


DECLARE @site_value INT;
DECLARE @rowcount INT;
SET @site_value = 1;
SET @rowcount =(Select count(tmp.OrderId) from #tmpOrderTripCostList tmp)

WHILE @site_value <= @rowcount
BEGIN

	Select @OrderId=tmp1.OrderId from (Select ROW_NUMBER() OVER (ORDER BY tmp.OrderId desc) as [rownumber],tmp.OrderId from #tmpOrderTripCostList tmp ) as tmp1 where tmp1.rownumber=@site_value

   exec ISPandUSP_PaymentRequest @OrderId
   SET @site_value = @site_value + 1;
END;




        
--Add child table insert procedure when required.
    
SELECT 1 as OrderTripCostId FOR XML RAW('Json'),ELEMENTS
exec sp_xml_removedocument @intPointer 	
END TRY
BEGIN CATCH
SELECT @ErrMsg = ERROR_MESSAGE(); 
RAISERROR(@ErrMsg, @ErrSeverity, 1); 
RETURN; 
END CATCH
END