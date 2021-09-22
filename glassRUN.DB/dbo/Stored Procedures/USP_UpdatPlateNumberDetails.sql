CREATE PROCEDURE [dbo].[USP_UpdatPlateNumberDetails] --'<Json><TotalCount>2</TotalCount><SalesOrderNumber>So0001</SalesOrderNumber><ShipTo>DeliveryLocation1</ShipTo><SoldTo>DeliveryLocation1</SoldTo><TruckSize>TZ1</TruckSize><ExpectedTimeOfDelivery>2017-07-07T00:00:00</ExpectedTimeOfDelivery><CurrentState>4</CurrentState><_x0024__x0024_hashKey>object:134</_x0024__x0024_hashKey><PlateNumber>54466464</PlateNumber></Json>'
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



		DECLARE @SalesOrderNumber nvarchar(150)
		DECLARE @pickingDate nvarchar(150)
		DECLARE @plateNumber nvarchar(150)
		Declare @pickingShift nvarchar(150)
		DECLARE @locationType nvarchar(150)
		DECLARE @ShipmentNumber nvarchar(250)
		Declare @orderLogistics bigint
		Declare @orderMovementId bigint
		DECLARE @userId bigint
			DECLARE @LoadNumber nvarchar(250)

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
				@pickingDate=tmp.[PickingDate],
				@pickingShift = tmp.[pickingShift],
				@plateNumber=tmp.[PlateNumber],
				@locationType=tmp.[LocationType],
				@ShipmentNumber=tmp.[ShipmentNumber],
				@LoadNumber=tmp.[LoadNumber],
				@userId=tmp.UserId
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SalesOrderNumber] NVARCHAR(50),
			[PickingDate] nvarchar(50),
			[pickingShift] nvarchar(50),
			[PlateNumber] nvarchar(50),
			[LocationType] nvarchar(50),
			[ShipmentNumber] nvarchar(250),
			[LoadNumber] nvarchar(50),
			UserId bigint

			)tmp 
					

            DECLARE @orderId BIGINT


			SET @orderId=(SELECT OrderId FROM [ORDER] WHERE SalesOrderNumber=@SalesOrderNumber)

			SET @orderMovementId=(SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)

			SET @orderLogistics=(SELECT OrderLogisticsId FROM [OrderLogistics] WHERE ordermovementid=(SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType))

			
			UPDATE [orderMovement] SET ExpectedTimeOfAction= convert(datetime,@pickingDate, 103),
			                           ExpectedShift= @pickingShift,
			                           UpdatedDate = GETDATE(),
									   CreatedBy = @UserId
			WHERE OrderId=@orderId AND LocationType=@locationType


			UPDATE [OrderLogistics] SET [TruckPlateNumber]=@plateNumber 
			WHERE ordermovementid = (SELECT ordermovementid FROM OrderMovement 
			WHERE OrderId=@orderId AND LocationType=@locationType)
				

				-----------------update load number ----
			update [order] set LoadNumber = @LoadNumber where OrderId=@orderId
		
			INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
			[TransportVehicleId],[DeliveryPersonnelId],[OrderMovementId],[IsActive],[CreatedBy],[CreatedDate])

            SELECT @orderId,@userId,@orderLogistics,NULL,@plateNumber,NULL,NULL,@orderMovementId,1,1,getdate()
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
