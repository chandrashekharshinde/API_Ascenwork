
CREATE PROCEDURE [dbo].[SSP_UpdateBulkCarrierConfirmation]-- '<Json><OrderId>76368</OrderId><OrderType>SO</OrderType><rownumber>1</rownumber><TotalCount>2</TotalCount><OrderNumber>18016663</OrderNumber><TotalPrice>398499716.00</TotalPrice><Email>vijayw@disrptiv.com</Email><DeliveryPersonnelId>381</DeliveryPersonnelId><PraposedShift>1106</PraposedShift><PraposedTimeOfAction>11/03/2018</PraposedTimeOfAction><ExpectedShift>1106</ExpectedShift><ExpectedTimeOfAction>01/01/1900</ExpectedTimeOfAction><SalesOrderNumber>18016663</SalesOrderNumber><PurchaseOrderNumber>-</PurchaseOrderNumber><OrderDate>2018-03-09T16:11:42.84Z</OrderDate><DeliveryLocationName>P443-DNTN THUONG MAI HOANG NGAN</DeliveryLocationName><DeliveryLocation>1111617</DeliveryLocation><CompanyName>P443-DNTN THUONG MAI HOANG NGAN</CompanyName><ExpectedTimeOfDelivery>13/03/2018</ExpectedTimeOfDelivery><ReceivedCapacityPalettes>152</ReceivedCapacityPalettes><Capacity>168</Capacity><EnquiryAutoNumber>INQ001205</EnquiryAutoNumber><CurrentState>1103</CurrentState><Status>Plate Number Allocated</Status><Class>PlateNumberUpdated_Status</Class><OrderProductList><OrderProductId>77929</OrderProductId><OrderId>76368</OrderId><ProductCode>65305011</ProductCode><ProductType>9</ProductType><ItemName>Bivina 330x24C Ctn</ItemName><ProductQuantity>100</ProductQuantity><ItemPricesPerUnit>161818</ItemPricesPerUnit><ItemPrices>16181800</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Carton</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>0</ProductAvailableQuantity><IsItemAvailableInStock>false</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>77926</OrderProductId><OrderId>76368</OrderId><ProductCode>65205025</ProductCode><ProductType>9</ProductType><ItemName>Heineken 330x6x4C Ctn</ItemName><ProductQuantity>600</ProductQuantity><ItemPricesPerUnit>330909</ItemPricesPerUnit><ItemPrices>198545400</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Carton</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>0</ProductAvailableQuantity><IsItemAvailableInStock>false</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>77930</OrderProductId><OrderId>76368</OrderId><ProductCode>65206002</ProductCode><ProductType>9</ProductType><ItemName>Heineken Keg 20L IBC</ItemName><ProductQuantity>40</ProductQuantity><ItemPricesPerUnit>740909</ItemPricesPerUnit><ItemPrices>29636360</ItemPrices><DepositeAmountPerUnit>5000</DepositeAmountPerUnit><ItemTotalDepositeAmount>200000</ItemTotalDepositeAmount><UOM>Keg</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>500.00</UsedQuantityInOrder><ProductAvailableQuantity>638</ProductAvailableQuantity><IsItemAvailableInStock>true</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>77928</OrderProductId><OrderId>76368</OrderId><ProductCode>65101021</ProductCode><ProductType>9</ProductType><ItemName>Tiger 330x24B Crt Uncage</ItemName><ProductQuantity>500</ProductQuantity><ItemPricesPerUnit>233636</ItemPricesPerUnit><ItemPrices>116818000</ItemPrices><DepositeAmountPerUnit>2000</DepositeAmountPerUnit><ItemTotalDepositeAmount>1000000</ItemTotalDepositeAmount><UOM>Crate</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>760.00</UsedQuantityInOrder><ProductAvailableQuantity>31707</ProductAvailableQuantity><IsItemAvailableInStock>true</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>77927</OrderProductId><OrderId>76368</OrderId><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ItemName>Wooden Pallet</ItemName><ProductQuantity>16</ProductQuantity><ItemPricesPerUnit>0</ItemPricesPerUnit><ItemPrices>0</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Each</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>296.00</UsedQuantityInOrder><ProductAvailableQuantity>435</ProductAvailableQuantity></OrderProductList><ShipTo>397</ShipTo><SoldTo>583</SoldTo><StockLocationId>626</StockLocationId><BranchPlantName>6410</BranchPlantName><TruckInPlateNumberCheck>false</TruckInPlateNumberCheck><TruckOutPlateNumberCheck>true</TruckOutPlateNumberCheck><PreviousPlateNumber>XV 443R</PreviousPlateNumber><TruckInPlateNumber>XV 443R</TruckInPlateNumber><TruckOutPlateNumber>XV 4344R</TruckOutPlateNumber><PlateNumber>XV 443R</PlateNumber><TruckInDateTime>1900-01-01T00:00:00</TruckInDateTime><TruckOutDateTime>1900-01-01T00:00:00</TruckOutDateTime><DriverName>-</DriverName><ProfileId>0</ProfileId><EmptiesLimit>30000</EmptiesLimit><ActualEmpties>-7454</ActualEmpties><PreviousState>3</PreviousState><TruckSizeId>21</TruckSizeId><TruckSize>H16</TruckSize><CompanyNameValue>P443</CompanyNameValue><IsAvailableStock>false</IsAvailableStock><IsGratisItemAvailable>false</IsGratisItemAvailable><selected>true</selected><DriverId></DriverId><pickingShift></pickingShift><PickingDate></PickingDate></Json>'
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



		DECLARE @pickingDate nvarchar(150)
		DECLARE @plateNumber nvarchar(150)
		Declare @pickingShift nvarchar(150)
		DECLARE @locationType nvarchar(150)
		declare @DeliveryPersonnelId nvarchar(150)		
		DECLARE @orderId BIGINT
		Declare @UserId bigint
		

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT  @orderId = tmp.[OrderId],		      
				@pickingDate=tmp.[PickingDate],
				@pickingShift = tmp.[pickingShift],
				@plateNumber=tmp.[PlateNumber],
				@locationType=1,
				@DeliveryPersonnelId = tmp.[DriverId],				
				@UserId = 1
				
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] bigint,			
			[PickingDate] nvarchar(50),
			[pickingShift] nvarchar(50),
			[PlateNumber] nvarchar(50),
			[LocationType] nvarchar(50),
			[DriverId] nvarchar(50),			
			[UserId] bigint
			
			)tmp 
			Print @DeliveryPersonnelId
			Print @pickingShift
				Print @pickingDate
			
			if @DeliveryPersonnelId=0
			BEGIN
				SET @DeliveryPersonnelId=NULL				
			END

			
			if @pickingDate=''
			BEGIN
			SET @pickingDate=NULL
			END

			if @pickingShift=''
			BEGIN			
			SET @pickingShift=NULL
			END

			if @plateNumber=''
			BEGIN
			SET @plateNumber=NULL
			END
			

			UPDATE [orderMovement] SET ExpectedTimeOfAction= convert(datetime,ISNULL(@pickingDate,ExpectedTimeOfAction), 103),
			                           ExpectedShift= ISNULL(@pickingShift,ExpectedShift),									  
									   DeliveryPersonnelId = ISNULL(@DeliveryPersonnelId,DeliveryPersonnelId),
			                           UpdatedDate = GETDATE(),
									   CreatedBy = ISNULL(@UserId,CreatedBy)
			WHERE OrderId=@orderId AND LocationType=@locationType
				
				
		DECLARE @orderLogisticId bigint
		Declare @OrderMovementId bigint

		SET @OrderMovementId = (SELECT OrderMovementId FROM OrderMovement WHERE OrderId=@orderId AND LocationType=1)
		
		SET @orderLogisticId = (SELECT OrderLogisticsId FROM [OrderLogistics] WHERE OrderMovementId = @OrderMovementId)

	
			Declare @IsPresentOrNot bigint
			SET @IsPresentOrNot=(Select Count(OrderLogisticsId) from [OrderLogistics] where OrderLogisticsId=@orderLogisticId)
			if @IsPresentOrNot = 0
				begin
				
			
							INSERT INTO [dbo].[OrderLogistics]  ([OrderMovementId],[DeliveryPersonnelId],[TruckPlateNumber],[IsActive],[CreatedBy],[CreatedDate])
							SELECT  @OrderMovementId,@DeliveryPersonnelId,@plateNumber,1,1,getdate()
						
							SELECT  @orderLogisticId  = @@IDENTITY 


							INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
							[TransportVehicleId],[DeliveryPersonnelId],[OrderMovementId],PlateNumberBy,[IsActive],[CreatedBy],[CreatedDate])
							SELECT  @orderId,@UserId,@orderLogisticId,NULL,@plateNumber,NULL,NULL,@OrderMovementId,NULL,1,1,getdate()

				end
			else
				begin				

							UPDATE [OrderLogistics] SET TruckPlateNumber=ISNULL(@plateNumber,TruckPlateNumber) ,[DeliveryPersonnelId]=ISNULL(@DeliveryPersonnelId,DeliveryPersonnelId),UpdatedDate=GETDATE(), UpdateBy = 1
							WHERE OrderMovementId = @OrderMovementId

							INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
							[TransportVehicleId],[DeliveryPersonnelId],[OrderMovementId],PlateNumberBy,[IsActive],[CreatedBy],[CreatedDate])
							SELECT @orderId,@UserId,@orderLogisticId,NULL,@plateNumber,NULL,NULL,@OrderMovementId,NULL,1,1,getdate()
				
				end

		
		UPDATE dbo.[Order] SET CurrentState=1103 WHERE OrderId=@orderId

		    

	
    
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
