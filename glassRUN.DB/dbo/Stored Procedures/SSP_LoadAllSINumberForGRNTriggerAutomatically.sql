Create PROCEDURE [dbo].[SSP_LoadAllSINumberForGRNTriggerAutomatically] --1

AS
BEGIN


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
select  'true' AS [@json:Array]  ,* from (
SELECT  
OrderId  , o.OrderType

 FROM [Order] o  
  where (o.OrderType='SI' or o.OrderType='ST' )  and o.OrderId in (select    orderid from  OrderProduct  where ISNULL(DeliveredQuantity,0) > 0 and isnull(IsGRN,0) =0) 
  union 
SELECT  o.OrderId ,o.OrderType

 FROM [Order] o    left join  OrderMovement  om on om.OrderId = o.OrderId  and om.LocationType=2
  where o.OrderType='ST'  and   om.ActualTimeOfAction  is not null  
  and o.OrderId in (select    orderid from  OrderProduct    where   isnull(IsGRN,0) =0) )tmp
  

FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
END
