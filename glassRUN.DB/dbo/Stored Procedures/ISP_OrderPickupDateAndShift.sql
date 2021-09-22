
CREATE PROCEDURE [dbo].[ISP_OrderPickupDateAndShift] 
	--'<Json><SalesOrderNumber>1079914409</SalesOrderNumber><OrderId>13208</OrderId><PraposedShift>1</PraposedShift><LocationType>1</LocationType> <ExpectedTimeOfDelivery>2019-06-24T00:00:00</ExpectedTimeOfDelivery><PickDateTime>2019-06-22T17:16:00</PickDateTime></Json>' 
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
		DECLARE @OrderId BIGINT
		DECLARE @SalesOrderNumber NVARCHAR(150)
		DECLARE @PraposedTimeOfAction DATETIME
		DECLARE @PraposedShift NVARCHAR(150)
		DECLARE @locationType NVARCHAR(150)
		DECLARE @expectedTimeOfDelivery NVARCHAR(150)
		DECLARE @pickDateTime NVARCHAR(150)
		DECLARE @UserId BIGINT

		EXEC sp_xml_preparedocument @intpointer OUTPUT
			,@xmlDoc

		SELECT @OrderId = tmp.[OrderId]
			,@SalesOrderNumber = tmp.[SalesOrderNumber]
			,@PraposedShift = tmp.[PraposedShift]
			,@locationType = tmp.[LocationType]
			,@UserId = tmp.[UserId]
			,@expectedTimeOfDelivery = tmp.ExpectedTimeOfDelivery
			,@pickDateTime = tmp.PickDateTime
		FROM OPENXML(@intpointer, 'Json', 2) WITH (
				[OrderId] BIGINT
				,[SalesOrderNumber] NVARCHAR(150)
				,[PraposedShift] NVARCHAR(150)
				,[LocationType] NVARCHAR(150)
				,[UserId] BIGINT
				,ExpectedTimeOfDelivery NVARCHAR(150)
				,PickDateTime NVARCHAR(150)
				) tmp
                print 'xml table created'
		DECLARE @orderMovementId BIGINT
		DECLARE @IsPresentOrNot BIGINT
		DECLARE @PlanNumber NVARCHAR(max)
		DECLARE @GroupNumber NVARCHAR(max)

		SELECT @PlanNumber = 'PL' + cast(@OrderId as nvarchar)

		SET @IsPresentOrNot = (
				SELECT Count(OrderMovementId)
				FROM OrderMovement
				WHERE OrderId = @OrderId
				)
                print @IsPresentOrNot
		IF @IsPresentOrNot = 0
		BEGIN
			SELECT @GroupNumber = 'C' + convert(NVARCHAR(max), @OrderId)

			-------------------------------------------------Collection--------------------------------------
			INSERT INTO [dbo].[orderMovement] (
				[OrderId]
				,LocationType
				,PraposedTimeOfAction
				,ExpectedTimeOfAction
				,PraposedShift
				,GroupName
				,PlanNumber
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @OrderId
				,1
				,cast(@pickDateTime as datetime)
				,cast(@pickDateTime as datetime)
				,@PraposedShift
				,@GroupNumber
				,@PlanNumber
				,1
				,@UserId
				,getdate()

			SELECT @orderMovementId = @@IDENTITY

            print 'done1'

			SELECT OrderProductId
				,ProductQuantity
				,ROW_NUMBER() OVER (
					ORDER BY OrderProductId
					) AS rownum
			INTO #tmpOrderProduct
			FROM dbo.[OrderProduct]
			WHERE OrderId = @OrderId

			DECLARE @orderProductId BIGINT
			DECLARE @quantity DECIMAL(18, 2)
			DECLARE @totalRecords BIGINT
			DECLARE @RecordCount BIGINT

			SELECT @RecordCount = 1

			SELECT @totalRecords = COUNT(OrderProductId)
			FROM #tmpOrderProduct

			WHILE (@RecordCount <= @totalRecords)
			BEGIN
				SELECT @orderProductId = OrderProductId
					,@quantity = ProductQuantity
				FROM #tmpOrderProduct
				WHERE rownum = @RecordCount

				INSERT INTO [dbo].OrderProductMovement (
					OrderId
					,OrderProductId
					,OrderMovementId
					,PlannedQuantity
					,ActualQuantity
					,[IsActive]
					,[CreatedBy]
					,[CreatedDate]
					)
				SELECT @orderId
					,@orderProductId
					,@orderMovementId
					,@quantity
					,NULL
					,1
					,1
					,GETDATE()
				FROM #tmpOrderProduct
				WHERE rownum = @totalRecords
                print 'done2'
				SET @RecordCount = @RecordCount + 1
			END

			SELECT @GroupNumber = 'D' + convert(NVARCHAR(max), @OrderId)

			------------------------------------------------------Delivery---------------------------------------------------------------------
			DECLARE @shipto BIGINT = 0

			SELECT @shipto = ShipTo
			FROM [order]
			WHERE OrderId = @OrderId

			INSERT INTO [dbo].[orderMovement] (
				[OrderId]
				,LocationType
				,Location
				,PraposedTimeOfAction
				,ExpectedTimeOfAction
				,PraposedShift
				,GroupName
				,PlanNumber
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				)
			SELECT @OrderId
				,2
				,@shipto
				,cast(@expectedTimeOfDelivery as datetime)
                ,cast(@expectedTimeOfDelivery as datetime)
				,@PraposedShift
				,@GroupNumber
				,@PlanNumber
				,1
				,@UserId
				,getdate()

			SELECT @orderMovementId = @@IDENTITY
            print 'done3'
			--SELECT OrderProductId,ProductQuantity,ROW_NUMBER() OVER (ORDER BY OrderProductId) AS rownum INTO #tmpOrderProduct1 FROM dbo.[OrderProduct] WHERE OrderId=@OrderId
			--DECLARE @orderProductId BIGINT
			--DECLARE @quantity DECIMAL(18,2)
			--DECLARE @totalRecords BIGINT
			--DECLARE @RecordCount BIGINT
			SELECT @RecordCount = 1

			SELECT @totalRecords = COUNT(OrderProductId)
			FROM #tmpOrderProduct

			WHILE (@RecordCount <= @totalRecords)
			BEGIN
				SELECT @orderProductId = OrderProductId
					,@quantity = ProductQuantity
				FROM #tmpOrderProduct
				WHERE rownum = @RecordCount

				INSERT INTO [dbo].OrderProductMovement (
					OrderId
					,OrderProductId
					,OrderMovementId
					,PlannedQuantity
					,ActualQuantity
					,[IsActive]
					,[CreatedBy]
					,[CreatedDate]
					)
				SELECT @orderId
					,@orderProductId
					,@orderMovementId
					,@quantity
					,NULL
					,1
					,1
					,GETDATE()
				FROM #tmpOrderProduct
				WHERE rownum = @totalRecords
                print 'done4'
				SET @RecordCount = @RecordCount + 1
			END
		END

		BEGIN
			PRINT 'done5'

			UPDATE [Order]
			SET Field3 = @PraposedTimeOfAction
			WHERE OrderId = @OrderId
		END

		EXEC sp_xml_removedocument @intPointer
	END TRY

	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();

		RAISERROR (
				@ErrMsg
				,@ErrSeverity
				,1
				);
                print error_line();
		RETURN;
	END CATCH
END
