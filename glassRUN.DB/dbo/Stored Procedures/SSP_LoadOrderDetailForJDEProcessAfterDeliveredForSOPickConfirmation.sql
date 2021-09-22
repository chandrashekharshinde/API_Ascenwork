CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessAfterDeliveredForSOPickConfirmation]--'<Json><OrderId>211</OrderId></Json>'
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


   select * into #tmpOrder
    FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		[OrderId] bigint
		
        )tmp
		 
		--select * from #tmpOrder
		DECLARE @orderId BIGINT
		
	
       SET @orderId=(SELECT #tmpOrder.OrderId FROM #tmpOrder) ;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 
 OrderId
,SalesOrderNumber
,o.OrderNumber
,   c.CompanyMnemonic as   SoldToCode
,dl.DeliveryLocationCode as ShipToCode
, ''  as BranchPlantCode
,o.ExpectedTimeOfDelivery
,o.OrderType
,o.OrderDate
,ReferenceNumber as 'SourceReferenceNumber'
,(select top 1 CompanyMnemonic From company where CompanyId in (select CompanyId from DeliveryLocation where DeliveryLocationCode=o.StockLocationId)) as 'ParentCompanyCode'
, (case when o.OrderType ='SO' then  o.CarrierNumber else (select  top 1 CarrierNumber From [Order] where OrderId in (select OrderId from OrderProduct where AssociatedOrder=o.OrderId)) end) as CarrierNumber
,(select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=o.StockLocationId ) as 'BranchPlantAddressNumber' ,

(SELECT Cast ((SELECT 'true' AS [@json:Array]  
  ,op.OrderProductId
  ,ProductCode
  ,(Select top 1 ItemShortCode from Item where ItemCode=op.ProductCode) as ItemShortCode
  ,  isnull(opm.ActualQuantity,0)  as ProductQuantity
   ,  isnull(opm.IsDeliveredAll,0)  as IsDeliveredAll
  ,op.ItemType
  ,op.LineNumber
  , (case when i.ItemType =404 then  '' else  op.LotNumber end ) as LotNumber  
 
 from OrderProduct op    join OrderMovement om on op.OrderId = om.OrderId and LocationType=2
 join Item  i on i.ItemCode =op.ProductCode
  join OrderProductMovement  opm on opm.OrderId=op.OrderId and opm.OrderProductId=op.OrderProductId and opm.OrderMovementId = om.OrderMovementId
  WHERE op.IsActive=1  
  and op.OrderId =o.OrderId and o.OrderType='SO'
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
where  o.OrderId=@OrderId
FOR XML path('Order'),ELEMENTS,ROOT('Json')) AS XML)

		
		

    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
