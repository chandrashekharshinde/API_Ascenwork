CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessForGRNProcess]--'<Json><OrderId>10697</OrderId><OrderType>SI</OrderType></Json>'
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
	DECLARE @IsSIOIExist bigint  ;

       SET @orderId=(SELECT #tmpOrder.OrderId FROM #tmpOrder) ;

	  select @orderTYpe=orderType  From  [Order]   where    Orderid=  @orderId  ;

	  select @IsSIOIExist=COUNT(*)  From [OrderAndSIRelation]  where  SIOrderId=@orderId


	  if(@IsSIOIExist > 0)
	  begin

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

 (case when (select  Count(*) From OrderAndSIRelation osr   left join [order] o on osr.OrderId=o.OrderId where SIOrderId=o.OrderId 
and o.CurrentState != 103) = 0 then 0 else 1 end )
   as 'IsCompleted' ,

(SELECT Cast (( SELECT 'true' AS [@json:Array]  ,
 op.OrderId ,
op.OrderProductId  ,
      op.ProductCode,
 i.ItemShortCode, 
  op.lineNumber  as SequenceNo,
   op.LotNumber  ,
   (select ShortCode  From  LookUp  where LookUpId=i.PrimaryUnitOfMeasure)  as 'PrimaryUOM',
   
    op.ProductQuantity  as ProductQuantity,
  sum( isnull(op.CollectedQuantity,0) )  as CollectedQuantity ,
 sum(isnull(op.DeliveredQuantity,0) )     as DeliveredQuantity 
   --oplds.OrderProductLotDetailsId
   ,(SELECT Cast ((SELECT 'true' AS [@json:Array]  ,

    oplds2.OrderProductId 
  
  
   From OrderProduct  oplds2 
    where  oplds2.OrderProductId=op.OrderProductId
		and  isnull(oplds2.DeliveredQuantity , 0) > 0   and ISNULL(IsGRN,0)=0
  FOR XML path('OrderProductLotDetailList'),ELEMENTS) AS xml)) 
 From OrderProduct   op 

left join Item i on i.ItemCode = op.ProductCode
 where op.OrderId= o.OrderId and op.IsActive=1  and       isnull(op.DeliveredQuantity , 0) > 0   and ISNULL(IsGRN,0)=0
 group by op.orderid  , op.OrderProductId  , op.ProductCode,i.ItemShortCode,i.PrimaryUnitOfMeasure,  op.LineNumber ,  oplds.LotNumber  ,op.ProductQuantity  
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo

where  o.OrderId=@orderId  and   o.OrderId in (select    orderid from  OrderProductLotDetails  where IsPartialShip=1  and isnull(IsGRN,0) =0) 
FOR XML path('Order'),ELEMENTS,ROOT('Json')) AS XML)

	  end
	  else
	  begin
	   WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 
 o.OrderId
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

 (case when (select  Count(*) From OrderAndSIRelation osr   left join [order] o on osr.OrderId=o.OrderId where SIOrderId=o.OrderId 
and o.CurrentState != 103) = 0 then 0 else 1 end )
   as 'IsCompleted' ,

(SELECT Cast (( SELECT 'true' AS [@json:Array]  ,
 op.OrderId ,
op.OrderProductId  ,
      op.ProductCode,
 i.ItemShortCode, 
  (select ShortCode  From  LookUp  where LookUpId=i.PrimaryUnitOfMeasure)  as 'PrimaryUOM',
  op.lineNumber  as SequenceNo,
   op.LotNumber  ,
    op.ProductQuantity  as ProductQuantity,
   isnull(op.CollectedQuantity,0)   as CollectedQuantity 
  
 From OrderProduct   op 

left join Item i on i.ItemCode = op.ProductCode
 where op.OrderId=o.OrderId and op.IsActive=1   --and   isnull( oplds.IsDelivered ,0)=0
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
 left join OrderMovement  om on om.OrderId = o.OrderId  and om.LocationType=2
where  o.OrderId=@orderId  and    o.OrderType='ST'  and   om.ActualTimeOfAction  is not null  
  and o.OrderId in (select    orderid from  OrderProduct    where   isnull(IsGRN,0) =0)
FOR XML path('Order'),ELEMENTS,ROOT('Json')) AS XML)

	  end




	 

		
		

    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
