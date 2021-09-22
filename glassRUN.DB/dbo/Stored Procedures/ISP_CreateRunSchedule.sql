CREATE PROCEDURE [dbo].[ISP_CreateRunSchedule]--'<Json><OrderMovementList><RunNumber>011142</RunNumber><FromBranchPlantCode>1104</FromBranchPlantCode><OrderId>143</OrderId><OrderMovementGuid>aea76a82-816c-461a-ac73-f50bd60b9800</OrderMovementGuid><LocationType>1</LocationType><OrderMovementDatetime>2018-07-27T05:19:00</OrderMovementDatetime><DriverId>8</DriverId><TruckPlateNumber>T1234</TruckPlateNumber><TransportVehicleId>0</TransportVehicleId><TransportOperatorId>9</TransportOperatorId><OrderProductMovementList><OrderMovementGuid>aea76a82-816c-461a-ac73-f50bd60b9800</OrderMovementGuid><ProductCode>154103</ProductCode><OrderId>143</OrderId><OrderProductId>237</OrderProductId><ProductQuantity>48</ProductQuantity></OrderProductMovementList></OrderMovementList><OrderMovementList><RunNumber>011142</RunNumber><FromBranchPlantCode>1101</FromBranchPlantCode><OrderId>143</OrderId><OrderMovementGuid>9bc9bf36-d423-4387-8967-d0d2f2bb9a0a</OrderMovementGuid><LocationType>1</LocationType><OrderMovementDatetime>2018-07-27T05:19:00</OrderMovementDatetime><DriverId>8</DriverId><TruckPlateNumber>T1234</TruckPlateNumber><TransportVehicleId>0</TransportVehicleId><TransportOperatorId>9</TransportOperatorId><OrderProductMovementList><OrderMovementGuid>9bc9bf36-d423-4387-8967-d0d2f2bb9a0a</OrderMovementGuid><ProductCode>152121</ProductCode><OrderId>143</OrderId><OrderProductId>236</OrderProductId><ProductQuantity>5</ProductQuantity></OrderProductMovementList></OrderMovementList><OrderMovementList><RunNumber>011142</RunNumber><FromBranchPlantCode>1101</FromBranchPlantCode><OrderId>143</OrderId><OrderMovementGuid>9027126d-8ff0-473d-a2c9-fb7699e4f9e7</OrderMovementGuid><LocationType>1</LocationType><OrderMovementDatetime>2018-07-27T05:19:00</OrderMovementDatetime><DriverId>8</DriverId><TruckPlateNumber>T1234</TruckPlateNumber><TransportVehicleId>0</TransportVehicleId><TransportOperatorId>9</TransportOperatorId><OrderProductMovementList><OrderMovementGuid>9027126d-8ff0-473d-a2c9-fb7699e4f9e7</OrderMovementGuid><ProductCode>154103</ProductCode><OrderId>143</OrderId><OrderProductId>237</OrderProductId><ProductQuantity>6</ProductQuantity></OrderProductMovementList></OrderMovementList><OrderMovementList><RunNumber>011143</RunNumber><ShipTo>18</ShipTo><OrderId>143</OrderId><OrderMovementGuid>2b6645b7-65a1-487a-aa47-4d7d2234aeef</OrderMovementGuid><DriverId>8</DriverId><TruckPlateNumber>T1234</TruckPlateNumber><TransportVehicleId>0</TransportVehicleId><TransportOperatorId>9</TransportOperatorId><LocationType>2</LocationType><OrderMovementDatetime>2018-07-31T00:00:00</OrderMovementDatetime><OrderProductMovementList><OrderMovementGuid>2b6645b7-65a1-487a-aa47-4d7d2234aeef</OrderMovementGuid><ProductCode>152121</ProductCode><OrderId>143</OrderId><ProductQuantity>5.00</ProductQuantity></OrderProductMovementList><OrderProductMovementList><OrderMovementGuid>2b6645b7-65a1-487a-aa47-4d7d2234aeef</OrderMovementGuid><ProductCode>154103</ProductCode><OrderId>143</OrderId><ProductQuantity>54.00</ProductQuantity></OrderProductMovementList></OrderMovementList></Json>'
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


			SELECT * INTO #tmpOrderMovementList
	FROM OPENXML(@intpointer,'Json/OrderMovementList',2)
	WITH
	(
	RunNumber nvarchar(500),
	[FromBranchPlantCode] nvarchar(500),
	[ShipTo] bigint,
	[OrderId] bigint,
	[OrderMovementGuid] nvarchar(500),
	[LocationType] bigint,
	[OrderMovementDatetime] datetime,
	DriverId bigint,
	[TruckPlateNumber]  nvarchar(500),
	[TransportVehicleId] bigint,
	[TransportOperatorId] bigint,
	[IsMarkedDraft] bit,
	[PlanNumber] nvarchar(500)
		
	)tmp



	SELECT * INTO #tmpOrderProductMovementList
	FROM OPENXML(@intpointer,'Json/OrderMovementList/OrderProductMovementList',2)
	WITH
	(
		
		ProductQuantity decimal(18,2),
		[ProductCode] nvarchar(500),
		[OrderMovementGuid] nvarchar(500),
		OrderId  bigint,
		OrderProductId  bigint
		
	)tmp








  
  --- insert order movement  for Collection Run

   INSERT INTO [dbo].[OrderMovement] ( [OrderId] ,[TransportOperatorId] ,[DeliveryPersonnelId] ,[Location] ,[LocationType] ,[Action] ,[State] ,[ExpectedTimeOfAction] ,[ActualTimeOfAction] ,[IsActive] ,[CreatedBy] ,[CreatedDate] ,[GroupName] ,[GroupRouteCode] , [OrderMovmentGuid],[IsMarkedDraft],[PlanNumber])
   SELECT #tmpOrderMovementList.[OrderId] ,#tmpOrderMovementList.[TransportOperatorId]  ,#tmpOrderMovementList.[DriverId] ,(select  DeliveryLocationId  From DeliveryLocation  where DeliveryLocationCode=#tmpOrderMovementList.FromBranchPlantCode) ,1 ,6000 ,NULL ,#tmpOrderMovementList.[OrderMovementDatetime] ,NULL ,1,1 ,GETDATE()[CreatedDate] ,#tmpOrderMovementList.RunNumber,NULL ,#tmpOrderMovementList.OrderMovementGuid,#tmpOrderMovementList.[IsMarkedDraft],#tmpOrderMovementList.[PlanNumber]
    FROM #tmpOrderMovementList   where #tmpOrderMovementList.LocationType =1 
	

	--- insert order movement  for Delivery Run
	
	INSERT INTO [dbo].[OrderMovement] ( [OrderId] ,[TransportOperatorId] ,[DeliveryPersonnelId] ,[Location] ,[LocationType] ,[Action] ,[State] ,[ExpectedTimeOfAction] ,[ActualTimeOfAction] ,[IsActive] ,[CreatedBy] ,[CreatedDate] ,[GroupName] ,[GroupRouteCode] , [OrderMovmentGuid],[IsMarkedDraft],[PlanNumber])
   SELECT #tmpOrderMovementList.[OrderId] ,#tmpOrderMovementList.[TransportOperatorId]  ,#tmpOrderMovementList.[DriverId] ,(select  DeliveryLocationId  From DeliveryLocation  where DeliveryLocationId=#tmpOrderMovementList.ShipTo) ,2 ,6001 ,NULL ,#tmpOrderMovementList.[OrderMovementDatetime] ,NULL ,1,1 ,GETDATE()[CreatedDate] ,#tmpOrderMovementList.RunNumber,NULL ,#tmpOrderMovementList.OrderMovementGuid,#tmpOrderMovementList.[IsMarkedDraft],#tmpOrderMovementList.[PlanNumber]
    FROM #tmpOrderMovementList   where #tmpOrderMovementList.LocationType =2   

 

 
	---insert Order Product movement -----


	
	INSERT INTO dbo.OrderProductMovement ( OrderId , OrderProductId , OrderMovementId , PlannedQuantity , IsActive, CreatedBy )
	select op.orderid , op.OrderProductId , (select  top 1  OrderMovementId  From OrderMovement  where OrderMovement.OrderMovmentGuid=#tmpOrderProductMovementList.OrderMovementGuid) , #tmpOrderProductMovementList.ProductQuantity , 1 ,1
	from   #tmpOrderProductMovementList  left join   OrderProduct  op 
	on op.OrderProductId =#tmpOrderProductMovementList.OrderProductId  and op.OrderId=#tmpOrderProductMovementList.OrderId


	----Insert order Logistices

	INSERT INTO [dbo].[OrderLogistics] ( [TransportVehicleId] ,[DeliveryPersonnelId] ,[OrderMovementId] ,[TruckId] ,TruckPlateNumber,[IsActive] ,[CreatedBy] ,[CreatedDate] ) 
	SELECT #tmpOrderMovementList.[TransportVehicleId] ,#tmpOrderMovementList.[DriverId] , (select  top 1  OrderMovementId  From OrderMovement  where OrderMovement.OrderMovmentGuid=#tmpOrderMovementList.OrderMovementGuid) , #tmpOrderMovementList.[TransportVehicleId],#tmpOrderMovementList.TruckPlateNumber ,1 ,1 ,GETDATE()
	FROM #tmpOrderMovementList   



update [Order] set  PreviousState=CurrentState,CurrentState=104   where OrderId in (SELECT   OrderId from #tmpOrderMovementList)

  
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
