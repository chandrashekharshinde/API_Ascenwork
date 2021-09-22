

CREATE PROCEDURE [dbo].[SSP_GetPendingOrderList] --'<Json><ServicesAction>GetPendingOrderList</ServicesAction><PlateNumber>ZAP 007</PlateNumber><StockLocationCode>6432</StockLocationCode><DriverId>10600</DriverId><TruckInDeatilsId>10</TruckInDeatilsId><CarrierId>663</CarrierId></Json>'
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

	Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [PlateNumber] nvarchar(100) ,
			[TruckId] bigint ,
			[DriverName] nvarchar(500) ,
			[StockLocationCode] nvarchar(100),
			[DriverId] bigint ,
			[TruckInDataTime] datetime ,
			[CreatedBy] bigint  ,
			[CreatedDate] datetime,
			[CarrierId] bigint  
        )


--select * from #tempTruckInDeatils
DECLARE @TruckInDeatilsId BIGINT
DECLARE @StockLocationCode nvarchar(max)
DECLARE @CarrierId bigint

SELECT @PlateNumber=tmp.[PlateNumber], @CarrierId = tmp.[CarrierId],@StockLocationCode=tmp.[StockLocationCode] from #tempTruckInDeatils tmp

--Changed By Chetan(30/08/2019) : This is added to only show the order which are truck in from that specific branch plant only.
--Changed By Vinod (30/09/2019)
--set @StockLocationCode = (select StockLocationCode from TruckInDeatils where PlateNumber = @PlateNumber and TruckInDeatils.TruckOutDataTime is null)

SET @TruckInDeatilsId = @@IDENTITY
        

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array],@TruckInDeatilsId as TruckInDeatilsId,
	[OrderId]
      ,[OrderNumber]
      ,[ModifiedDate]
      ,[TotalPrice]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[OrderDate]
      ,[LocationName]
      ,[DeliveryLocation]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,[SupplierName]
      ,[SupplierCode]
      ,[CarrierNumberValue]
      ,[BranchPlantName]
      ,[BranchPlantCode]
      ,[DeliveryLocationBranchName]
      ,[PlateNumberData]
      ,[DeliveryPersonName]
      ,[PlateNumber]
      ,[PreviousPlateNumber]
      ,[DriverName]
      ,[CarrierNumber]
      ,[TruckRemark]
      ,[DeliveredDate]
      ,[PlanCollectionDate]
      ,[PlanDeliveryDate]
	  ,[PickDateTimeFromOM] --Column Added By Chetan(30/08/2019) : To show in order list.
	  ,ISNULL((Select isnull(tio.IsLoadedInTruck,0) from TruckInOrder tio Where tio.OrderNumber = o.OrderNumber and tio.PlateNumber = @PlateNumber),0) As IsLoadedInTruck --Changed by Chetan Tambe (25 Sept 2019)
      ,(select cast ((SELECT  'true' AS [@json:Array]  ,  t1.OrderId,t1.OrderProductId,t1.ItemType,ProductCode,isnull(t1.LotNumber,t1.OrderProductId) as LotNumber,isnull(ProductQuantity,0) as Quantity,isnull(CollectedQuantity,0) as CollectedQuantity ,isnull(DeliveredQuantity,0) as DeliveredQuantity
		FROM OrderProduct t1 
		WHERE t1.IsActive=1 and t1.OrderId=o.OrderId
      FOR XML path('ProductLotInfo'),ELEMENTS) AS xml))
	  
FROM [dbo].[OrderGridViewNew] o where 
o.BranchPlantCode in (SELECT ID FROM [dbo].[fnSplitValuesForNvarchar] (@StockLocationCode )) 
--Changed By Chetan Tambe (25 Sept 2019) : For only showing not assigned orders
--and o.OrderNumber not in (Select tio.OrderNumber from TruckInOrder tio Where tio.TruckOutDataTime is not null)
and o.OrderNumber not in (Select tio.OrderNumber from TruckInOrder tio Where tio.PlateNumber != @PlateNumber)
--and o.CurrentState in ( 525,539,560,995) 
and (o.PlateNumber = @PlateNumber  or o.BranchPlantCode in (SELECT ID FROM [dbo].[fnSplitValuesForNvarchar] (@StockLocationCode )) 
--or o.TruckSizeId in (Select tz.TruckSizeId from TruckSize tz 
--join TransportVehicle tv on tz.TruckSizeId=tv.TruckSizeId 
--where tv.VehicleRegistrationNumber=@PlateNumber and Isnull(tz.TruckCapacityWeight,0) !=0 and Isnull(tz.TruckCapacityWeight,0) =Isnull(o.TruckCapacityWeight,0))
)
and o.OrderId in (Select OrderId from OrderMovement where ActualTimeOfAction is null)
and o.CurrentState not in (980,720)--Add by vinod yadav on 30-09-2019 720 from truckout 
and o.CarrierNumber = @CarrierId
--and convert(date, o.PlanCollectionDate, 103) = convert(date, GETDATE(), 103) --Added by Chetan Tambe (25 Sept 2019)
order by o.ProposedShift, o.PickDateTimeFromOM, o.OrderDate Asc
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)


  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
