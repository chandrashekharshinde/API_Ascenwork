
CREATE PROCEDURE [dbo].[SSP_LoadAllSalesOrderNumberForGettingLatestOrderDetailFromJDE] --1

AS
BEGIN


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 'true' AS [@json:Array]
, o.OrderId 
,o.OrderNumber 
,o.OrderType
,o.CompanyCode

 FROM [order]  o
where   CurrentState  in (520 ,525,540,560)  
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
	
END