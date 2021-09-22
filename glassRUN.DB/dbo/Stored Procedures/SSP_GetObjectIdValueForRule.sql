CREATE PROCEDURE [dbo].[SSP_GetObjectIdValueForRule] --'<Json><EnquiryId>12945</EnquiryId><EnquiryProductId>0</EnquiryProductId><CustomerId>1402</CustomerId><SupplierId>1403</SupplierId><CollectionLocationId>119001</CollectionLocationId><DeliveryLocationId>114623</DeliveryLocationId><TruckSizeId>158</TruckSizeId></Json>'

@xmlDoc XML
AS
BEGIN

DECLARE @intPointer INT;
DECLARE @EnquiryId bigint
DECLARE @EnquiryProductId bigint
DECLARE @CustomerId bigint
DECLARE @SupplierId bigint
DECLARE @CollectionLocationId bigint
DECLARE @DeliveryLocationId bigint
DECLARE @TruckSizeId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
@EnquiryId =tmp.EnquiryId,
@EnquiryProductId=tmp.EnquiryProductId,
@CustomerId =tmp.CustomerId,
@SupplierId =tmp.SupplierId,
@CollectionLocationId =tmp.CollectionLocationId,
@DeliveryLocationId =tmp.DeliveryLocationId,
@TruckSizeId=tmp.TruckSizeId
FROM OPENXML(@intpointer,'Json',2)
WITH
(
EnquiryId bigint,
EnquiryProductId bigint,
CustomerId bigint,
SupplierId bigint,
CollectionLocationId bigint,
DeliveryLocationId bigint,
TruckSizeId bigint
)tmp ;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select   

(select cast ((Select Top 1 [EnquiryId]
      ,[CompanyId]
      ,[CompanyCode]
      ,[EnquiryGroupNumber]
      ,[EnquiryAutoNumber]
      ,[EnquiryType]
      ,[SoldTo]
      ,[SoldToCode]
      ,[SoldToName]
      ,[ShipTo]
      ,[ShipToCode]
      ,[ShipToName]
      ,[PickDateTime]
      ,[EnquiryDate]
      ,[RequestDate]
      ,[PrimaryAddressId]
      ,[SecondaryAddressId]
      ,[PrimaryAddress]
      ,[SecondaryAddress]
      ,[OrderProposedETD]
      ,[Remarks]
      ,[PreviousState]
      ,[CurrentState]
      ,[PreviousProcess]
      ,[CurrentProcess]
	  ,(SELECT top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=Enquiry.TruckSizeId) as TruckSizeId
      ,[PalletSpace]
      ,[NumberOfPalettes]
      ,[TruckWeight]
      ,[IsRecievingLocationCapacityExceed]
      ,[StockLocationId]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[ReturnableItemCheck]
      ,[ReceivingLocationCapacityCheck]
      ,[StockCheck]
      ,[IsProcess]
      ,[PromisedDate]
      ,[PONumber]
      ,[PaymentType]
      ,[DiscountPercent]
      ,[DiscountAmount]
      ,[PaymentDiscountPercent]
      ,[TotalDiscountAmount]
      ,[TotalAmount]
      ,[PresellerCode]
      ,[PresellerName]
      ,[TotalTaxAmount]
      ,[TotalQuantity]
      ,[TotalPrice]
      ,[TotalVolume]
      ,[TotalWeight]
      ,[NumberOfCrate]
      ,[CollectionLocationCode]
      ,[SONumber] from [Enquiry] Where EnquiryId=@EnquiryId
 FOR XML path('Enquiry'),ELEMENTS) AS xml)) ,

(select cast ((Select Top 1 [EnquiryProductId]
      ,[CompanyId]
      ,[CompanyCode]
      ,[EnquiryId]
      ,[ProductCode]
      ,[ProductName]
      ,[ParentProductCode]
      ,[ProductType]
      ,[ProductQuantity]
      ,[AvailableQuantity]
      ,[DepositeAmount]
      ,[Remarks]
      ,[AssociatedOrder]
      ,[EffectiveDate]
      ,[Price]
      ,[UnitPrice]
      ,[TotalUnitPrice]
      ,[ItemType]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[DiscountPercent]
      ,[DiscountAmount]
      ,[PaymentType]
      ,[ReplacementParentProductId]
      ,[IsReplaceable]
      ,[LastStatus]
      ,[NextStatus]
      ,[StockLocationCode]
      ,[StockLocationName]
      ,[TotalVolume]
      ,[TotalWeight]
      ,[CollectionLocationCode] from [EnquiryProduct] Where EnquiryId=@EnquiryId
 FOR XML RAW('EnquiryProductList'),ELEMENTS) AS xml)),



  (select cast ((Select Top 1 [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,(SELECT [dbo].[fn_LookupValueById] ([CompanyType])) as [CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
      ,[Region]
      ,[RouteCode]
      ,[ZoneCode]
      ,[CategoryCode]
      ,[BranchPlant]
      ,[Email]
      ,[TaxId]
      ,[SoldTo]
      ,[ShipTo]
      ,[BillTo]
     ,(select top 1 zc.ZoneCode from ZoneCode zc where zc.CompanyId=Supplier.CompanyId) as ZoneCode
	   ,(select top 1 zc.ZoneName from ZoneCode zc where zc.CompanyId=Supplier.CompanyId) as ZoneName
      ,[ContactPersonNumber]
      ,[ContactPersonName]

      ,[header]
      ,[footer]
    
      ,[SequenceNo]
      ,[SubChannel]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[CreditLimit]
      ,[AvailableCreditLimit]
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[PaymentTermCode]
      ,[CategoryType] from Company [Supplier] Where [Supplier].CompanyId=@SupplierId
 FOR XML path('Supplier'),ELEMENTS) AS xml)) ,
  (select cast ((Select Top 1 [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,(SELECT [dbo].[fn_LookupValueById] ([CompanyType])) as [CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
      ,[Region]
      ,[RouteCode]
      ,[ZoneCode]
      ,[CategoryCode]
      ,[BranchPlant]
      ,[Email]
      ,[TaxId]
      ,[SoldTo]
      ,[ShipTo]
      ,[BillTo]
	  ,(select top 1 zc.ZoneCode from ZoneCode zc where zc.CompanyId=[Customer].CompanyId) as ZoneCode
	   ,(select top 1 zc.ZoneName from ZoneCode zc where zc.CompanyId=[Customer].CompanyId) as ZoneName
      ,[ContactPersonNumber]
      ,[ContactPersonName]
    
      ,[header]
      ,[footer]

      ,[SequenceNo]
      ,[SubChannel]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[CreditLimit]
      ,[AvailableCreditLimit]
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[PaymentTermCode]
      ,[CategoryType] from Company [Customer] Where [Customer].CompanyId=@CustomerId
 FOR XML path('SoldTo'),ELEMENTS) AS xml)) ,

  (select cast ((Select Top 1 [LocationId]
      ,[LocationName]
      ,[DisplayName]
      ,[LocationCode]
      ,[CompanyID]
      ,(SELECT [dbo].[fn_LookupValueById] ([LocationType])) as[LocationType]
      ,[LocationIdentifier]
      ,[Area]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[City]
      ,[State]
      ,[Pincode]
      ,[Country]
      ,[Email]
      ,(Select top 1 PCL.LocationName from [Location] PCL where PCL.LocationId=CollectionLocation.Parentid) as [ParentLocationName]
	  ,(Select top 1 PCL.LocationCode from [Location] PCL where PCL.LocationId=CollectionLocation.Parentid) as [ParentLocationCode]
      ,[Capacity]
      ,[Safefill]
      ,[ProductCode]
      ,[Description]
      ,[Remarks]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[AddressNumber]
      ,[IsAutomatedWMS]
      ,[WMSBranchPlantCode]
      ,[WareHouseType]
      ,[BillType] from [Location] [CollectionLocation]  Where [CollectionLocation].LocationId=@CollectionLocationId
 FOR XML path('CollectionLocation'),ELEMENTS) AS xml)) ,
(select cast ((Select Top 1 [LocationId]
      ,[LocationName]
      ,[DisplayName]
      ,[LocationCode]
      ,[CompanyID]
      ,(SELECT [dbo].[fn_LookupValueById] ([LocationType])) as[LocationType]
      ,[LocationIdentifier]
      ,[Area]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[City]
      ,[State]
      ,[Pincode]
      ,[Country]
      ,[Email]
      ,(Select top 1 PCL.LocationName from [Location] PCL where PCL.LocationId=DeliveryLocation.Parentid) as [ParentLocationName]
	  ,(Select top 1 PCL.LocationCode from [Location] PCL where PCL.LocationId=DeliveryLocation.Parentid) as [ParentLocationCode]
      ,[Capacity]
      ,[Safefill]
      ,[ProductCode]
      ,[Description]
      ,[Remarks]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[AddressNumber]
      ,[IsAutomatedWMS]
      ,[WMSBranchPlantCode]
      ,[WareHouseType]
      ,[BillType] from [Location] [DeliveryLocation]  Where [DeliveryLocation].LocationId=@DeliveryLocationId
 FOR XML path('DeliveryLocation'),ELEMENTS) AS xml)),
(select cast ((SELECT top 1 [TruckSizeId]
      ,(SELECT [dbo].[fn_LookupValueById] ([VehicleType])) as [VehicleType]
      ,[TruckSize]
      ,isnull([TruckCapacityPalettes],'0')  as TruckCapacityPalettes
      ,[TruckCapacityWeight]
	  ,isnull((Select top 1 r.PalletInclusionGroup from [Route] r where r.DestinationId=@DeliveryLocationId and r.TruckSizeId=[TruckSize].TruckSizeId),'0') as PalletInclusionGroup
      ,[Height]
      ,[Width]
      ,[Length]
  FROM [dbo].[TruckSize] where TruckSizeId=@TruckSizeId
 FOR XML path('TruckSize'),ELEMENTS) AS xml)) ,
 (select cast ((SELECT top 1 SettingParameter  ,SettingValue
  FROM SettingMaster  where SettingParameter='JDEMethod'
 FOR XML path('SettingMaster'),ELEMENTS) AS xml)) 
FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)


END
