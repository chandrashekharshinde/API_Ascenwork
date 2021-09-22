CREATE PROCEDURE [dbo].[SSP_CustomerApp_AllItemList]

@xmlDoc XML


AS

BEGIN

declare @PageIndex INT
declare @companyId bigint
declare @PageSize INT
declare @searchValue nvarchar(500)


DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


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


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,* from (Select
	 i.ItemId,
	 i.ItemId as  VcItemId,
     i.ItemShortCode ,
	 0 as ParentItemId,
	 32 as ItemType,
	 i.ItemName,
	 (SELECT count(f.ItemCode) FROM [dbo].[FavouriteItem] f Where f.[CompanyId]=@companyId and f.IsActive=1 and f.ItemCode=i.ItemCode) as Favorite,
	 (Select Count(*) from (SELECT ItemCode FROM [dbo].[fnTrendingItems] (i.ItemCode)) as ts where ts.Itemcode=i.ItemCode) as Trending,
	 (Select Count(*) from (SELECT ItemCode FROM [dbo].[fnTopSelling] (i.ItemCode)) as ts where ts.Itemcode=i.ItemCode) as TopSelling,
	 (Select Count(*) from (SELECT ItemCode FROM [dbo].[fnPickedForYouItems] (@companyId)) as ts where ts.Itemcode=i.ItemCode)  as PickedForYou,

	 (Select top 1 ts.ProductQuantity from (SELECT * FROM [dbo].[fnTrendingItems] (i.ItemCode)) as ts where ts.Itemcode=i.ItemCode) as TrendingQty,
	 (Select top 1 ts.ProductQuantity from (SELECT * FROM [dbo].[fnTopSelling] (i.ItemCode)) as ts where ts.Itemcode=i.ItemCode) as TopSellingQty,
	 (Select top 1 ts.ProductQuantity from (SELECT * FROM [dbo].[fnPickedForYouItems] (@companyId)) as ts where ts.Itemcode=i.ItemCode)  as PickedForYouQty,

	 0 as IntQuantity,
	 i.ItemName as VcItemName,
	 i.ItemCode as VcItemCode,
	 i.ProductType,
	 isnull(ItemOwner,0) as ItemOwner,
	 (select dbo.fn_LookupValueById(i.PrimaryUnitOfMeasure)) as  VcUnitMasterName,
	 (select dbo.fn_LookupValueById(i.PrimaryUnitOfMeasure)) as UnitMasterId,
	  50000 as VcAvailableQuota,
	  50000 as IntStockInQuantity,
	  ISNULL((select dbo.fn_GetPriceOfItem(ItemId, (select  ReferenceId From Login where UserName=@username))),0) as IntPrices,
	  i.ImageUrl as VcImageUrl,
      PFI.FocItemCode as IntPromoId,
      isnull(PFI.FocItemQuantity,0) as FocItemQuantity,
      isnull(PFI.ItemQuanity,0) as ItemQuanity
FROM  Item i 
left join PromotionFocItemDetail PFI on i.ItemCode=PFI.ItemCode and  GETDATE() BETWEEN PFI.FromDate AND PFI.ToDate 
where  i.IsActive=1 and Isnull(i.ItemType,'') !='Pallet'
and (isnull(i.ItemOwner,0) in (Select RelatedEntity from EntityRelationship where PrimaryEntity=@companyId) or isnull(i.ItemOwner,0)=1) 

) as ItemList
FOR XML PATH('ItemInfos'),ELEMENTS,ROOT('Json')) AS XML)

END
