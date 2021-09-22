CREATE PROCEDURE [dbo].[SSP_StoreCatalogItemsOfflineForB2B] --'<Json><userName>Subd1</userName></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @username = tmp.[userName]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			userName nvarchar(max)

			)tmp;

If (select ISNULL(SettingValue,'0') from SettingMaster where SettingParameter = 'IsCatalogAvailableOffline') = '1'
Begin

SELECT @companyId=(select top 1 ReferenceId from [Login] where UserName = @username)

	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
		  * from (
			select [ItemId],
			  ItemName,
			  ItemCode,
			  ItemShortCode,
			  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
			   ProductType
			  ,Isnull([Description],'') as [Description]
			  ,Isnull([ImageUrl],'') as [ImageUrl]
			  ,'0' as ItemSelected
			  ,[BranchPlant]
			  ,Isnull([ItemOwner],0) as ItemOwner
			  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
			  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
			  ,Brand
			  ,'Heineken Products' As ItemOwnerSection
			  from Item WHERE IsActive = 1
			  and isnull(ItemOwner,0) in (SELECT ID FROM [dbo].[fngetHierarchyParent] (@companyId))
			  
			  UNION

				  select [ItemId],
					  ItemName,
					  ItemCode,
					  ItemShortCode,
					  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
					   ProductType
					  ,Isnull([Description],'') as [Description]
					  ,Isnull([ImageUrl],'') as [ImageUrl]
					  ,'0' as ItemSelected
					  ,[BranchPlant]
					  ,Isnull([ItemOwner],0) as ItemOwner
					  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
					  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
					  ,Brand
					  ,'Other Products' As ItemOwnerSection
					  from Item WHERE IsActive = 1
					  and isnull(ItemOwner,0) = @companyId
			) tmp order by tmp.ItemName
		  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END
ELSE
Begin
	
	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) select cast ((SELECT  'true' AS [@json:Array]  ,1 as data 
   FOR XML PATH('Json'),ELEMENTS)AS XML)

ENd

END
