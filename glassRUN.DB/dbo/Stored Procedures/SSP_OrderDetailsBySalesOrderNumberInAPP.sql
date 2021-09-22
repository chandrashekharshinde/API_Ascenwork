

CREATE PROCEDURE [dbo].[SSP_OrderDetailsBySalesOrderNumberInAPP]  --'<Json><ServicesAction>GetOrderDetailsBySalesOrderNumber</ServicesAction><soNumber>026848</soNumber><RoleId>4</RoleId><CultureId>1101</CultureId></Json>'
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
Declare @OrderId nvarchar(max)=''
declare @roleId BIGINT
declare @CultureId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @OrderId = tmp.[OrderId],
 @roleId = tmp.[RoleId],
       @CultureId = tmp.[CultureId]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] nvarchar(max),
			[RoleId] bigint,
			[CultureId] bigint
			)tmp;

			


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT o.OrderId,OrderNumber,
 (case when  o.HoldStatus IS null or  o.HoldStatus ='' then '-' else o.HoldStatus end) as HoldStatus,
 o.EnquiryId,CONVERT(varchar(11),ExpectedTimeOfDelivery,103) as ExpectedTimeOfDelivery,
 o.SoldTo,
 o.ShipTo,
 e.EnquiryAutoNumber,
 e.EnquiryDate,
 ISNULL(o.ExpectedTimeOfDelivery,'') as RequestDate,
 (SELECT [dbo].[fn_RoleWiseStatus] (@roleId,o.CurrentState,@CultureId)) AS 'Status',
 (SELECT [dbo].[fn_RoleWiseClass] (@roleId,o.CurrentState)) AS 'Class',
 ModeOfDelivery,OrderType,PurchaseOrderNumber,SalesOrderNumber,PickNumber,
 o.Remarks,o.PreviousState,
 o.CurrentState,dl.LocationName, 
 o.CreatedDate,
 bp.LocationName as BranchPlant
,o.OrderDate
,dl.LocationCode
,ISNULL(dl.AddressLine1,'') + ' ' + ISNULL(dl.AddressLine2,'') + ' ' + ISNULL(dl.AddressLine3,'') + ' ' +
ISNULL(dl.AddressLine4,'') + ' ' + ISNULL((select CityName from City where CityId = dl.City),'') + ' ' + ISNULL((select StateName from [State] where StateId = dl.[State]),'') + ' ' + ISNULL(dl.Pincode,'') as LocationAddress
,c.CompanyMnemonic as CompanyMnemonic


 ,om.ExpectedTimeOfAction as PlannedExpectedTimeOfAction
 ,om.ActualTimeOfAction as PlannedActualTimeOfAction

 ,ISNULL(om2.ExpectedTimeOfAction,'') as DeliveredExpectedTimeOfAction
 ,ISNULL(om2.ActualTimeOfAction,'') as DeliveredActualTimeOfAction

,(select COUNT(OrderProductId) from OrderProduct where OrderId = o.OrderId and IsActive = 1 and IsPackingItem <> 1) as TotalProductCounts

,(select SUM(ISNULL(PlannedQuantity,0)) from OrderProductMovement where OrderproductId not in (select OrderProductId from OrderProduct where OrderId = o.OrderId and IsActive = 1 and ProductCode = '55909001') and OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = o.OrderId and IsActive = 1 and LocationType = 1)  ) as PlannedCollectedProductTotalQuantity

,(select SUM(ISNULL(PlannedQuantity,0)) from OrderProductMovement where OrderproductId not in (select OrderProductId from OrderProduct where OrderId = o.OrderId and IsActive = 1 and ProductCode = '55909001') and  OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = o.OrderId and IsActive = 1 and LocationType = 2)  ) as PlannedDeliveredProductTotalQuantity

,(select SUM(ISNULL(ActualQuantity,0)) from OrderProductMovement where OrderproductId not in (select OrderProductId from OrderProduct where OrderId = o.OrderId and IsActive = 1 and ProductCode = '55909001') and  OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = o.OrderId and IsActive = 1 and LocationType = 1)  ) as CollectedProductTotalQuantity

,(select SUM(ISNULL(ActualQuantity,0)) from OrderProductMovement where OrderproductId not in (select OrderProductId from OrderProduct where OrderId = o.OrderId and IsActive = 1 and ProductCode = '55909001') and  OrderMovementId in (select OrderMovementId from OrderMovement where OrderId = o.OrderId and IsActive = 1 and LocationType = 2)  ) as DeliveredProductTotalQuantity
,
(select ExpectedTimeOfAction from OrderMovement where OrderId = o.OrderId and o.IsActive = 1 and LocationType = 1) as PlannedCollectionDate,
	 (select ActualTimeOfAction from OrderMovement where OrderId = o.OrderId and o.IsActive = 1 and LocationType = 1) as ActualCollectionDate,
	 
	 (select ExpectedTimeOfAction from OrderMovement where OrderId = o.OrderId and o.IsActive = 1 and LocationType = 2) as PlannedDeliveryDate,
	 (select ActualTimeOfAction from OrderMovement where OrderId = o.OrderId and o.IsActive = 1 and LocationType = 2) as ActualDeliveryDate

	 ,ISNULL(dl.AddressLine1,'') + ' ' + ISNULL(dl.AddressLine2,'') + ' ' + ISNULL(dl.AddressLine3,'') + ' ' +
ISNULL(dl.AddressLine4,'') + ' ' + ISNULL((select CityName from City where CityId = dl.City),'') + ' ' + ISNULL((select StateName from [State] where StateId = dl.[State]),'') + ' ' + ISNULL(dl.Pincode,'') as ShipToLocationAddress


,ISNULL(dl.AddressLine1,'') + ' ' + ISNULL(dl.AddressLine2,'') + ' ' + ISNULL(dl.AddressLine3,'') + ' ' +
ISNULL(dl.AddressLine4,'') + ' ' + ISNULL((select CityName from City where CityId = dl.City),'') + ' ' + ISNULL((select StateName from [State] where StateId = dl.[State]),'') + ' ' + ISNULL(dl.Pincode,'') as CollectionLocationAddress

,ISNULL(dl.AddressLine1,'') + ' ' + ISNULL(dl.AddressLine2,'') + ' ' + ISNULL(dl.AddressLine3,'') + ' ' +
ISNULL(dl.AddressLine4,'') + ' ' + ISNULL((select CityName from City where CityId = dl.City),'') + ' ' + ISNULL((select StateName from [State] where StateId = dl.[State]),'') + ' ' + ISNULL(dl.Pincode,'') as DeliveryLocationAddress,

(SELECT [dbo].[fn_GetTotalAmount](0, o.OrderId)) AS TotalPrice

,(select cast ((SELECT 'true' AS [@json:Array]
							,OrderDocumentId
							,OrderId
							,DocumentTypeId
							,(SELECT dbo.fn_LookupValueById(DocumentTypeId)) as 'DocumentType'
							,DocumentFormat
							,ISNULL(DocumentDescription,'') as DocumentDescription
FROM OrderDocument  WHERE  OrderId = o.OrderId
order by DocumentTypeId 
FOR XML path('OrderDocumentList'),ELEMENTS) AS xml))
   

 FROM [dbo].[Order] o 
 left join Enquiry e on o.EnquiryId = e.EnquiryId
 left join TruckSize ts on o.TruckSizeId = ts.TruckSizeId
 left join Company c on o.SoldTo = c.CompanyId
 left join Location dl on o.ShipTo = dl.LocationId
 left join Location bp on o.StockLocationId = bp.LocationId
 left join OrderMovement om on o.OrderId = om.OrderId and om.LocationType = 1
 left join OrderMovement om2 on o.OrderId = om2.OrderId and om2.LocationType = 2
 left join Location Acl on om.Location = Acl.LocationId
 left join Location Adl on om2.Location = Adl.LocationId

 WHERE (o.OrderId = @OrderId OR @OrderId = '') AND o.IsActive=1
 
 FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)

 
END
