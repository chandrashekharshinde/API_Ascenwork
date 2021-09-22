
CREATE PROCEDURE [dbo].[SSP_GetCatalogItemsForB2B] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>2</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

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

if @ItemSection='Heineken'
begin
SELECT @companyId=ID FROM [dbo].[fngetHierarchyParent] (@companyId)
end

Declare @ShowImage nvarchar(30)='0'
Declare @Description nvarchar(30)='0'

Select @ShowImage=SettingValue from SettingMaster where SettingParameter='ShowImage'
Select @Description=SettingValue from SettingMaster where SettingParameter='Description'



if @ItemSection='Heineken'
begin
;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
	  [ItemId],
      ItemName,
      ItemCode,
      ItemShortCode,
	  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
	   ProductType
      ,case when @Description='1' then Isnull([Description],'') else '' end  as [Description]
      ,case when @ShowImage='1' then Isnull([ImageUrl],'')  else '' end as [ImageUrl]
	  ,'0' as ItemSelected
      ,[BranchPlant]
	  ,Isnull([ItemOwner],0) as ItemOwner
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  from Item WHERE IsActive = 1 and (ItemName  like '%'+@searchValue+'%' or @searchValue='')
	  and isnull(ItemOwner,0)=@companyId
	  --and ItemId not in (Select ItemSupplier.ItemId from ItemSupplier where ItemSupplier.CompanyId=@companyId)
	  order by ItemName
	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
End
else
begin
;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
	  [ItemId],
      ItemName,
      ItemCode,
      ItemShortCode,
	  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
	   ProductType
      ,case when @Description='1' then Isnull([Description],'') else '' end  as [Description]
      ,case when @ShowImage='1' then Isnull([ImageUrl],'')  else '' end as [ImageUrl]
	  ,'0' as ItemSelected
      ,[BranchPlant]
	  ,Isnull([ItemOwner],0) as ItemOwner
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  from Item WHERE IsActive = 1 and (ItemName  like '%'+@searchValue+'%' or @searchValue='')

	   and ItemId in (Select ItemSupplier.ItemId from ItemSupplier where ItemSupplier.CompanyId in (SELECT hi.ParentCompanyId FROM [dbo].Hierarchy hi where hi.CompanyId = @companyId and ISNULL(hi.ParentCompanyId,0) != 0 ) and ItemSupplier.IsActive = 1)
	   and isnull(ItemOwner,0)in(SELECT ID FROM [dbo].[fngetHierarchyParent] (@companyId))

	  order by ItemName
	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
end


END