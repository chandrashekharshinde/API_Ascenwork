CREATE PROCEDURE [dbo].[SSP_GetItemsForB2B] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>10001</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

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


Declare @SettingValue nvarchar(30)='0'
Declare @ShowImage nvarchar(30)='0'
Declare @Description nvarchar(30)='0'

Select @ShowImage=SettingValue from SettingMaster where SettingParameter='ShowImage'
Select @Description=SettingValue from SettingMaster where SettingParameter='Description'


Select @SettingValue=SettingValue from SettingMaster where SettingParameter='IsItemsAvailableOffline'



;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((

Select  'true' AS [@json:Array]  ,  * from (

SELECT  
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
	  ,Brand
	  ,'Heineken Products' As ItemOwnerSection
	  from Item WHERE IsActive = 1 
	  and isnull(ItemOwner,0) in (select ID FROM [dbo].[fngetHierarchyParent] (@companyId))
	  and @SettingValue='1'

Union 

SELECT  
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
	  ,Brand
	  ,'Other Products' As ItemOwnerSection
	  from Item WHERE IsActive = 1 
	  and isnull(ItemOwner,0) in (@companyId)
	  and @SettingValue='1'

Union 

SELECT   
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
	  ,Brand
	  ,'Heineken Products' As ItemOwnerSection
	  from Item WHERE IsActive = 1 
	   and @SettingValue='1'
	   and ItemId in (Select ItemSupplier.ItemId from ItemSupplier where ItemSupplier.CompanyId 
	   in (SELECT hi.ParentCompanyId FROM [dbo].Hierarchy hi where hi.CompanyId = @companyId and hi.IsActive=1 and ISNULL(hi.ParentCompanyId,0) != 0 ) 
	   and ItemSupplier.IsActive = 1)
	   and isnull(ItemOwner,0)in(SELECT ID FROM [dbo].[fngetHierarchyParent] (@companyId))



	   ) as Item order by ItemName

	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)



END