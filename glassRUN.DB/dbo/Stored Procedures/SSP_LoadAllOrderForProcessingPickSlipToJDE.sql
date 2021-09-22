
CREATE PROCEDURE [dbo].[SSP_LoadAllOrderForProcessingPickSlipToJDE] --1

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
, (SELECT Cast ((SELECT 'true' AS [@json:Array]  
  ,OrderProductId
  ,ProductCode
  ,(Select top 1 ItemShortCode from Item where ItemCode=op.ProductCode) as ItemShortCode
  ,ProductQuantity
  
 from OrderProduct op
  WHERE op.IsActive=1  and op.OrderId =o.OrderId
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
where  ISNULL(o.IsPickConfirmed ,0)=0  and   o.isprintpickslip =1
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
