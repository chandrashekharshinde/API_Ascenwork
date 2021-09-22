

CREATE View [dbo].[OrderTruckInTruckOutView]    AS
	Select o.orderid, (SELECT top 1 TruckPlateNumber FROM [dbo].orderlogistics WHERE ordermovementid IN (SELECT OrderMovementId FROM [dbo].OrderMovement WHERE OrderId=o.OrderId AND LocationType=1)) AS PlateNumber,

	    ISNULL((SELECT TOP 1 PlateNumber From (select Top 1 PlateNumber,OrderLogistichistoryId from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'Carrier'   ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId),
	  (SELECT TOP 1 PlateNumber From (select Top 1 PlateNumber,OrderLogistichistoryId from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckOut'  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId)) as PreviousPlateNumber,	 	 

	  (SELECT TOP 1 PlateNumber From (select Top 1 PlateNumber,OrderLogistichistoryId from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckIn'  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckInPlateNumber,
	  (SELECT TOP 1 PlateNumber From (select Top 1 PlateNumber,OrderLogistichistoryId from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckOut'  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckOutPlateNumber,
	  (select TruckInTime from [dbo].OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from [dbo].OrderMovement where OrderId=o.OrderId)) as TruckInDateTime,
	  	 (select TruckOutTime from [dbo].OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from [dbo].OrderMovement where OrderId=o.OrderId)) as TruckOutDateTime,
	 (select top 1 carriernumber from [dbo].route where destinationid=o.ShipTo) as CarrierNumber,
	 (Select CompanyMnemonic From [dbo].Company  where CompanyId in (select CarrierNumber from [dbo].Route where DestinationId=o.ShipTo 
      and OriginId=(select top 1 LocationId from [dbo].Location where  TruckSizeId= o.TruckSizeId)) and CompanyType=28) as CarrierNumberValue,
	 (select top 1 remark from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy <> 'Carrier' ORDER BY OrderLogistichistoryId DESC) as TruckRemark,
	  ((Select Name from [dbo].Login where LoginId in (select DeliveryPersonnelId from [dbo].OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from [dbo].OrderMovement where OrderId=o.OrderId)))) as DriverName
	 from [dbo].[Order] o
