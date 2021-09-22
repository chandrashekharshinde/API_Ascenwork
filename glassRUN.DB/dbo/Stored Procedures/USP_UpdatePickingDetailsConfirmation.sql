
CREATE PROCEDURE [dbo].[USP_UpdatePickingDetailsConfirmation] --'<Json><OrderId>76634</OrderId><OrderType>SO</OrderType><rownumber>1</rownumber><TotalCount>31</TotalCount><OrderNumber>Ord0387</OrderNumber><HoldStatus>-</HoldStatus><TotalPrice>354200000.00</TotalPrice><SalesOrderNumber>Ord0387</SalesOrderNumber><LoadNumber>-</LoadNumber><SOGratisNumber>Ord0387</SOGratisNumber><PurchaseOrderNumber>-</PurchaseOrderNumber><ProposedShift /><ProposedTimeOfAction>2018-10-08T18:30:00Z</ProposedTimeOfAction><StatusForChangeInPickShift>0</StatusForChangeInPickShift><OrderDate>2018-09-10T10:27:12.887Z</OrderDate><DeliveryLocationName>HM-CTY TNHH SX DV TM XNK MINH QUANG</DeliveryLocationName><DeliveryLocation>1111026</DeliveryLocation><CompanyName>HM</CompanyName><CompanyMnemonic>1111026</CompanyMnemonic><UserName>OM</UserName><ExpectedTimeOfDelivery>11/09/2018</ExpectedTimeOfDelivery><RequestDate>11/09/2018</RequestDate><ReceivedCapacityPalettes>398</ReceivedCapacityPalettes><Capacity>450</Capacity><IsRPMPresent>0</IsRPMPresent><EnquiryAutoNumber>INQ000008</EnquiryAutoNumber><ProductCode>65205121</ProductCode><ProductName>Heineken 330x16C Ctn Sleek</ProductName><ProductQuantity>1400</ProductQuantity><OrderedBy>OM</OrderedBy><CarrierNumberValue>2143951</CarrierNumberValue><Field1 /><CurrentState>1103</CurrentState><Status>-</Status><Class /><OrderProductList><OrderProductId>78650</OrderProductId><OrderId>76634</OrderId><ProductCode>65205121</ProductCode><ProductType>9</ProductType><ItemType>32</ItemType><ItemName>Heineken 330x16C Ctn Sleek</ItemName><ProductQuantity>1400</ProductQuantity><ItemPricesPerUnit>230000</ItemPricesPerUnit><ItemPrices>322000000</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Carton</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>8</ProductAvailableQuantity><IsItemAvailableInStock>false</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>78651</OrderProductId><OrderId>76634</OrderId><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ItemType>0</ItemType><ItemName>Wooden Pallet</ItemName><ProductQuantity>10</ProductQuantity><ItemPricesPerUnit>0</ItemPricesPerUnit><ItemPrices>0</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Each</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>435</ProductAvailableQuantity></OrderProductList><ShipTo>647</ShipTo><SoldTo>592</SoldTo><ReceivedCapacityPalettesCheck>1</ReceivedCapacityPalettesCheck><Note /><StockLocationId>626</StockLocationId><BranchPlantName>6410</BranchPlantName><DeliveryLocationBranchName>CTTNHH BIA VA NUOC GIAI KHAT HEINEKEN VN</DeliveryLocationBranchName><Empties>W</Empties><EmptiesLimit>76000</EmptiesLimit><ActualEmpties>3839</ActualEmpties><TruckSizeId>16</TruckSizeId><TruckSize>H10</TruckSize><PlateNumberData>29A-423.02</PlateNumberData><PlateNumber>05A-373.56</PlateNumber><DriverName>Arjun Madhusdan</DriverName><ProfileId>395</ProfileId><TruckInPlateNumber>29A-423.02</TruckInPlateNumber><TruckOutPlateNumber>29A-423.02</TruckOutPlateNumber><TruckInDateTime /><TruckOutDateTime /><CarrierNumber>1228</CarrierNumber><ExpectedShift /><ExpectedTimeOfAction>10/09/2018</ExpectedTimeOfAction><DeliveryPersonnelId>385</DeliveryPersonnelId><IsEditOrderStatusConfiguration>false</IsEditOrderStatusConfiguration><OrderGUID>249baf73-2991-4fd7-80d6-7f2f25cd45b9</OrderGUID><IsTruckInDisabled>false</IsTruckInDisabled><IsTruckOutDisabled>false</IsTruckOutDisabled><IsAvailableStock>false</IsAvailableStock><IsGratisItemAvailable>false</IsGratisItemAvailable><LocationType>1</LocationType><UserId>6</UserId><PlateNumberBy>WareHouse</PlateNumberBy></Json>'
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
	
		DECLARE @SalesOrderNumber nvarchar(150)
		DECLARE @pickingDate nvarchar(150)
		DECLARE @plateNumber nvarchar(150)
		Declare @pickingShift nvarchar(150)
		DECLARE @locationType nvarchar(150)
		declare @DeliveryPersonnelId nvarchar(150)
		declare @CarrierId nvarchar(150)
		DECLARE @orderId BIGINT
		Declare @UserId bigint
		Declare @PlateNumberBy nvarchar(100)

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT  @orderId = tmp.[OrderId],
		        @SalesOrderNumber = tmp.[SalesOrderNumber],
				@pickingDate=tmp.[PickingDate],
				@pickingShift = tmp.[pickingShift],
				@plateNumber=tmp.[PlateNumber],
				@locationType=tmp.[LocationType],
				@DeliveryPersonnelId = tmp.[DeliveryPersonnelId],
				@CarrierId = tmp.[CarrierId],
				@UserId = tmp.[UserId],
				@PlateNumberBy = tmp.[PlateNumberBy]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] bigint,
			[SalesOrderNumber] NVARCHAR(50),
			[PickingDate] nvarchar(50),
			[pickingShift] nvarchar(50),
			[PlateNumber] nvarchar(50),
			[LocationType] nvarchar(50),
			[DeliveryPersonnelId] nvarchar(50),
			[CarrierId] nvarchar(50),
			[UserId] bigint,
			[PlateNumberBy] nvarchar(100)
			)tmp 




			Declare @OrderMovementId bigint
			Declare @orderLogisticId bigint

			SET @OrderMovementId = (SELECT OrderMovementId FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
			SET @orderLogisticId = (SELECT OrderLogisticsId FROM [OrderLogistics] WHERE OrderMovementId = @OrderMovementId)
			SET @orderId=(SELECT OrderId FROM [ORDER] WHERE SalesOrderNumber=@SalesOrderNumber)
			set @CarrierId=(SELECT CarrierNumber FROM [ORDER] WHERE OrderId=@orderId)
			PRINT @orderId




			UPDATE [orderMovement] SET ExpectedTimeOfAction= convert(datetime,@pickingDate, 103),
			 ExpectedShift= @pickingShift,
			 TransportOperatorId = @CarrierId,
			 DeliveryPersonnelId = @DeliveryPersonnelId,
			 UpdatedDate = GETDATE(),
			 CreatedBy = @UserId
			WHERE OrderId=@orderId 

				
		UPDATE [OrderLogistics] SET TruckPlateNumber=@plateNumber ,UpdatedDate=GETDATE(), UpdateBy = @UserId
							WHERE OrderMovementId = @OrderMovementId

		INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
		[TransportVehicleId],[DeliveryPersonnelId],[OrderMovementId],PlateNumberBy,[IsActive],[CreatedBy],[CreatedDate])
		SELECT @orderId,@UserId,@orderLogisticId,NULL,@plateNumber,NULL,@DeliveryPersonnelId,@OrderMovementId,@PlateNumberBy,1,@UserId,getdate()

		
	
    
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END