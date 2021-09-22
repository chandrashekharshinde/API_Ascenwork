
CREATE PROCEDURE [dbo].[SSP_GetLorryReceiptDetail_ByOrderId] --'<Json><ServicesAction>GetLorryReceiptDetailByOrderId</ServicesAction><OrderId>77827</OrderId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @orderId nvarchar(100)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId]
   
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [OrderId] bigint
    
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((select OrderId ,
OrderNumber  as 'ConsignmentNoteNo',
(
  select top 1 TruckPlateNumber  From OrderLogistics  where OrderMovementId  in ( select OrderMovementId From OrderMovement  where OrderId=o.orderid and LocationType=1)) as 'VehicleNo',
(select  top 1 VehicleType  From TruckSize  where TruckSizeId in (   select TruckSizeId From  [order] where OrderId = o.OrderId )) as 'Type',
suppplier.State as 'Origin',
cus.State  as 'Destination',
suppplier.CompanyName as 'ShipperName',
suppplier.AddressLine1 as 'ShipperAddress',
(select  top 1 Contacts  From ContactInformation  where ObjectId=o.CompanyId  and ContactType='MobileNo'  and ObjectType='Company') as 'ShipperContactNo',
suppplier.TaxId as 'ShipperGStNo',
cus.CompanyName as 'ConsigneeName',
cus.AddressLine1 as 'ConsigneeAddress',
(select  top 1 Contacts  From ContactInformation  where ObjectId=o.SoldTo  and ContactType='MobileNo'  and ObjectType='Company') as 'ConsigneeContactNo',
cus.TaxId as 'ConsigneeGStNo',
'' as 'VendorRef',
'' as 'DriverName',
'' as 'DriverPhone'  ,

(select [dbo].[fn_CheckApplicableForOrder](o.orderid ,0 ) ) as 'IsApplicable' ,
(select  top 1 'data:image/jpeg;base64,'+DocumentBlob   From  OrderDocument  where    OrderId=o.orderid  and  DocumentTypeId=314) as 'ShipperSignBlob',
(select  top 1 'data:image/jpeg;base64,'+DocumentBlob   From  OrderDocument  where   OrderId=o.orderid  and  DocumentTypeId=315) as 'DriverSignBlob',
(select  top 1 'data:image/jpeg;base64,'+DocumentBlob   From  OrderDocument  where   OrderId=o.orderid  and  DocumentTypeId=316) as 'ConsigneeSignBlob',
(select  top 1 'data:image/jpeg;base64,'+DocumentBlob   From  OrderDocument  where   OrderId=o.orderid  and  DocumentTypeId=317) as 'UCISignBlob',
carrier.TaxId  as 'CarrierGSTNo'  , 
'U74999TN2018FTC125850' as  'Cin',
(select  top 1 GSTPaidBy From  [LorryReceiptGSTDetail]  where orderid=o.orderid) as 'GSTPaidBy',
(select  top 1 GSTNo From  [LorryReceiptGSTDetail]  where orderid=o.orderid) as 'GSTNo',
isnull((select  top 1 GSTPercentage From  [LorryReceiptGSTDetail]  where orderid=o.orderid),12) as 'GSTPercentage',
(((select    ISNULL(sum(Amount ),0)     From  OrderFreightDetail   where OrderId=o.orderid)*(isnull((select  top 1 GSTPercentage From  [LorryReceiptGSTDetail]  where orderid=o.orderid),0)))/100)  as 'GSTValue'  , 
((((select    ISNULL(sum(Amount ),0)     From  OrderFreightDetail   where OrderId=o.orderid)*(isnull((select  top 1 GSTPercentage From  [LorryReceiptGSTDetail]  where orderid=o.orderid),0)))/100) + (select    ISNULL(sum(Amount ),0)     From  OrderFreightDetail   where OrderId=o.orderid) ) as 'TotalBillingValue'  , 
(select cast ((  
  select    'true' AS [@json:Array]  , OrderProductId , 
  orderid,
   '46*32*21 cm'   as 'Dimension' ,
    'Cartons'   as 'PackageType' ,
	  ProductQuantity   as 'NoOfPackages' ,
	  ''   as 'Size' ,
  i.ItemName  as  'SaidToContain' ,
    NEWID() as 'OrderVolumeInformationGUID' 

  From OrderProduct  op   join Item   i on i.ItemCode = op.ProductCode     where op.OrderId=o.OrderId
 FOR XML path('OrderVolumeInformationList'),ELEMENTS) AS xml)),
 (select cast ((  
  select    'true' AS [@json:Array]  , OrderId , GoodsInsured  , PolicyNo  ,InsuranceTakenBy,
   PolicyAmount  , Remarks  ,NEWID() as 'OrderInsuranceInformationGUID'   From  OrderInsuranceDetail  where OrderId=o.OrderId
 FOR XML path('OrderInsuranceInformationList'),ELEMENTS) AS xml)),
  (select cast ((  
  select    'true' AS [@json:Array]  , OrderId ,InvoiceNo , InvoiceDate , InvoiceValue ,
   DeclaredValue  , EWayBillNo   ,NEWID() as 'OrderInvoiceInformationGUID'   From  OrderInvoiceDetail  where OrderId=o.OrderId
 FOR XML path('OrderInvoiceInformationList'),ELEMENTS) AS xml)),
   (select cast ((  
  select    'true' AS [@json:Array]  , OrderId  , '' as Particulars ,ChargedBasis  ,ChargedWeight  , PerUnitCharge ,
   Amount , '' as GSTbasis  , '' as GSTNoofGTA , '' as GSTValue ,  NEWID() as 'OrderFreightInformationGUID'    From  OrderFreightDetail  where OrderId=o.OrderId
 FOR XML path('OrderFreightInformationList'),ELEMENTS) AS xml))
 
 FROM [dbo].[Order] o      join  Company   cus on cus.CompanyId  = o.SoldTo
 
  join Company suppplier on suppplier.CompanyId =  o.CompanyID
  left join  Company  carrier	 on carrier.CompanyId  =o.CarrierNumber
   WHERE (OrderId = @orderid ) AND o.IsActive=1
 FOR XML path('Order'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END