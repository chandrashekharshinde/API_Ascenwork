
Create PROCEDURE [dbo].[SSP_LoadAllSINumberForPickSlipTriggerAutomatically] --1

AS
BEGIN


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
 
 select   'true' AS [@json:Array], * from

 (   SELECT OrderId FROM [Order] o   left join DeliveryLocation dl on o.ShipTo=dl.DeliveryLocationId 
    where (o.OrderType='SI'  or o.OrderType='ST' )  and CurrentState=3  
  and ( dl.IsAutomatedWMS is null   or  (  dl.IsAutomatedWMS =1 and  ( select Count (*)From OrderProduct   where OrderNumber = o.OrderNumber) >0)  )
  and o.OrderId  in (select  SIOrderId  From OrderAndSIRelation )
 union 
  SELECT  OrderId   FROM [Order] o  where o.OrderType in ('ST' ,'SO') and OrderId in (select  OrderId from [OrderMovement] )    and ISNULL(IsPrintPickSlip ,0)=0)tmp

FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
END
