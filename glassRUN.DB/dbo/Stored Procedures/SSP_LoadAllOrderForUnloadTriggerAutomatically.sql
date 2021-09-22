CREATE PROCEDURE [dbo].[SSP_LoadAllOrderForUnloadTriggerAutomatically] --1

AS
BEGIN


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
  select  'true' AS [@json:Array]  ,* from (

select si.OrderId  ,si.OrderType From  [order] si   join OrderAndSIRelation  onsi  on si.OrderId  = onsi.SIOrderId
 join  [order] o on o.OrderId  =onsi.OrderId 
left  join InventoryTransaction    it on it.OrderId =si.OrderId AND  it.InventoryType='3003' 
where o.OrderId  in (select  oi.OrderId from  [order]  oi  where
 oi.OrderId  in (select om.OrderId From  OrderMovement  om  where   isnull(om.IsUnloadGroup,0) =1)  )

 and it.InventoryTransactionId is   null   
  and    ( select   count(*)    from OrderProduct  oplds where oplds.OrderId = si.OrderId  and (oplds.CollectedQuantity - oplds.DeliveredQuantity) >0 ) > 0
  union
select o.OrderId  ,o.OrderType 
from  [order] o 
left  join InventoryTransaction    it on it.OrderId =o.OrderId AND  it.InventoryType='3003' 
where o.OrderId  in (select  oi.OrderId from  [order]  oi  where
 oi.OrderId  in (select om.OrderId From  OrderMovement  om  where   isnull(om.IsUnloadGroup,0) =1)  )

 and it.InventoryTransactionId is   null   
  and    ( select   count(*)    from OrderProduct  oplds where oplds.OrderId = o.OrderId  and (oplds.CollectedQuantity - oplds.DeliveredQuantity) >0 ) > 0
 )tmp

FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
END
