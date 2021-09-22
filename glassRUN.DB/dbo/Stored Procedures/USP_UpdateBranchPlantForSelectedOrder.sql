CREATE PROCEDURE [dbo].[USP_UpdateBranchPlantForSelectedOrder]-- '<Json><ServicesAction>UpdateOrderBranchPlant</ServicesAction><OrderDetailList><BranchPlantName>1007</BranchPlantName><OrderId>77409</OrderId></OrderDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @OrderId nvarchar(500)
Declare @branchPlantCode nvarchar(50)
Declare @StockLocationName nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @OrderId = tmp.[OrderId],
    @BranchPlantName = tmp.[BranchPlantName]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] nvarchar(500),
   [BranchPlantName] nvarchar(50)  
           
   )tmp
  

  select @branchPlantCode=LocationCode from [Location] where LocationId=@BranchPlantName

  select @StockLocationName=LocationName from [Location] where LocationId=@BranchPlantName


   INSERT INTO	[OrderHistory]	([OrderId],[CompanyId],[CompanyCode],[OrderNumber],[EnquiryId],[PickDateTime],[ExpectedTimeOfDelivery],[CarrierETA],[CarrierETD]
      ,[OrderDate],[TruckSizeId],[SoldTo],[SoldToCode],[SoldToName],[ShipTo],[ShipToCode],[ShipToName],[PrimaryAddressId],[SecondaryAddressId],[PrimaryAddress],[SecondaryAddress]
      ,[ModeOfDelivery],[OrderType],[PurchaseOrderNumber],[SalesOrderNumber],[PickNumber],[Remarks],[PreviousState],[CurrentState],[NextState],[IsRecievingLocationCapacityExceed]
      ,[IsPickConfirmed],[IsPrintPickSlip],[IsSTOTUpdated],[StockLocationId],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[IsActive],[SequenceNo],[CarrierNumber],[PalletSpace]
      ,[NumberOfPalettes],[TruckWeight],[Description1],[Description2],[OrderedBy],[GratisCode],[Province],[InvoiceNumber],[Field1],[Field2],[Field3],[Field4],[Field5],[Field6]
      ,[Field7],[Field8],[Field9],[Field10],[LoadNumber],[ReferenceNumber],[HoldStatus],[RedInvoiceNumber] ,[SI],[OI],[ReferenceForSIOI],[IsSIOI] ,[IsSendToWMS]
	  ,[ParentOrderId] ,[IsInventoryTransfer],[DiscountPercent],[DiscountAmount],[TotalDiscountAmount],[TruckBranchPlantLocationId],[TotalAmount],[PresellerCode],
	  [PresellerName],[IsLockFromWMS],[IsVatIntegrationProcessed] ,[TotalTaxAmount] ,[TotalQuantity] ,[TotalPrice],[TotalVolume],[TotalWeight],[NumberOfCrate] 
	  ,[PaymentTerm])Select [OrderId],[CompanyId],[CompanyCode],[OrderNumber],[EnquiryId],[PickDateTime],[ExpectedTimeOfDelivery],[CarrierETA],[CarrierETD]
      ,[OrderDate],[TruckSizeId],[SoldTo],[SoldToCode],[SoldToName],[ShipTo],[ShipToCode],[ShipToName],[PrimaryAddressId],[SecondaryAddressId],[PrimaryAddress],[SecondaryAddress]
      ,[ModeOfDelivery],[OrderType],[PurchaseOrderNumber],[SalesOrderNumber],[PickNumber],[Remarks],[PreviousState],[CurrentState],[NextState],[IsRecievingLocationCapacityExceed]
      ,[IsPickConfirmed],[IsPrintPickSlip],[IsSTOTUpdated],[StockLocationId],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[IsActive],[SequenceNo],[CarrierNumber],[PalletSpace]
      ,[NumberOfPalettes],[TruckWeight],[Description1],[Description2],[OrderedBy],[GratisCode],[Province],[InvoiceNumber],[Field1],[Field2],[Field3],[Field4],[Field5],[Field6]
      ,[Field7],[Field8],[Field9],[Field10],[LoadNumber],[ReferenceNumber],[HoldStatus],[RedInvoiceNumber] ,[SI],[OI],[ReferenceForSIOI],[IsSIOI] ,[IsSendToWMS]
	  ,[ParentOrderId] ,[IsInventoryTransfer],[DiscountPercent],[DiscountAmount],[TotalDiscountAmount],[TruckBranchPlantLocationId],[TotalAmount],[PresellerCode],
	  [PresellerName],[IsLockFromWMS],[IsVatIntegrationProcessed] ,[TotalTaxAmount] ,[TotalQuantity] ,[TotalPrice],[TotalVolume],[TotalWeight],[NumberOfCrate] 
	  ,[PaymentTerm] from [Order] where OrderId IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  print @OrderId
  print @branchPlantCode
 
  update [order] set StockLocationId  = @branchPlantCode where orderid IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  update OrderProduct set StockLocationCode = @branchPlantCode, StockLocationName =  @StockLocationName where orderid IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  update OrderTripCost set TripCost=0,TripRevenue=0 where OrderId IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))
  Update [OrderMovement] set Location=@BranchPlantName where OrderId IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId)) and LocationType=1

  SELECT @BranchPlantName as BranchPlantName FOR XML RAW('Json'),ELEMENTS
   

END