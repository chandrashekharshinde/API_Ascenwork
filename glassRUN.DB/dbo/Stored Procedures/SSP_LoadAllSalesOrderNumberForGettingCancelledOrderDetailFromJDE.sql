CREATE PROCEDURE [dbo].[SSP_LoadAllSalesOrderNumberForGettingCancelledOrderDetailFromJDE] --1

AS
BEGIN


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 'true' AS [@json:Array]
, o.OrderId 
,o.OrderNumber 
,o.OrderType
, isnull(o.CompanyCode,(select  CompanyMnemonic  From Company  ic where ic.CompanyId =c.ParentCompany )) as 'CompanyCode'

 FROM [order]  o left join Company c on c.CompanyId = o.SoldTo
where   CurrentState   not in ( 980  )  and   CurrentState in (520)  and o.OrderType !='ST' 
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
