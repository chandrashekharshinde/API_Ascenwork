
CREATE PROCEDURE [dbo].[SSP_GetAllItemForSubDApp] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>2</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

@xmlDoc XML


AS

BEGIN

declare @PageIndex INT
declare @companyId bigint
declare @PageSize INT
Declare @BrandCount int
declare @searchValue nvarchar(500)

set @BrandCount=0;
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

 select *  into #BrandTypeList
			FROM OPENXML(@intpointer,'Json/BrandTypeList',2)
			WITH
			(
				[BrandName] nvarchar(2000)
			)tmp1;select @BrandCount=count(*) from #BrandTypeList;


SELECT 

@PageIndex =(tmp.pageIndex),
@PageSize =tmp.pageSize,
@searchValue =tmp.searchValue,
@companyId = tmp.CompanyId

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			pageIndex INT,
			pageSize INT,
			searchValue nvarchar(500),
			CompanyId bigint
			)tmp;


set @PageIndex =@PageIndex+1;

if @BrandCount>0
begin
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
	  ,IsItemCatalog
	  ,Brand
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
	  ,[Brand]
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  ,CASE WHEN (select count(*) from FavouriteItem fi where fi.ItemId = Item.ItemId and fi.CompanyId = @companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog
	  from Item WHERE ItemType is null and IsActive = 1 and ItemOwner = 1) as tmp
	  WHERE tmp.Brand in( select BrandName from  #BrandTypeList) and  (tmp.ItemName  like '%'+@searchValue+'%')
	  order by  tmp.ItemId
	  OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
end
else
begin
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
	  ,IsItemCatalog
	  ,Brand
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
	  ,[Brand]
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  ,CASE WHEN (select count(*) from FavouriteItem fi where fi.ItemId = Item.ItemId and fi.CompanyId = @companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog
	  from Item WHERE ItemType is null and IsActive = 1 and ItemOwner = 1) as tmp
	  WHERE (tmp.ItemName  like '%'+@searchValue+'%')
	  order by  tmp.ItemId
	  OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
end
END
