

CREATE PROCEDURE [dbo].[SSP_LoadOrderProduct_ByOrderId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>42</OrderId><RoleId>4</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @orderId nvarchar(100)
declare @roleId BIGINT
declare @CultureId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId],
       @roleId = tmp.[RoleId],
       @CultureId = tmp.[CultureId]
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [OrderId] bigint,
    [RoleId] bigint,
    [CultureId] bigint
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT OrderId,OrderNumber,
 
 EnquiryId,CONVERT(varchar(11),ExpectedTimeOfDelivery,103) as ExpectedTimeOfDelivery,SoldTo,o.ShipTo,
   
  o.NumberOfPalettes,
   o.TruckWeight,
  (SELECT [dbo].[fn_RoleWiseStatus] (@roleId,o.CurrentState,@CultureId)) AS 'Status',
  (SELECT [dbo].[fn_RoleWiseClass] (@roleId,o.CurrentState)) AS 'Class',
 ModeOfDelivery,OrderType,PurchaseOrderNumber,SalesOrderNumber,PickNumber,
 o.Remarks,PreviousState,CurrentState,dl.LocationName, 
 o.CreatedDate,
 o.[TruckSizeId],
 ISNULL(o.GratisCode,0) as GratisCode,

  (select Top 1 LocationId from Location where LocationCode =  o.StockLocationId and IsActive = 1) as StockLocationId
  ,(select top 1 Note from Notes where objectId = o.OrderId and ObjectType = 1221 and RoleId in (select RoleId from NotesRoleWiseConfiguration where ViewNotesByRoleId = @roleId and ObjectType = 1221)) as Note
  ,(select Top 1 LocationName from Location where LocationCode =  o.StockLocationId) as BranchPlant
 
 
 ,o.OrderDate
   
   ,(Select CompanyMnemonic from Company where companyid=dl.CompanyID) as CompanyMnemonic,
   o.IsActive,
   
      
    (select cast ((SELECT  'true' AS [@json:Array]  ,  op.OrderProductId,op.OrderId,ProductCode,op.ProductType,ProductQuantity,i.ItemName,
 
   i.ItemId,

        (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as PrimaryUnitOfMeasure,
     (SELECT [dbo].[fn_LookupValueById] (op.ProductType)) as ProductTypeName,

   ShippableQuantity,BackOrderQuantity,CancelledQuantity,Remarks, op.CreatedDate,op.IsActive,  ISNULL(op.AssociatedOrder,0) as AssociatedOrder
   ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (i.ItemId)) as [WeightPerUnit]
    
    
   ,ISNULL((op.UnitPrice * op.ProductQuantity),0) as ItemPrices,
   ISNULL(op.UnitPrice,0) as UnitPrice
    ,isnull(op.DepositeAmount,0) as DepositeAmount 
    ,ISNULL(op.DepositeAmount,0) as DepositeAmountPerUnit,
    ISNULL(op.AssociatedOrder,0) as GratisOrderId,
     ISNULL((op.DepositeAmount * op.ProductQuantity),0) as ItemTotalDepositeAmount,
     op.ItemType,
	 ISNULL(op.SignalValue,'') as SignalValue,
	 ISNULL(op.IsPackingItem,0) as IsPackingItem,
	 Convert(bigint,ISNULL((select PlannedQuantity from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)),0)) as CollectionPlannedQuantity,
	 Convert(bigint,ISNULL((select ActualQuantity from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)),0)) as CollectionDeliveredQuantity,

	 Convert(bigint,ISNULL((select PlannedQuantity from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)),0)) as DeliveryPlannedQuantity,
	 Convert(bigint,ISNULL((select ActualQuantity from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)),0)) as DeliveryDeliveredQuantity,


	 (select DeliveryStartTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)) as CollectionStartTime,
	 (select DeliveryEndTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)) as CollectionEndTime,
	 --convert(char(8),dateadd(s,datediff(s,ISNULL((select DeliveryStartTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)),'1900-1-1'),ISNULL((select DeliveryEndTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1)),'1900-1-1')),'1900-1-1'),8) as TotalCollectionTime,
	 (select DeliveryStartTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)) as DeliveryStartTime,
	 (select DeliveryEndTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)) as DeliveryEndTime,
	 --convert(char(8),dateadd(s,datediff(s,ISNULL((select DeliveryStartTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)),'1900-1-1'),ISNULL((select DeliveryEndTime from OrderProductMovement where OrderProductId = op.OrderProductId and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2)),'1900-1-1')),'1900-1-1'),8) as TotalDeliveryTime,

	 (select ExpectedTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1) as PlannedCollectionDate,
	 (select ActualTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1) as ActualCollectionDate,
	 --convert(char(8),dateadd(s,datediff(s,ISNULL((select ExpectedTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1),'1900-1-1'),ISNULL((select ActualTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 1),'1900-1-1')),'1900-1-1'),8) as OrderCollectionTime,
	 (select ExpectedTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2) as PlannedDeliveryDate,
	 (select ActualTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2) as ActualDeliveryDate,
	 --convert(char(8),dateadd(s,datediff(s,ISNULL((select ExpectedTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2),'1900-1-1'),ISNULL((select ActualTimeOfAction from OrderMovement where OrderId = op.OrderId and op.IsActive = 1 and LocationType = 2),'1900-1-1')),'1900-1-1'),8) as OrderDeliveryTime,




      (select cast ((SELECT  'true' AS [@json:Array]  ,  OrderDocumentId
							,OrderId
							,DocumentTypeId
							,(SELECT dbo.fn_LookupValueById(DocumentTypeId)) as 'DocumentType'
							,DocumentFormat
							,DocumentDescription
FROM OrderDocument  WHERE  OrderProductId = op.OrderProductId and (OrderProductId is not null or OrderProductId <> 0)
order by DocumentTypeId 
 FOR XML path('OrderDocumentList'),ELEMENTS) AS xml))

  from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
  WHERE op.IsActive = 1 AND op.OrderId = o.OrderId 
 FOR XML path('OrderProductsList'),ELEMENTS) AS xml))

 FROM [dbo].[Order] o left join TruckSize ts on o.TruckSizeId = ts.TruckSizeId
 left join [Location] dl on o.ShipTo = dl.LocationId
 
 
  WHERE (OrderId = @orderId OR @orderId = '') AND o.IsActive=1
 FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END
