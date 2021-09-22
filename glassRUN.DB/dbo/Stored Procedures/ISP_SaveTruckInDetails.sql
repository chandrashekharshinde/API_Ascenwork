

CREATE PROCEDURE [dbo].[ISP_SaveTruckInDetails]--'<Json><UserId>0</UserId><OrderId>0</OrderId><ServicesAction>CreateLog</ServicesAction><LogDescription>Empties Limit</LogDescription><LogDate>17/10/2017 13:41</LogDate></Json>'
@xmlDoc xml 
AS 
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
		Declare @PlateNumber nvarchar(50)
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @IsTruckInExists bigint
		Declare @truckId Bigint
		declare @TruckInDataTime datetime

	Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
			[PlateNumber] nvarchar(max) ,
			[StockLocationCode] nvarchar(max),
			[DriverId] bigint ,
			[TruckInDataTime] datetime ,
			[CarrierId] bigint ,
			[CreatedBy] bigint  ,
			[CreatedDate] datetime  
        )


		Select * into #tempTruckInOrderDeatils FROM OPENXML(@intpointer,'Json/OrderList',2)
        WITH
        (
		 [PlateNumber] nvarchar(100) ,
		 [TruckInDeatilsId] bigint ,
		 [OrderNumber] nvarchar(100) 
        )

		select top 1 @truckId= tr.TransportVehicleId,@TruckInDataTime=#tempTruckInDeatils.TruckInDataTime from TransportVehicle tr,#tempTruckInDeatils where tr.VehicleRegistrationNumber=#tempTruckInDeatils.PlateNumber and tr.TransporterId=#tempTruckInDeatils.CarrierId;


		if((select count(*) from TruckInDeatils where TruckId = (@truckId) and TruckInDeatils.TruckOutDataTime is null) = 0)

		BEGIN

			INSERT INTO	[dbo].[TruckInDeatils]
        (
			[PlateNumber]
			,[TruckId]
			,[DriverName]
			,[StockLocationCode]
			,[DriverId]
			,[TruckInDataTime]
			,[CarrierId]
			,[CreatedBy]
			,[CreatedDate]
			,[IsActive]
        )
	SELECT 
      (Select  top 1 tv.VehicleRegistrationNumber from TransportVehicle tv where tv.TransportVehicleId=@truckId)
      ,@truckId
      ,(Select  top 1 l.[Name] from [Login] l where l.LoginId=tmp.[DriverId])
	  ,tmp.[StockLocationCode]
      ,tmp.[DriverId]
      ,tmp.[TruckInDataTime]
      ,tmp.[CarrierId]
	  ,tmp.[CreatedBy]
      ,GETDATE()
      ,1
	  from #tempTruckInDeatils tmp

	      DECLARE @TruckInDeatilsId BIGINT


	    SET @TruckInDeatilsId = @@IDENTITY

	    INSERT INTO [dbo].[TruckInOrder]
           ([PlateNumber]
           ,[TruckInDeatilsId]
           ,[OrderNumber]
		   ,[TruckInDataTime]
           ,[CreatedDate])
	SELECT [PlateNumber]
           ,@TruckInDeatilsId
           ,[OrderNumber]
		   ,@TruckInDataTime
           ,GETDATE()
  from  #tempTruckInOrderDeatils




			set @IsTruckInExists = 0

		END
		ELSE
		BEGIN
			
			set @IsTruckInExists = 1

		END
            
			SELECT @IsTruckInExists as IsTruckInExists FOR XML RAW('Json'),ELEMENTS
			
			INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='TruckIn' and IsActive=1),'TruckIn',(@truckId),'TruckIn',1,1,GETDATE() 
        
 
  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
