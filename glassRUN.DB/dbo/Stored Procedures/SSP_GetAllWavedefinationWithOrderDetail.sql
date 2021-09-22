CREATE PROCEDURE [dbo].[SSP_GetAllWavedefinationWithOrderDetail]--  '<json><ObjectId>18016661</ObjectId><EventType>CNE</EventType></json>'


AS
BEGIN


--DECLARE @intPointer INT;
--Declare @EventType nvarchar(250);
--Declare @ObjectId BIGINT;


--EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

--SELECT @EventType = tmp.[EventType],
--@ObjectId = tmp.[ObjectId]
	   
--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			ObjectId BIGINT,
--           EventType NVARCHAR(250)
--			)tmp ;
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT (Cast(( select   'true' AS [@json:Array],
	  OrderId
	 ,OrderNumber 
	 ,ExpectedTimeOfDelivery
	 ,OrderDate
	 ,o.SoldTo
	 ,o.ShipTo
	 
	 ,c.CompanyId
	 ,c.CompanyMnemonic
	 ,dl.DeliveryLocationId
	 ,dl.DeliveryLocationCode
	 ,dl.Area
	 ,'' as StockLocationId
	 ,(Cast(( select 'true' AS [@json:Array], op.OrderProductId , op.ProductCode ,op.ProductQuantity,op.ItemType from OrderProduct op where op.OrderId =o.OrderId
		    FOR XML path('OrderProductList'),ELEMENTS) AS XML))
	 from [Order]  o left join  DeliveryLocation dl 
	 on o.ShipTo =dl.DeliveryLocationId
	 left join Company c
	 on o.SoldTo=c.CompanyId   where CurrentState=3 and OrderType='SO'
	  FOR XML path('OrderList'),ELEMENTS) AS XML))
	  ,(Cast((SELECT  'true' AS [@json:Array],
	  wd.WaveDefinitionId,
	wd.WaveDateTime ,
	wd.RuleText ,
	wd.RuleType,
	(Cast((SELECT  'true' AS [@json:Array],wdd.WaveDefinitionId ,wdd.TruckSizeId
	
	 from  WaveDefinitionDetails wdd  where wdd.IsActive=1  and wdd.WaveDefinitionId=wd.WaveDefinitionId
		    FOR XML path('WaveDefinitionDetailList'),ELEMENTS) AS XML))
	
	 from  WaveDefinition  wd where wd.IsActive=1
		    FOR XML path('WaveDefinitionList'),ELEMENTS) AS XML))
     FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)



END
