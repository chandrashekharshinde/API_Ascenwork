CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessForSIOIShipConfirmation]--'<Json><SIOrderId>212</SIOrderId><OrderType>SI</OrderType><OrderId>211</OrderId><IsSIOI>1</IsSIOI></Json>'
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
		[OrderId] bigint,
		[SIOrderId] bigint
		
        )tmp
		 
		--select * from #tmpOrder
		DECLARE @orderId BIGINT
		DECLARE @SIOrderId BIGINT
	
       SET @orderId=(SELECT #tmpOrder.OrderId FROM #tmpOrder) ;

	   SET @SIOrderId=(SELECT #tmpOrder.SIOrderId FROM #tmpOrder) ;


	   WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 
 OrderId
,SalesOrderNumber
,o.OrderNumber
,o.PurchaseOrderNumber

--,dl.DeliveryLocationCode as ShipToCode

,o.ExpectedTimeOfDelivery
,o.OrderType
,o.OrderDate
,ReferenceNumber as 'SourceReferenceNumber'
, (select   top 1 DeliveryLocationCode  From DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId ) as 'BranchPlantCode'  
,(select top 1 CompanyMnemonic From company where CompanyId in (select CompanyId from DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId)) as 'ParentCompanyCode'
,(select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId ) as 'BranchPlantAddressNumber' 
,  dl.DeliveryLocationCode as  ToBranchPlantCode,
dl.AddressNumber as SoldToCode,
 dl.AddressNumber as  ShipToCode,
 (select CompanyMnemonic  From Company where CompanyId=dl.CompanyID) as 'ToCompanyCode',

 (case when (select count(*) From OrderAndSIRelation osr   left join [order] o1 on osr.OrderId=o1.OrderId
left join  OrderMovement om on om.OrderId = o1.OrderId and om.LocationType=2
 where SIOrderId=o.OrderId   and om.ActualTimeOfAction  is  null) = 0 then 1 else 0 end )
   as 'IsCompleted' ,

(SELECT Cast ((  select * 

From  (SELECT 'true' AS [@json:Array]  ,
 op.OrderId  as 'SIOrderId',
op.OrderProductId  as 'SIOrderProductId',
      op.ProductCode,
 i.ItemShortCode, 
 -- Quantity  as ProductQuantity,
  op.linenumber  as SequenceNo,
   --oplds.LotNumber  ,
   isnull(op.CollectedQuantity,0)   as CollectedQuantity,
   isnull(op.DeliveredQuantity,0)   as DeliveredQuantity,

   op.LotNumber  ,
	
	 (case when i.ItemType =404 then  'M' else  'F'  end ) as Location   ,

	 (select  top 1 Name From LookUp  where LookUpId= i.ItemType)    as 'ItemTypeCode'


  


 From OrderProduct   op 
left join Item i on i.ItemCode = op.ProductCode
 where op.OrderId=o.OrderId  and op.IsActive=1  and
  isnull(op.DeliveredQuantity ,0)  = 0 
    )tmp  where tmp.DeliveredQuantity > 0
  FOR XML path('OrderProductList'),ELEMENTS) AS xml)),
  (SELECT Cast ((SELECT 'true' AS [@json:Array]  ,
  OrderId,
  SIOrderId from OrderAndSIRelation
 where SIOrderId=o.OrderId

  FOR XML path('OrderAndSIRelationList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo

where  o.OrderId=@SIOrderId
FOR XML path('Order'),ELEMENTS,ROOT('Json')) AS XML)

		
		

    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
