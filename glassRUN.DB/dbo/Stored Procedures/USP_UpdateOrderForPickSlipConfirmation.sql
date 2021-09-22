CREATE PROCEDURE [dbo].[USP_UpdateOrderForPickSlipConfirmation] --'<Json><OrderId>14</OrderId><OrderNumber>SO000114</OrderNumber><EnquiryId>14</EnquiryId><ExpectedTimeOfDelivery>10/27/2017</ExpectedTimeOfDelivery><SoldTo>14</SoldTo><ShipTo>28</ShipTo><SalesOrderNumber>SO000114</SalesOrderNumber><CurrentState>5</CurrentState><DeliveryLocationName>PK10-HO KINH DOANH CA THE LE KIM TOAN</DeliveryLocationName><CreatedDate>2017-10-25T12:00:08.417</CreatedDate><StockLocationId>16</StockLocationId><PickingDate>31/10/2017</PickingDate><PlateNumber>54699</PlateNumber><CompanyID>14</CompanyID><OrderProductsList><OrderProductId>20</OrderProductId><OrderId>14</OrderId><ProductCode>65801001</ProductCode><ProductType>9</ProductType><ProductQuantity>10.00</ProductQuantity><ItemName>Affligem Blond 300x24B Ctn</ItemName><StockInQuantity>1000.00</StockInQuantity><UnitPrice>0.00</UnitPrice><TotalWeightMeasure>0.00</TotalWeightMeasure><ShippableQuantity>10.00</ShippableQuantity><BackOrderQuantity>10.00</BackOrderQuantity><CancelledQuantity>0.00</CancelledQuantity><CreatedDate>2017-10-25T12:00:08.42</CreatedDate></OrderProductsList></Json>'
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


   select * into #tmpOrder
    FROM OPENXML(@intpointer,'Json/Order',2)
        WITH
        (
		[OrderId] bigint,
		[OrderNumber] nvarchar(150)
			
        )tmp
		 
		--select * from #tmpOrder
		DECLARE @orderId BIGINT
	
       SET @orderId=(SELECT #tmpOrder.OrderId FROM #tmpOrder)
		
		
		UPDATE dbo.[Order] SET CurrentState=36 ,IsPrintPickSlip=1  WHERE OrderId=@orderId


         SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
