CREATE PROCEDURE [dbo].[SSP_GetFavouriteItemsForB2B] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>2</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @searchValue nvarchar(500)
declare @ProductType nvarchar(50)
declare @ItemSection nvarchar(200)
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@searchValue =tmp.searchValue,
@companyId = tmp.CompanyId,
@ProductType = tmp.ProductType,
@ItemSection=tmp.ItemSection

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			searchValue nvarchar(500),
			ItemSection nvarchar(200),
			CompanyId bigint,
			ProductType nvarchar(50)
			)tmp;

Declare @ShowImage nvarchar(30)='0'
Select @ShowImage=SettingValue from SettingMaster where SettingParameter='ShowImage'

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
	  [ItemId],
      ItemName,
      ItemCode,
      ItemShortCode,
	  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
	   ProductType
      ,Isnull([Description],'') as [Description]
      ,case when @ShowImage='1' then Isnull([ImageUrl],'')  else '' end as [ImageUrl]
	  ,'1' as ItemSelected
      ,[BranchPlant]
	  ,Isnull([ItemOwner],0) as ItemOwner
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  ,Brand
	  ,CASE WHEN Item.ItemOwner = @companyId THEN 'Other Products' ELSE 'Heineken Products' END As ItemOwnerSection
	  from Item WHERE IsActive = 1 and (ItemName  like '%'+@searchValue+'%' or @searchValue='')
	  and ItemCode in (Select FavouriteItem.ItemCode from FavouriteItem where FavouriteItem.CompanyId=@companyId and FavouriteItem.IsActive = 1)
	  order by ItemName
	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)

END
