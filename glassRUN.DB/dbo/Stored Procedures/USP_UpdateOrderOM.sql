CREATE PROCEDURE [dbo].[USP_UpdateOrderOM] --'<Json><OrderId>14</OrderId><OrderNumber>SO000114</OrderNumber><EnquiryId>14</EnquiryId><ExpectedTimeOfDelivery>30/10/2017</ExpectedTimeOfDelivery><SoldTo>14</SoldTo><ShipTo>28</ShipTo><SalesOrderNumber>SO000114</SalesOrderNumber><CurrentState>5</CurrentState><DeliveryLocationName>PK10-HO KINH DOANH CA THE LE KIM TOAN</DeliveryLocationName><CreatedDate>2017-10-25T12:00:08.417</CreatedDate><CompanyID>14</CompanyID><IsActive>1</IsActive><OrderProductsList><OrderProductId>20</OrderProductId><OrderId>14</OrderId><ProductCode>65801001</ProductCode><ProductType>9</ProductType><ProductQuantity>7.00</ProductQuantity><ItemName>Affligem Blond 300x24B Ctn</ItemName><StockInQuantity>1000.00</StockInQuantity><ItemId>97</ItemId><UOM>Carton</UOM><UnitPrice>0.00</UnitPrice><TotalWeightMeasure>0.00</TotalWeightMeasure><ShippableQuantity>7.00</ShippableQuantity><BackOrderQuantity>7.00</BackOrderQuantity><CancelledQuantity>0.00</CancelledQuantity><CreatedDate>2017-10-25T12:00:08.42</CreatedDate><IsActive>1</IsActive></OrderProductsList><OrderProductsList><OrderProductId>22</OrderProductId><OrderId>14</OrderId><ProductCode>65801011</ProductCode><ProductType>9</ProductType><ProductQuantity>2.00</ProductQuantity><ItemName>Affligem Double 300x24B Ctn</ItemName><StockInQuantity>1000.00</StockInQuantity><ItemId>98</ItemId><UOM>Carton</UOM><UnitPrice>0.00</UnitPrice><ShippableQuantity>2.00</ShippableQuantity><BackOrderQuantity>2.00</BackOrderQuantity><CancelledQuantity>0.00</CancelledQuantity><CreatedDate>2017-10-26T22:13:25.143</CreatedDate><IsActive>false</IsActive></OrderProductsList><TruckCapacity>26000</TruckCapacity><TruckSizeId>5</TruckSizeId><TruckName>13T</TruckName><RequestDate>30/10/2017</RequestDate></Json>'
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


     DECLARE @OrderId bigint

   UPDATE dbo.[Order] SET
			@OrderId=tmp.OrderId,
        	[OrderNumber]=tmp.OrderNumber ,
			[EnquiryId] = tmp.EnquiryId,
			[ExpectedTimeOfDelivery] = convert(datetime,tmp.[ExpectedTimeOfDelivery], 103),
			[SoldTo] = tmp.[SoldTo],
			[ShipTo] = tmp.[ShipTo],
			[SalesOrderNumber] = tmp.[SalesOrderNumber],
			[CurrentState] = tmp.[CurrentState],			
			[CreatedDate] = convert(datetime,tmp.[CreatedDate], 103)
		--	[StockLocationId] = tmp.[StockLocationId]       	
        	
        
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
            [OrderId] bigint,    
			[EnquiryId] bigint,         
            [OrderNumber] nvarchar(50), 
			[ExpectedTimeOfDelivery] nvarchar(100), 
			[SoldTo] bigint,    
			[ShipTo] bigint, 
			[SalesOrderNumber] nvarchar(50), 
			[CurrentState] bigint,	
            [CreatedDate] datetime,           
            [StockLocationId] bigint          
                
            )tmp WHERE [Order].OrderId=tmp.OrderId



		select * into #tmpOrderProduct
		FROM OPENXML(@intpointer,'Json/OrderProductsList',2)
        WITH
        (
		OrderProductId bigint,
			[EnquiryId] bigint,
            [ProductCode] nvarchar(200),
            [ProductType] nvarchar(200),
            [ProductQuantity] decimal(10, 2),
            [Remarks] nvarchar,
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
            [SequenceNo] bigint,
			ItemPrices decimal(18,2),
            [Field1] nvarchar(500),
            [Field2] nvarchar(500),
            [Field3] nvarchar(500),
            [Field4] nvarchar(500),
            [Field5] nvarchar(500),
            [Field6] nvarchar(500),
            [Field7] nvarchar(500),
            [Field8] nvarchar(500),
            [Field9] nvarchar(500),
            [Field10] nvarchar(500)
        )tmp
		 
		select * from #tmpOrderProduct

		update OrderProduct Set IsActive=0  WHERE OrderId=@OrderId

		 UPDATE OrderProduct SET ProductQuantity=#tmpOrderProduct.ProductQuantity,ShippableQuantity=#tmpOrderProduct.ProductQuantity,BackOrderQuantity=#tmpOrderProduct.ProductQuantity,
			  IsActive=#tmpOrderProduct.[IsActive],ModifiedDate=getdate() 
			  from #tmpOrderProduct WHERE OrderProduct.OrderProductId=#tmpOrderProduct.OrderProductId

			  
				INSERT INTO dbo.OrderProduct( OrderId, ProductCode,ProductType,UnitPrice,ProductQuantity,ShippableQuantity,BackOrderQuantity,CancelledQuantity,Remarks
				,CreatedBy,CreatedDate,IsActive)
				SELECT @OrderId,#tmpOrderProduct.[ProductCode],#tmpOrderProduct.ProductType,#tmpOrderProduct.ItemPrices,#tmpOrderProduct.ProductQuantity,#tmpOrderProduct.ProductQuantity,
				#tmpOrderProduct.ProductQuantity,0,#tmpOrderProduct.[Remarks],1,GETDATE(),1
				FROM #tmpOrderProduct WHERE #tmpOrderProduct.OrderProductId = 0


        
    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
