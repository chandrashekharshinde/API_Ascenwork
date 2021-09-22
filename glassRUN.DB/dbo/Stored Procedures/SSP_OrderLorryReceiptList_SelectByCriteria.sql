CREATE PROCEDURE [dbo].[SSP_OrderLorryReceiptList_SelectByCriteria]--'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 19 AND ActualTimeOfAction IS  NULL)','',dfdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderId',
@Output nvarchar(max) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql ='(Select Cast((select   ''true'' AS [@json:Array]  , OrderId ,OrderNumber,OrderNumber  as ''ConsignmentNoteNo'','''' as ''VehicleNo'','''' as ''Type'',suppplier.State  as ''Origin'',cus.State   as ''Destination'',suppplier.CompanyName as ''ShipperName'',suppplier.AddressLine1 as ''ShipperAddress'','''' as ''ShipperContactNo'','''' as ''ShipperGStNo'',cus.CompanyName as ''ConsigneeName'',cus.AddressLine1 as ''ConsigneeAddress'','''' as ''ConsigneeContactNo'','''' as ''ConsigneeGStNo'','''' as ''VendorRef'','''' as ''DriverName'','''' as ''DriverPhone''  ,(select cast ((    select    ''true'' AS [@json:Array]  , OrderProductId ,   orderid,   ''46*32*21 cm''   as ''Dimension'' ,    ''Cartons''   as ''PackageType'' ,	  ProductQuantity   as ''NoOfPackages'' ,	  ''''   as ''Size'' ,  i.ItemName  as  ''SaidToContain'' ,    NEWID() as ''OrderVolumeInformationGUID''   From OrderProduct  op   join Item   i on i.ItemCode = op.ProductCode     where op.OrderId=o.OrderId FOR XML path(''OrderVolumeInformationList''),ELEMENTS) AS xml)), (select cast ((    select    ''true'' AS [@json:Array]  , OrderId , GoodsInsured  , PolicyNo  ,   PolicyAmount  , Remarks  ,NEWID() as ''OrderInsuranceInformationGUID''   From  OrderInsuranceDetail  where OrderId=o.OrderId FOR XML path(''OrderInsuranceInformationList''),ELEMENTS) AS xml)),  (select cast ((    select    ''true'' AS [@json:Array]  , OrderId ,InvoiceNo , InvoiceDate , InvoiceValue ,   DeclaredValue  , EWayBillNo   ,NEWID() as ''OrderInvoiceInformationGUID''   From  OrderInvoiceDetail  where OrderId=o.OrderId FOR XML path(''OrderInvoiceInformationList''),ELEMENTS) AS xml)),   (select cast ((    select    ''true'' AS [@json:Array]  , OrderId  , '''' as Particulars ,ChargedBasis  ,ChargedWeight  , PerUnitCharge ,   Amount , '''' as GSTbasis  , '''' as GSTNoofGTA , '''' as GSTValue ,  NEWID() as ''OrderFreightInformationGUID''    From  OrderFreightDetail  where OrderId=o.OrderId FOR XML path(''OrderFreightInformationList''),ELEMENTS) AS xml))  FROM [dbo].[Order] o      join  Company   cus on cus.CompanyId  = o.SoldTo  join  Location  picklocation  on  picklocation.LocationCode  =o.StockLocationId  join Company suppplier on suppplier.CompanyId =  picklocation.CompanyID  WHERE  o.IsActive=1 and ' + @WhereExpression + '

  ORDER BY ' + @SortExpression  + '
 FOR XML PATH(''LorryReceiptInfos''),ELEMENTS)AS XML))'

  
 


 
 SET @Output=@sql
 PRINT @sql
 PRINT 'Executed SSP_LorryReceiptList_SelectByCriteria'