
CREATE PROCEDURE [dbo].[SSP_GetAllFavouriteItemAddedForSubDApp] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>2</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @searchValue nvarchar(500)
declare @ProductType nvarchar(50)

DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@searchValue =tmp.searchValue,
@companyId = tmp.CompanyId,
@ProductType = tmp.ProductType

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			searchValue nvarchar(500),
			CompanyId bigint,
			ProductType nvarchar(50)
			)tmp;

If(@ProductType = 'HeinekenProducts')
Begin
	
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,[ItemId],
  rownumber,TotalCount,
  ItemName,
  ItemNameEnglishLanguage,
  ItemCode,
  ItemShortCode,
  PrimaryUnitOfMeasure,
  PrimaryUOM,
  SecondaryUnitOfMeasure,
  ProductType,
  BussinessUnit
  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
	  ,Amount
	  ,UOM
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY ItemId desc) as rownumber , COUNT(*) OVER () as TotalCount,[ItemId],
      ItemName,
	  ItemNameEnglishLanguage,
      ItemCode,
      ItemShortCode,
	  PrimaryUnitOfMeasure,
	  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
	  SecondaryUnitOfMeasure,
	  ProductType,
	  BussinessUnit
	  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo] 
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  from Item WHERE ItemType is null and IsActive = 1 and ItemOwner = 1
	  and ItemId in (select fi.ItemId from FavouriteItem fi where fi.ItemId = Item.ItemId and fi.CompanyId = @companyId)) as tmp
	  WHERE (tmp.ItemName  like '%'+@searchValue+'%')
	  order by  tmp.ItemId

	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)

End;
Else
Begin
	
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,[ItemId],
  rownumber,TotalCount,
  ItemName,
  ItemNameEnglishLanguage,
  ItemCode,
  ItemShortCode,
  PrimaryUnitOfMeasure,
  PrimaryUOM,
  SecondaryUnitOfMeasure,
  ProductType,
  BussinessUnit
  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
	  ,Amount
	  ,UOM
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY ItemId desc) as rownumber , COUNT(*) OVER () as TotalCount,[ItemId],
      ItemName,
	  ItemNameEnglishLanguage,
      ItemCode,
      ItemShortCode,
	  PrimaryUnitOfMeasure,
	  0 as PrimaryUOM,
	  SecondaryUnitOfMeasure,
	  ProductType,
	  BussinessUnit
	  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo] 
	  ,(select ItemBasePrice.Price from ItemBasePrice where ItemBasePrice.ItemLongCode = Item.ItemCode) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  from Item WHERE ItemType is null and IsActive = 1
	  and ItemOwner = @companyId) as tmp
	  WHERE (tmp.ItemName  like '%'+@searchValue+'%')
	  order by  tmp.ItemId

	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)

End;


END
