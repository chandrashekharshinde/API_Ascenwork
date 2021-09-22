CREATE PROCEDURE [dbo].[SSP_GetOwnCatalogItemsForB2B] --'<Json><ServicesAction>GetAllFavouriteItemAddedForSubDApp</ServicesAction><CompanyId>10001</CompanyId><searchValue></searchValue><ProductType>YourProducts</ProductType></Json>'

@xmlDoc XML


AS

BEGIN


declare @CompanyId bigint
declare @CreatedBy bigint
declare @CompanyMnemonic nvarchar(500)
declare @searchValue nvarchar(500)
declare @ProductType nvarchar(50)
declare @ItemSection nvarchar(200)
DECLARE @intPointer INT;
Declare @IsEndBuyer bit=0
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@searchValue =tmp.searchValue,
@CompanyId = tmp.CompanyId,
@ProductType = tmp.ProductType,
@ItemSection=tmp.ItemSection,
@username=tmp.userName

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			searchValue nvarchar(500),
			userName nvarchar(500),
			ItemSection nvarchar(200),
			CompanyId bigint,
			ProductType nvarchar(50)
			)tmp;


Select @CreatedBy=LoginId from Login where UserName=@username
select @CompanyMnemonic=CompanyMnemonic from Company where Companyid=@CompanyId

IF Not EXISTS (Select HierarchyId from Hierarchy where ParentCompanyId=@CompanyId)
begin
   set @IsEndBuyer=1
end





;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT distinct 'true' AS [@json:Array]  ,  
	  I.ItemId,
      I.ItemName,
      I.ItemCode,
	  I.ItemCode as ProductCode,
      I.ItemShortCode,
	  I.PrimaryUnitOfMeasure as PrimaryUOM,
	  I.ProductType
      ,Isnull(I.[Description],'') as [Description]
      ,Isnull(I.[ImageUrl],'') as [ImageUrl]
	  ,'1' as ItemSelected
      ,I.[BranchPlant]
	  ,'0'as IsOwnProduct
	  ,Isnull(I.[ItemOwner],0) as ItemOwner
	  ,(SELECT [dbo].[fn_GetPriceOfItem] (I.[ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (I.PrimaryUnitOfMeasure)) as UOM ,Case when @IsEndBuyer = 0 then Isnull((Select top 1 IT.IsActive from ItemSupplier IT where IT.ItemId=I.ItemId and IT.CompanyId=@CompanyId),0) else Isnull(ISP.IsActive,0) end as IsActive
	  --,Case when Isnull(ISP.IsActive,0) = 1 then '1' else '0' end as IsActive
	  ,I.Brand
	  ,@CompanyId as CompanyId
	  ,@CompanyMnemonic as CompanyMnemonic
	  ,@CreatedBy as CreatedBy
	  ,Case When @IsEndBuyer=0 then @CompanyId else ISP.CompanyId  end as ParentCompanyId
	  from Item I Left Join ItemSupplier ISP on I.ItemId=ISP.ItemId  WHERE  
	  (ISP.CompanyId 
	   in (SELECT hi.ParentCompanyId FROM [dbo].Hierarchy hi where hi.CompanyId = @CompanyId and hi.IsActive=1 and ISNULL(hi.ParentCompanyId,0) != 0 ) 
	   or Isnull(I.[ItemOwner],0)=@CompanyId or ISP.CompanyId=@CompanyId)
	   and ISP.CompanyId != CASE
              WHEN @IsEndBuyer = 1 THEN @CompanyId
              ELSE 0
           END

	  order by ItemName
	  FOR XML PATH('ItemList'),ELEMENTS,ROOT('Json')) AS XML)

END
