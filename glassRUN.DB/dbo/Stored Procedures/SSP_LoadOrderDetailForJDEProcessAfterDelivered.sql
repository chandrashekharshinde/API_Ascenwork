CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessAfterDelivered]--'<Json><OrderId>143</OrderId></Json>'
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
		[SIOrderId] bigint,
		[OrderType] nvarchar(200),
		[IsSIOI] bit
		
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

(SELECT Cast ((SELECT 'true' AS [@json:Array]  ,
 op.OrderId  as 'SIOrderId',
op.OrderProductId  as 'SIOrderProductId',
      op.ProductCode,
 i.ItemShortCode, 
 -- Quantity  as ProductQuantity,
  op.linenumber  as SequenceNo,
   op.LotNumber  ,
   isnull(op.CollectedQuantity,0)   as ProductQuantity,
   
  isnull((select op.DeliveredQuantity   From OrderProduct  oplds2   where oplds2.ProductCode=op.ProductCode and oplds2.LotNumber = op .LotNumber  and oplds2.OrderId in (select OrderId From OrderAndSIRelation  where SIOrderId in (op.OrderId))) ,0)  as 'DeliveredQuantity',

  (select OrderId   From OrderProduct  oplds2   where oplds2.ProductCode=op.ProductCode and oplds2.LotNumber = op.LotNumber  and oplds2.OrderId in (select OrderId From OrderAndSIRelation  where SIOrderId in (op.OrderId)))   as 'ReferenceOrderId'

 From OrderProduct   op 

left join Item i on i.ItemCode = op.ProductCode
 where op.OrderId=o.OrderId  and op.IsActive=1
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

	  end
	  else
	  begin



	  WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 
 OrderId
,SalesOrderNumber
,o.OrderNumber
, (case when o.OrderType = 'SO' then c.CompanyMnemonic  else  (select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=dl.DeliveryLocationCode ) end ) as SoldToCode
--,   c.CompanyMnemonic as   SoldToCode
,  (case when o.OrderType = 'SO' then dl.DeliveryLocationCode  else  (select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=dl.DeliveryLocationCode ) end ) as ShipToCode
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
  ,ItemType
  ,op.LineNumber as SequenceNo
  ,op.LotNumber
 from OrderProduct op    join OrderMovement om on op.OrderId = om.OrderId and LocationType=2
  join OrderProductMovement  opm on opm.OrderId=op.OrderId and opm.OrderProductId=op.OrderProductId and opm.OrderMovementId = om.OrderMovementId
  WHERE op.IsActive=1  
  and op.OrderId =o.OrderId
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
where  o.OrderId=@OrderId
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
