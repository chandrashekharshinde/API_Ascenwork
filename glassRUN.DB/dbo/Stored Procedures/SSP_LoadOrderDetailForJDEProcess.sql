CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcess]--'<Json><OrderId>2524</OrderId></Json>'
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
, (case when o.OrderType = 'SO' then c.CompanyMnemonic  else  (select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=dl.DeliveryLocationCode ) end ) as SoldToCode
--,   c.CompanyMnemonic as   SoldToCode
,  (case when o.OrderType = 'SO' then dl.DeliveryLocationCode  else  (select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=dl.DeliveryLocationCode ) end ) as ShipToCode
--,dl.DeliveryLocationCode as ShipToCode

, ''  as BranchPlantCode
,o.ExpectedTimeOfDelivery
,o.OrderType
,o.OrderDate
,ReferenceNumber as 'SourceReferenceNumber'
,(select top 1 CompanyMnemonic From company where CompanyId in (select CompanyId from DeliveryLocation where DeliveryLocationCode=o.StockLocationId)) as 'ParentCompanyCode'
, (case when o.OrderType ='SO' then  o.CarrierNumber else (select  top 1 CarrierNumber From [Order] where OrderId in (select OrderId from OrderProduct where AssociatedOrder=o.OrderId)) end) as CarrierNumber
,(select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=o.StockLocationId ) as 'BranchPlantAddressNumber' ,


(SELECT Cast ((SELECT 'true' AS [@json:Array]  

  ,OrderProductId
  ,ProductCode
  ,(Select top 1 ItemShortCode from Item where ItemCode=op.ProductCode) as ItemShortCode
  ,ProductQuantity
  ,op.ItemType
  ,op.LineNumber as SequenceNo
, op.LotNumber
 , (select  top 1   Name  From LookUp  where LookUpId = i.ItemType)    as 'ItemTypeCode'
 from OrderProduct op
 left join Item i on i.ItemCode = op.ProductCode
  WHERE op.IsActive=1  and op.OrderId =o.OrderId
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
