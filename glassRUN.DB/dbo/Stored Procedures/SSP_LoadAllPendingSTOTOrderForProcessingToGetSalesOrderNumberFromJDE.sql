
CREATE PROCEDURE [dbo].[SSP_LoadAllPendingSTOTOrderForProcessingToGetSalesOrderNumberFromJDE] --1

AS
BEGIN


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 'true' AS [@json:Array]
, OrderId
,SalesOrderNumber
,c.CompanyMnemonic as   SoldToCode
,dl.DeliveryLocationCode as ShipToCode
, ''  as BranchPlantCode
,o.ExpectedTimeOfDelivery
,o.ReferenceNumber
,o.PurchaseOrderNumber
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
where  (o.IsSTOTUpdated is null or o.IsSTOTUpdated=0) and o.OrderType='ST' and o.OrderNumber is not null and o.SalesOrderNumber is not null
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
