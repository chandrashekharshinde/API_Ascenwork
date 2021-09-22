


CREATE PROCEDURE [dbo].[SSP_UpdatePickingConfirmation] 
--'<Json><rownumber>1</rownumber><TotalCount>1</TotalCount><TripCost>0.00</TripCost><TripRevenue>0.00</TripRevenue><TripProfit>0.00</TripProfit><TripProfitPerCent>0.00</TripProfitPerCent><BillingStatus /><BillingCreditedAmount /><BillingCreditedAmountStatus /><BillingCreditedAmountDate /><BalanceAmount>0.00</BalanceAmount><BalAmtStatus>Trip Cost Not Assign</BalAmtStatus><BalanceAmountDate>2019-06-21T19:34:00</BalanceAmountDate><OrderId>13208</OrderId><EnquiryId>513</EnquiryId><OrderType>SO</OrderType><ModifiedDate>2019-06-21T17:34:51.18</ModifiedDate><OrderNumber>026853</OrderNumber><ApprovedBy>NTHLOAN</ApprovedBy><HoldStatus>-</HoldStatus><TotalPrice>151.199.664,00 ₫</TotalPrice><SalesOrderNumber>1079914409</SalesOrderNumber><SOGratisNumber>1079914409</SOGratisNumber><PurchaseOrderNumber /><ProposedShift>1</ProposedShift><Shift /><ProposedTimeOfAction>1900-01-01T00:00:00</ProposedTimeOfAction><StatusForChangeInPickShift>0</StatusForChangeInPickShift><OrderDate>2019-06-21T17:34:51.18</OrderDate><DeliveryLocationName>DN10-DOANH NGHIEP TU NHAN TRAN KHA</DeliveryLocationName><LocationName>DN10-DOANH NGHIEP TU NHAN TRAN KHA</LocationName><DeliveryLocation>1111097</DeliveryLocation><SupplierName>HEINEKEN VIETNAM BREWERY LIMITED COMPANY</SupplierName><SupplierCode>0</SupplierCode><CompanyName>DN10-DOANH NGHIEP TU NHAN TRAN KHA</CompanyName><CompanyMnemonic>1111097</CompanyMnemonic><UserName>1111097a</UserName><ExpectedTimeOfDelivery>2019-06-24T00:00:00</ExpectedTimeOfDelivery><RequestDate>2019-06-24T00:00:00</RequestDate><ReceivedCapacityPalettes>72</ReceivedCapacityPalettes><Capacity>96</Capacity><IsRPMPresent>0</IsRPMPresent><EnquiryAutoNumber>INQ026853</EnquiryAutoNumber><OrderedBy>536</OrderedBy><CarrierNumberValue>Cty CP Van Tai O To so 2</CarrierNumberValue><Field1 /><CurrentState>520</CurrentState><Status>Order Created</Status><Class>#a7a9ac</Class><ShipTo>284</ShipTo><OrderCompanyId>1</OrderCompanyId><SoldTo>66</SoldTo><ReceivedCapacityPalettesCheck>1</ReceivedCapacityPalettesCheck><BranchPlantName>VBB - kho Vung Tau F2</BranchPlantName><BranchPlantCode>6439</BranchPlantCode><DeliveryLocationBranchName>VBB - kho Vung Tau F2</DeliveryLocationBranchName><RPMValue>0</RPMValue><EmptiesLimit>46000</EmptiesLimit><ActualEmpties>-6341</ActualEmpties><TruckCapacityWeight>8.00</TruckCapacityWeight><TruckSizeId>15</TruckSizeId><TruckSize>H08</TruckSize><DriverName>-</DriverName><IsCompleted /><EnquiryDate>2019-06-21T17:15:13.07</EnquiryDate><IsLate>1</IsLate><ProfileId>0</ProfileId><TruckInPlateNumber /><TruckOutPlateNumber /><TruckInDateTime>1900-01-01T00:00:00</TruckInDateTime><TruckOutDateTime>1900-01-01T00:00:00</TruckOutDateTime><CarrierNumber>663</CarrierNumber><ExpectedShift /><ExpectedTimeOfAction>1900-01-01T00:00:00</ExpectedTimeOfAction><DeliveryPersonnelId>10536</DeliveryPersonnelId><PickDateTime>2019-06-22T17:16:00</PickDateTime><ExpectedTimeOfDeliveryFromOM>1900-01-01T00:00:00</ExpectedTimeOfDeliveryFromOM><PickDateTimeFromOM>1900-01-01T00:00:00</PickDateTimeFromOM><ExpectedTimeOfDeliveryValue>2019-06-24T00:00:00</ExpectedTimeOfDeliveryValue><PickDateTimeValue>2019-06-22T17:16:00</PickDateTimeValue><IsSelfCollect>0</IsSelfCollect><TruckInDeatilsId>0</TruckInDeatilsId><TruckInOrderId>0</TruckInOrderId><ShipToCode>1111097</ShipToCode><OrderProductList><OrderProductId>162</OrderProductId><OrderId>13208</OrderId><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ItemType>0</ItemType><ItemName>Wooden Pallet</ItemName><ProductQuantity>7</ProductQuantity><ItemPricesPerUnit>0</ItemPricesPerUnit><ItemPrices>0</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Each</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>0</ProductAvailableQuantity></OrderProductList><OrderProductList><OrderProductId>163</OrderProductId><OrderId>13208</OrderId><ProductCode>66005011</ProductCode><ProductType>9</ProductType><ItemType>32</ItemType><ItemName>BGI 330x24C Ctn</ItemName><ProductQuantity>840</ProductQuantity><ItemPricesPerUnit>163636</ItemPricesPerUnit><ItemPrices>137454240</ItemPrices><DepositeAmountPerUnit>0</DepositeAmountPerUnit><ItemTotalDepositeAmount>0</ItemTotalDepositeAmount><UOM>Carton</UOM><ItemTax>10</ItemTax><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>0</ProductAvailableQuantity></OrderProductList><CheckedEnquiry>true</CheckedEnquiry><ProposedShiftForCheck /><ExpectedTimeOfDeliveryForCheck>2019-06-24T00:00:00</ExpectedTimeOfDeliveryForCheck><PickDateTimeForCheck>2019-06-22T17:16:00</PickDateTimeForCheck><IsShowAssignDriverBtn>true</IsShowAssignDriverBtn><showPlateNumberDropDown>true</showPlateNumberDropDown><PlateNumberData>FRH 099494</PlateNumberData><PlateNumber>FRH 099494</PlateNumber><showDriverDropDown>true</showDriverDropDown><showShiftDropDown>true</showShiftDropDown><UserId>10519</UserId><CreatedBy>10519</CreatedBy><ServicesAction>GetLoadNumberFromThirthParty</ServicesAction></Json>'
	@xmlDoc XML
AS
BEGIN
	SET ARITHABORT ON

	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;

	SET @ErrSeverity = 15;

	BEGIN TRY
		DECLARE @SalesOrderNumber NVARCHAR(150)
		DECLARE @pickingDate NVARCHAR(150)
		DECLARE @plateNumber NVARCHAR(150)
		DECLARE @pickingShift NVARCHAR(150)
		DECLARE @locationType NVARCHAR(150)
		DECLARE @DeliveryPersonnelId NVARCHAR(150)
		DECLARE @CarrierId NVARCHAR(150)
		DECLARE @orderId BIGINT
		DECLARE @UserId BIGINT
		DECLARE @PlateNumberBy NVARCHAR(100)
		DECLARE @CurrentState BIGINT
		DECLARE @expectedDateTimeOfDelivery NVARCHAR(150)
		DECLARE @pickDateTime NVARCHAR(150)
        DECLARE @proposedShift NVARCHAR(50)

		EXEC sp_xml_preparedocument @intpointer OUTPUT
			,@xmlDoc

		SELECT @orderId = tmp.[OrderId]
			,@SalesOrderNumber = tmp.[SalesOrderNumber]
			,@pickingDate = tmp.[PickingDate]
			,@pickingShift = tmp.[pickingShift]
			,@plateNumber = tmp.[PlateNumber]
			,@locationType = tmp.[LocationType]
			,@DeliveryPersonnelId = tmp.[DeliveryPersonnelId]
			,@CarrierId = tmp.[CarrierId]
			,@UserId = tmp.[UserId]
			,@PlateNumberBy = tmp.[PlateNumberBy]
			,@CurrentState = tmp.[CurrentState]
			,@expectedDateTimeOfDelivery = tmp.ExpectedTimeOfDelivery
			,@pickDateTime = tmp.PickDateTime
            ,@proposedShift = tmp.ProposedShift
		FROM OPENXML(@intpointer, 'Json', 2) WITH (
				[OrderId] BIGINT
				,[CurrentState] BIGINT
				,[SalesOrderNumber] NVARCHAR(50)
				,[PickingDate] NVARCHAR(50)
				,[pickingShift] NVARCHAR(50)
				,[PlateNumber] NVARCHAR(50)
				,[LocationType] NVARCHAR(50)
				,[DeliveryPersonnelId] NVARCHAR(50)
				,[CarrierId] NVARCHAR(50)
				,[UserId] BIGINT
				,[PlateNumberBy] NVARCHAR(100)
				,ExpectedTimeOfDelivery NVARCHAR(100)
				,PickDateTime NVARCHAR(100)
                ,ProposedShift NVARCHAR(50)
				) tmp

		PRINT @orderId

		SET @CarrierId = (
				SELECT CarrierNumber
				FROM [Order]
				WHERE OrderId = @orderId
				)

		DECLARE @xmlOrderpickup NVARCHAR(max)

		SET @xmlOrderpickup = '<Json><SalesOrderNumber>' + @SalesOrderNumber + '</SalesOrderNumber><OrderId>' + convert(NVARCHAR(max), @orderId) + 
			'</OrderId><PraposedShift>' + @proposedShift + '</PraposedShift><LocationType>1</LocationType>
	<ExpectedTimeOfDelivery>' + @expectedDateTimeOfDelivery + '</ExpectedTimeOfDelivery><PickDateTime>' + @pickDateTime + 
			'</PickDateTime></Json>'
        print @xmlOrderpickup
		EXEC [dbo].[ISP_OrderPickupDateAndShift] @xmlDoc
        

		DECLARE @ExpectedTimeOfDelivery DATETIME

		SELECT @ExpectedTimeOfDelivery = PickDateTime
		FROM [Order]
		WHERE OrderId = @orderId

		UPDATE [orderMovement]
		SET --ExpectedTimeOfAction=@ExpectedTimeOfDelivery,
			ExpectedShift = @pickingShift
			,TransportOperatorId = @CarrierId
			,DeliveryPersonnelId = @DeliveryPersonnelId
			,UpdatedDate = GETDATE()
			,CreatedBy = @UserId
            ,PraposedShift = @proposedShift
		WHERE OrderId = @orderId AND LocationType = 1

		DECLARE @orderLogisticId BIGINT
		DECLARE @OrderMovementId BIGINT

		SET @OrderMovementId = (
				SELECT TOP 1 OrderMovementId
				FROM OrderMovement
				WHERE OrderId = @orderId AND LocationType = 1
				)
		SET @orderLogisticId = (
				SELECT TOP 1 OrderLogisticsId
				FROM [OrderLogistics]
				WHERE OrderMovementId = @OrderMovementId
				)

		DECLARE @IsPresentOrNot BIGINT

		SET @IsPresentOrNot = (
				SELECT Count(OrderLogisticsId)
				FROM [OrderLogistics]
				WHERE OrderLogisticsId = @orderLogisticId
				)

		IF @IsPresentOrNot = 0
		BEGIN
			INSERT INTO [dbo].[OrderLogistics] (
				[OrderMovementId]
				,[DeliveryPersonnelId]
				,[TruckPlateNumber]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @OrderMovementId
				,@DeliveryPersonnelId
				,@plateNumber
				,1
				,@UserId
				,getdate()

			SELECT @orderLogisticId = @@IDENTITY

			INSERT INTO [dbo].[OrderLogisticHistory] (
				[OrderId]
				,[UserId]
				,[OrderLogisticId]
				,[TruckId]
				,[PlateNumber]
				,[TransportVehicleId]
				,[DeliveryPersonnelId]
				,[OrderMovementId]
				,PlateNumberBy
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @orderId
				,@UserId
				,@orderLogisticId
				,NULL
				,@plateNumber
				,NULL
				,@DeliveryPersonnelId
				,@OrderMovementId
				,@PlateNumberBy
				,1
				,@UserId
				,getdate()
		END
		ELSE
		BEGIN
			UPDATE [OrderLogistics]
			SET TruckPlateNumber = @plateNumber
				,DeliveryPersonnelId = @DeliveryPersonnelId
				,UpdatedDate = GETDATE()
				,UpdateBy = @UserId
			WHERE OrderMovementId = @OrderMovementId

			INSERT INTO [dbo].[OrderLogisticHistory] (
				[OrderId]
				,[UserId]
				,[OrderLogisticId]
				,[TruckId]
				,[PlateNumber]
				,[TransportVehicleId]
				,[DeliveryPersonnelId]
				,[OrderMovementId]
				,PlateNumberBy
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @orderId
				,@UserId
				,@orderLogisticId
				,NULL
				,@plateNumber
				,NULL
				,@DeliveryPersonnelId
				,@OrderMovementId
				,@PlateNumberBy
				,1
				,@UserId
				,getdate()
		END

		---------------------------------------------------------------------------------Delivery-------------------------------------------------------------------------------------------------------------------------
		UPDATE [orderMovement]
		SET TransportOperatorId = @CarrierId
			,DeliveryPersonnelId = @DeliveryPersonnelId
			,UpdatedDate = GETDATE()
			,CreatedBy = @UserId
            ,PraposedShift = @proposedShift
		WHERE OrderId = @orderId AND LocationType = 2

		DECLARE @orderDLogisticId BIGINT
		DECLARE @OrderDMovementId BIGINT

		SET @OrderDMovementId = (
				SELECT TOP 1 OrderMovementId
				FROM OrderMovement
				WHERE OrderId = @orderId AND LocationType = 2
				)
		SET @orderDLogisticId = (
				SELECT TOP 1 OrderLogisticsId
				FROM [OrderLogistics]
				WHERE OrderMovementId = @OrderDMovementId
				)

		DECLARE @IsDPresentOrNot BIGINT

		SET @IsDPresentOrNot = (
				SELECT Count(OrderLogisticsId)
				FROM [OrderLogistics]
				WHERE OrderLogisticsId = @orderDLogisticId
				)

		IF @IsPresentOrNot = 0
		BEGIN
			INSERT INTO [dbo].[OrderLogistics] (
				[OrderMovementId]
				,[DeliveryPersonnelId]
				,[TruckPlateNumber]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @OrderDMovementId
				,@DeliveryPersonnelId
				,@plateNumber
				,1
				,@UserId
				,getdate()

			SELECT @orderLogisticId = @@IDENTITY

			INSERT INTO [dbo].[OrderLogisticHistory] (
				[OrderId]
				,[UserId]
				,[OrderLogisticId]
				,[TruckId]
				,[PlateNumber]
				,[TransportVehicleId]
				,[DeliveryPersonnelId]
				,[OrderMovementId]
				,PlateNumberBy
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @orderId
				,@UserId
				,@orderLogisticId
				,NULL
				,@plateNumber
				,NULL
				,@DeliveryPersonnelId
				,@OrderDMovementId
				,@PlateNumberBy
				,1
				,@UserId
				,getdate()
		END
		ELSE
		BEGIN
			UPDATE [OrderLogistics]
			SET TruckPlateNumber = @plateNumber
				,DeliveryPersonnelId = @DeliveryPersonnelId
				,UpdatedDate = GETDATE()
				,UpdateBy = @UserId
			WHERE OrderMovementId = @OrderDMovementId

			INSERT INTO [dbo].[OrderLogisticHistory] (
				[OrderId]
				,[UserId]
				,[OrderLogisticId]
				,[TruckId]
				,[PlateNumber]
				,[TransportVehicleId]
				,[DeliveryPersonnelId]
				,[OrderMovementId]
				,PlateNumberBy
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @orderId
				,@UserId
				,@orderLogisticId
				,NULL
				,@plateNumber
				,NULL
				,@DeliveryPersonnelId
				,@OrderDMovementId
				,@PlateNumberBy
				,1
				,@UserId
				,getdate()
		END

		

		UPDATE dbo.[Order]
		SET CurrentState = @CurrentState
			
		WHERE OrderId = @orderId

		--Added By Chetan Tambe (24 Sept 2019): For updating the gratis order status
		UPDATE dbo.[Order]
		SET CurrentState = @CurrentState
			
		WHERE OrderId in (select AssociatedOrder from OrderProduct where OrderProduct.OrderId = @orderId)
		
		update OrderMovement 
		set Location = (select LocationId From [Location]  where LocationCode=o.StockLocationId)
		from [order]  o join OrderMovement om  on o.OrderId= om.OrderId and om.LocationType=1
		where o.OrderId=@orderId  and om.OrderId=@orderId


		

		EXEC sp_xml_removedocument @intPointer
	END TRY

	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();

		RAISERROR (
				@ErrMsg
				,@ErrSeverity
				,1
				);

		RETURN;
	END CATCH
END








