
CREATE PROCEDURE [dbo].[SSP_LoadAllPendingOrderForProcessingToGetSalesOrderNumberFromJDE] --1

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
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
where  o.OrderNumber is null
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
