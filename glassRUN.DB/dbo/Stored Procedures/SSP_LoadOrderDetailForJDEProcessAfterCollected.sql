CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessAfterCollected]--'<Json><OrderId>2657</OrderId></Json>'
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
		DECLARE @orderTYpe nvarchar(200)  ;
	
       SET @orderId=(SELECT #tmpOrder.OrderId FROM #tmpOrder) ;


		


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	 

 Select Cast((
SELECT 
 OrderId
,SalesOrderNumber
,o.OrderNumber

--,dl.DeliveryLocationCode as ShipToCode

,o.ExpectedTimeOfDelivery
,o.OrderType
,o.OrderDate
,ReferenceNumber as 'SourceReferenceNumber'
, (select   top 1 DeliveryLocationCode  From DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId ) as 'BranchPlantCode'  
,(select top 1 CompanyMnemonic From company where CompanyId in (select CompanyId from DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId)) as 'ParentCompanyCode'
,(select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationId=o.TruckBranchPlantLocationId ) as 'BranchPlantAddressNumber' 
,  dl.DeliveryLocationCode as  ToBranchPlantCode,
--dl.AddressNumber as SoldToCode,
 --dl.AddressNumber as  ShipToCode,
  (case when o.OrderType = 'SO' then c.CompanyMnemonic  else  dl.AddressNumber end ) as SoldToCode
--,   c.CompanyMnemonic as   SoldToCode
,  (case when o.OrderType = 'SO' then dl.DeliveryLocationCode  else  dl.AddressNumber end ) as ShipToCode,
 (select CompanyMnemonic  From Company where CompanyId=dl.CompanyID) as 'ToCompanyCode',
(SELECT Cast ((SELECT 'true' AS [@json:Array]  ,
      op.ProductCode,
 i.ItemShortCode, 
  op.ProductQuantity  as PlannedProductQuantity,
  op.LineNumber  as SequenceNo,
   (case when i.ItemType =404 then  'M' else  'F'  end ) as Location  ,
  (case when i.ItemType =404 then  '' else  op.LotNumber  end ) as LotNumber  ,
   isnull(op.CollectedQuantity,0)   as ProductQuantity 

 From OrderProduct   op 

left join Item i on i.ItemCode = op.ProductCode
 where op.OrderId=o.OrderId  and op.IsActive=1  and isnull(op.LotNumber,'') !=''
  FOR XML path('OrderProductList'),ELEMENTS) AS xml)),
  (SELECT Cast ((SELECT 'true' AS [@json:Array]  ,
  OrderId,
  SIOrderId from OrderAndSIRelation
 where SIOrderId=o.OrderId

  FOR XML path('OrderAndSIRelationList'),ELEMENTS) AS xml))
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
