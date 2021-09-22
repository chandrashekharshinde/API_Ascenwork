
CREATE PROCEDURE [dbo].[USP_TruckOutUpdate] 
@xmlDoc xml 
AS 
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	Declare @PlateNumber nvarchar(50)
	Declare @TruckOutDateTime datetime
	DECLARE @TruckInDeatilsId BIGINT
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DEclare @DriverId bigint

	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		 [PlateNumber] nvarchar(100) ,
		 [TruckInDeatilsId] bigint,
		 [ModifiedBy] bigint
        )

		Select * into #tempTruckInOrderDeatils FROM OPENXML(@intpointer,'Json/OrderList',2)
        WITH
        (
		 [TruckInDeatilsId] bigint,
		 [UserId] bigint,
		 OrderNumber nvarchar(100) ,
		 PlateNumber nvarchar(100) ,
		 TruckOutDataTime datetime
        )

		set @TruckOutDateTime=GETDATE();

		Update TruckInDeatils set @PlateNumber=TruckInDeatils.PlateNumber,@DriverId=DriverId,@TruckInDeatilsId=tmp.[TruckInDeatilsId],TruckOutDataTime=@TruckOutDateTime,ModifiedDate=GETDATE(),ModifiedBy=tmp.[ModifiedBy] from #tempTruckInDeatils tmp where tmp.[TruckInDeatilsId]=TruckInDeatils.[TruckInDeatilsId]

		update TruckInOrder set TruckOutDataTime=@TruckOutDateTime where TruckInDeatilsId=@TruckInDeatilsId

		declare @previousState bigint
		declare @orderId bigint
		  Select @previousState=CurrentState,@orderId=OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)

		--------------Record History----------------------------------
		INSERT INTO [dbo].[OrderMovementHistory]
           ([OrderMovementId]
           ,[OrderId]
           ,[TransportOperatorId]
           ,[DeliveryPersonnelId]
           ,[Location]
           ,[LocationType]
           ,[Action]
           ,[State]
           ,[StartTime]
           ,[PraposedTimeOfAction]
           ,[PraposedShift]
           ,[ExpectedTimeOfAction]
           ,[ExpectedShift]
           ,[ActualTimeOfAction]
           ,[Latitude]
           ,[Longitude]
           ,[GroupName]
           ,[GroupRouteCode]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[UpdateBy]
           ,[UpdatedDate]
           ,[OrderMovmentGuid]
           ,[IsUnloadGroup]
           ,[IsMarkedDraft]
           ,[PlanNumber])
    Select 
           [OrderMovementId]
           ,[OrderId]
           ,[TransportOperatorId]
           ,[DeliveryPersonnelId]
           ,[Location]
           ,[LocationType]
           ,[Action]
           ,[State]
           ,[StartTime]
           ,[PraposedTimeOfAction]
           ,[PraposedShift]
           ,[ExpectedTimeOfAction]
           ,[ExpectedShift]
           ,[ActualTimeOfAction]
           ,[Latitude]
           ,[Longitude]
           ,[GroupName]
           ,[GroupRouteCode]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)
           ,GETDATE()
           ,[OrderMovmentGuid]
           ,[IsUnloadGroup]
           ,[IsMarkedDraft]
           ,[PlanNumber]
		   From [dbo].[OrderMovement] where OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId))

		INSERT INTO [dbo].[OrderLogisticHistory]
           ([OrderId]
           ,[UserId]
           ,[OrderLogisticId]
           ,[TruckId]
           ,[PlateNumber]
           ,[DeliveryPersonnelId]
           ,[OrderMovementId]
           ,[DeliveryPersonName]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[IsActive])
Select @orderId
      ,(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)
	  ,[OrderLogisticsId]
	  ,[TruckId]
	 ,[TruckPlateNumber]
      ,[DeliveryPersonnelId]
	,[OrderMovementId]
      ,[DeliveryPersonName]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdateBy]
      ,[UpdatedDate]
	 ,[IsActive]

  FROM [dbo].[OrderLogistics] where OrderMovementId in (
		Select OrderMovementId from OrderMovement where OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)))






		-----------------------------------------------------------------






		Update OrderLogistics set DeliveryPersonnelId=@DriverId,TruckPlateNumber=@PlateNumber where OrderMovementId in (
		Select OrderMovementId from OrderMovement where OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)))

		Update OrderMovement set DeliveryPersonnelId=@DriverId where OrderMovementId in (
		Select OrderMovementId from OrderMovement where OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)))

		Update [Order] set PreviousState = @previousState, CurrentState = 720, ModifiedDate=GETDATE(),ModifiedBy=(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)
		where OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId))
		
		--Added By Vinod Dubey (10 Oct 2019): For updating the gratis order status
		UPDATE dbo.[Order]
		SET CurrentState = 720
		WHERE OrderId in (select AssociatedOrder from OrderProduct where OrderProduct.OrderId in (
		Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)) and ISNULL(AssociatedOrder,0) != 0)

		INSERT INTO [dbo].[WorkFlowActivityLog]
		([LoginId]
		,[RoleId]
		,[EnquiryId]
		,[EnquiryNumber]
		,[OrderId]
		,[OrderNumber]
		,[WorkFlowCode]
		,[WorkFlowCurrentStatusCode]
		,[WorkFlowCurrentActivityName]
		,[WorkFlowPreviousStatusCode]
		,[WorkFlowPreviousActivityName]
		,[RawData]
		,[IsIsAutomated] 
		,[ProcessOutputResponse] 
		,[Username] 
		,[CreatedBy]
		,[ActivityStartTime] 
		,[ActivityEndTime] 
		,[CreatedDate])

		VALUES(
		(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)
		,(select top 1 l.Rolemasterid from [Login] l where l.LoginId=(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils))
		,0
		,''
		,(Select OrderId from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId))
		,(Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)
		,'PSFMLMWF'
		,720
		,'Truck Out'
		,@previousState
		,''
		,convert(nvarchar(max),@xmlDoc)
		,0 
		,'"{}"' 
		,case when (select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils) =0 then 'Automated Rule Engine' 
		else (select top 1 l.UserName from [Login] l where l.LoginId=(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)) end
		,(select top 1 #tempTruckInDeatils.[ModifiedBy] from #tempTruckInDeatils)
		,GETDATE()
		,GETDATE()
		,GETDATE()
		)
		
		
		
		
		
		Declare @checkSelfCollect nvarchar(50)
		SET @checkSelfCollect=(Select Field1 from Location where LocationId in ( select ShipTo from [Order] where OrderNumber in (Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)))
		If @checkSelfCollect='SCO'
		BEGIN
			INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='TruckOutSelfCollect' and IsActive=1),'TruckOutSelfCollect',OrderId,'Order',1,1,GETDATE() from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='TruckOut' and IsActive=1),'TruckOut',OrderId,'Order',1,1,GETDATE() from [Order] Where OrderNumber in (
		Select OrderNumber from TruckInOrder where TruckInDeatilsId=@TruckInDeatilsId)
		END

		

		

		

           
        
    SELECT @TruckInDeatilsId as TruckInDeatilsId FOR XML RAW('Json'),ELEMENTS
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END