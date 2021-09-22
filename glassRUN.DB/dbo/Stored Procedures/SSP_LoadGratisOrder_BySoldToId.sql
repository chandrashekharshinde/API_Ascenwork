CREATE PROCEDURE [dbo].[SSP_LoadGratisOrder_BySoldToId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><SalesOrderNumber>SO000114</SalesOrderNumber></Json>'

@xmlDoc XML='<Json></Json>'


AS
BEGIN

DECLARE @intPointer INT;
declare @CompanyId bigint
declare @ShipTo bigint



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],@ShipTo = tmp.[ShipTo]
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [ShipTo] bigint,
    [CompanyId] bigint
   )tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT 'true' AS [@json:Array]  , OrderId,
 OrderNumber,
 EnquiryId,
 ExpectedTimeOfDelivery,
 SoldTo,
 o.ShipTo,
 ModeOfDelivery,
 OrderType,
 PurchaseOrderNumber,
 SalesOrderNumber,
 PickNumber,
 o.Remarks,
 PreviousState,
 CurrentState,
 dl.LocationName,
 cl.LocationName as BranchPlantCode,
 Description1,
 Description2,
 o.CreatedDate,
  (select Top 1 LocationId from Location where LocationCode =  o.StockLocationId) as StockLocationId,
  (select Top 1 LocationCode from Location where LocationCode =  o.StockLocationId) as BranchPlantCode
 ,(select ExpectedTimeOfAction from OrderMovement where OrderId = o.OrderId and LocationType = 1) As PickingDate
 ,(select TruckPlateNumber from OrderLogistics where OrderId = o.OrderId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = o.OrderId and LocationType = 2)) As PlateNumber
   ,dl.CompanyID
   ,ts.[TruckCapacityWeight],
   ts.[TruckCapacityPalettes],   
   ts.[TruckSize],
   o.IsActive,
   'false' as IsTruckFull
   , (select cast ((SELECT  'true' AS [@json:Array]  ,  
   OrderProductId,
   OrderId,
   o.Description1,
   o.Description2,
   ProductCode,
   op.ProductType,
   ProductQuantity,
   i.ItemName,
   i.StockInQuantity,
   i.ItemId,
  (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM,
  (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UnitOfMeasureName,
  isnull((select top 1 ul.[ConversionFactor] from UnitOfMeasure ul where ul.UOM= i.PrimaryUnitOfMeasure and ul.RelatedUOM=17 and ul.ItemId= i.ItemId),0) as QtyPerLayer,
   UnitPrice,ShippableQuantity,BackOrderQuantity,CancelledQuantity,Remarks, op.CreatedDate,op.IsActive
   ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (i.ItemId)) as [WeightPerUnit]
 ,(SELECT [dbo].[fn_GetPriceOfItem] (i.[ItemId],dl.CompanyID)) as Amount
   ,umo.[ConversionFactor]
 from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
 join UnitOfMeasure umo on I.ItemId=umo.ItemId  
   WHERE op.IsActive = 1 AND op.OrderId = o.OrderId and  i.IsActive = 1 and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
 FOR XML path('OrderProductsList'),ELEMENTS) AS xml))
 FROM [dbo].[Order] o left join TruckSize ts on o.TruckSizeId = ts.TruckSizeId
 left join Location dl on o.ShipTo = dl.LocationId
 left join Location cl on o.StockLocationId = cl.LocationId
  WHERE o.OrderType in ('SG','S5','S6') and SoldTo=@CompanyId   --and ShipTo=@ShipTo
  and o.SalesOrderNumber is not null and o.CurrentState  not in (6,34,35 ,999,980) and
 
  o.IsActive=1 and o.OrderId not in (select ISNULL(ep.AssociatedOrder,0) from EnquiryProduct ep join Enquiry e on ep.EnquiryId=e.EnquiryId where ep.IsActive=1 and e.IsActive=1 and e.CurrentState in (1,8,2) and ep.IsActive=1)
 FOR XML path('OrderList'),ELEMENTS,ROOT('Order')) AS XML)


 
 
END
