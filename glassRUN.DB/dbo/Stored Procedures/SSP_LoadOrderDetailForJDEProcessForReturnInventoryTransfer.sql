Create PROCEDURE [dbo].[SSP_LoadOrderDetailForJDEProcessForReturnInventoryTransfer]--'<Json><OrderId>143</OrderId></Json>'
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


		select @orderTYpe=orderType  From  [Order]   where    Orderid=  @orderId  ;



if(@orderTYpe='SI' or @orderTYpe='ST' )
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
, o.StockLocationId  as FromBranchPlantCode
,(select top 1 CompanyMnemonic From company where CompanyId in (select CompanyId from DeliveryLocation where DeliveryLocationCode=o.StockLocationId)) as 'FromCompanyCode'
,(select   top 1 AddressNumber  From DeliveryLocation where DeliveryLocationCode=o.StockLocationId ) as 'FromBranchPlantAddressNumber' 
,  dl.DeliveryLocationCode as  ToBranchPlantCode,
(select CompanyMnemonic  From Company where CompanyId=dl.CompanyID) as ToCompanyCode,
 dl.AddressNumber as  ToBranchPlantAddressNumber,
(select  DeliveryLocationCode  from DeliveryLocation  where CompanyId=b.CompanyID  and WareHouseType in (select  LookUpId  From LookUp  where Code='TWH')  ) as TruckBranchPlantCode,

(SELECT Cast (( select *   , (tmp.CollectedQuantity - tmp.DeliveredQuantity)  as ProductQuantity From (   SELECT 'true' AS [@json:Array]  ,
      op.ProductCode,
 i.ItemShortCode, 
 
 -- linenumber  as SequenceNo,
   op.LotNumber  ,
  sum(isnull(op.CollectedQuantity,0))   as   CollectedQuantity,
  sum(isnull(op.DeliveredQuantity,0))   as   DeliveredQuantity
  
 From OrderProduct   op 

left join Item i on i.ItemCode = op.ProductCode

 where op.OrderId=@OrderId  and op.IsActive=1  

 group  by  op.ProductCode  ,i.ItemShortCode  , op.LotNumber ) tmp  where (tmp.CollectedQuantity - tmp.DeliveredQuantity)>0
  FOR XML path('OrderProductList'),ELEMENTS) AS xml))
 FROM [Order] o
 left join  DeliveryLocation dl on o.ShipTo =dl.DeliveryLocationId
 left join  Company c on c.CompanyId = o.SoldTo
 left join DeliveryLocation b on  b.DeliveryLocationCode = o.StockLocationId
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
