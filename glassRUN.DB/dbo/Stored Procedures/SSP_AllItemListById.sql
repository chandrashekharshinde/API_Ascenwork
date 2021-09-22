CREATE PROCEDURE [dbo].[SSP_AllItemListById] --'<Json><ServicesAction>GetAllItemListById</ServicesAction><ItemId>297</ItemId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @itemId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @itemId = tmp.[ItemId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[ItemId]
      ,[ItemName]
      ,[ItemCode]
      ,[ItemShortCode]
      ,[PrimaryUnitOfMeasure]
      ,[SecondaryUnitOfMeasure]
	  ,ItemNameEnglishLanguage
      ,[ProductType]
      ,[BussinessUnit]
      ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
	  ,(select top 1 Amount from PriceListDetails where ItemId = item.ItemId and IsActive = 1) as Price
	  ,(Select top 1 price from ItemBasePrice where ItemLongCode=item.ItemCode) as Amount
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
	     ,[PricingUnit]
      ,[ShippingUnit]
      ,[ComponentUnit]
      ,[ItemClass]
      ,[ShelfLife]
      ,[BBD]
      ,[Barcode]
      ,[ItemOwner]
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
	   ,[AutomatedWareHouseUOM]
      ,[Tax]
      ,[Length]
      ,[Breadth]
      ,[Height]
      ,[Brand]
	  
	  ,(select cast ((SELECT  'true' AS [@json:Array] ,[ItemBranchPlantMappingId] 
				,[BranchPlantId] as Id
      ,[ItemId] 
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
				from [ItemBranchPlantMapping] contact where contact.ItemId=Item.ItemId and IsActive=1
				FOR XML path('CollectionLocationList'),ELEMENTS) AS xml))
				  ,(select cast ((SELECT  'true' AS [@json:Array] ,[UnitOfMeasureId]
      ,[ItemId]
	  ,(Select Name from LookUp where LookUpId=uom.[UOM]) as PrimaryUOMName
	  ,(Select Name from LookUp where LookUpId=uom.[RelatedUOM]) as RelatedUOMName
      ,[UOM] as PrimaryUnitOfMeasure
      ,[RelatedUOM] as RelatedUnitOfMeasure
      ,[UOMStructure]
      ,[ConversionFactor] as Conversion
      ,[ConversionFactorSecondaryToPrimary]
      ,[UpdatedDate]
      ,[IsActive]
	  ,NEWID() as ConversionInfoGUID
	from [UnitOfMeasure] uom where uom.ItemId=Item.ItemId and IsActive=1
	FOR XML path('ConversionInformationList'),ELEMENTS) AS xml))

		,(select cast ((SELECT  'true' AS [@json:Array] ,[ItemShortCode]
      ,[ItemLongCode]
      ,[AddressNumber]
      ,[CurrencyCode]
      ,[UOM]   
	  ,convert(date,DBO.JULTODMY([EffectiveDate]),103) as [EffectiveDate]
	  ,convert(date,DBO.JULTODMY([ExpiryDate]),103) as [ExpireDate]
      ,[Price] as ItemPrice
      ,[CustomerGroupID]
      ,[ItemGroupId]
	  ,NEWID() as ItemBasePriceInfoGUID
				from [ItemBasePrice] ibp where ibp.ItemLongCode=Item.ItemCode 
				FOR XML path('ItemBaseInfoList'),ELEMENTS) AS xml))
  FROM Item WHERE IsActive = 1 and ItemId=@itemId
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END





