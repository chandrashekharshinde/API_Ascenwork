
CREATE PROCEDURE [dbo].[SSP_OrderDocumentList] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>49</OrderId><RoleId>4</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @orderId bigint
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

(select cast ((SELECT  'true' AS [@json:Array]  , o.OrderId,OrderNumber,SalesOrderNumber,
(SELECT top 1 [ResourceValue] FROM [dbo].[RoleWiseStatusView] where [RoleId]=@roleId and [StatusId]=o.CurrentState and [CultureId]=@CultureId) AS [Status],
(SELECT top 1 [Class] FROM [dbo].[RoleWiseStatusView] where [RoleId]=@roleId and [StatusId]=o.CurrentState) AS 'Class',
'1' as ControlTowerOpen,
ISNULL((select top 1 l.Name from [Login] l  where l.LoginId=om.[DeliveryPersonnelId]),'') as [DriverName]
,ISNULL((select top 1 l.CompanyName from Company l  where l.CompanyId=om.TransportOperatorId),'') as [TransporterName]
,ISNULL((select top 1 t.TruckSize from TruckSize t where TruckSizeId = o.TruckSizeId),'') as TruckSize
,ISNULL(ol.TruckPlateNumber,'') as TruckPlateNumber
, o.SoldTo,o.SoldToCode,o.SoldToName,o.ShipTo,o.ShipToCode,o.ShipToName,OrderDate,
ISNULL(l.AddressLine1,'') + ', ' + ISNULL(l.AddressLine2,'') + ', ' + ISNULL((select top 1 CityName from City where CityId = l.City),'') + ', ' + ISNULL((select top 1 StateName from State where StateId = l.State),'')  + ', ' + ISNULL(l.Pincode,'') as ShipToAddress,
   (select cast ((SELECT 'true' AS [@json:Array]
							,OrderDocumentId
							,OrderId
							,DocumentTypeId
							,(SELECT dbo.fn_LookupValueById(DocumentTypeId)) as 'DocumentType'
							,DocumentFormat
							,ISNULL(DocumentDescription,'') as DocumentDescription
FROM OrderDocument  WHERE  OrderId = o.OrderId
order by DocumentTypeId 
FOR XML path('OrderDocumentList'),ELEMENTS) AS xml)),
 (select cast ((SELECT 'true' AS [@json:Array]
							,SurveyFormId
							,Survey
							,Comments
							,CreatedDate
							,UpdatedDate
							
FROM SurveyForm  WHERE  OrderId = o.OrderId
order by SurveyFormId 
FOR XML path('SurveyFormList'),ELEMENTS) AS xml))
FROM [dbo].[Order] o left join OrderMovement om on o.OrderId = om.OrderId and om.LocationType = 1
left join OrderLogistics ol on om.OrderMovementId = ol.OrderMovementId
left join [Location] l on o.ShipToCode = l.LocationCode
WHERE o.OrderId = @orderId  AND o.IsActive=1 
--WHERE o.SalesOrderNumber in (select SalesOrderNumber from [Order] where OrderId = @orderId OR @orderId = '') AND o.IsActive=1 
FOR XML PATH('OrderList'),ELEMENTS,ROOT('Json')) AS XML))
 
 
 
END
