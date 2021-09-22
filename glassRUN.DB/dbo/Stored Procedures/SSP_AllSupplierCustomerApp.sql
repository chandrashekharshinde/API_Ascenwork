

CREATE PROCEDURE [dbo].[SSP_AllSupplierCustomerApp] --'<Json><ServicesAction>GetAllTruckSizeListByVehicleId</ServicesAction><VehicleTypeId>61</VehicleTypeId></Json>'

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0

declare @ItemValue  nvarchar(250);
declare @PageSize INT=0
declare @searchValue nvarchar(500)
declare @PageIndex INT=0
Declare @AreaCount int
set @AreaCount=0;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

 select *  into #RegionTypeList
			FROM OPENXML(@intpointer,'Json/RegionTypeList',2)
			WITH
			(
				[AreaName] nvarchar(2000)
			)tmp1;

select @AreaCount=count(*) from #RegionTypeList;

SELECT
@PageIndex =(tmp.pageIndex),
@PageSize =tmp.pageSize,
@searchValue =tmp.searchValue,
	@CompanyId=tmp.CompanyId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   pageIndex INT,
			pageSize INT,
			searchValue nvarchar(500),
			CompanyId bigint
           
   )tmp;
   set @PageIndex =@PageIndex+1;

   if @AreaCount>0
   Begin
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((
Select 'true' AS [@json:Array] ,CompanyId,CompanyName
      ,CompanyMnemonic
       ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
	  ,Region
	  ,IsItemCatalog
	  ,IsSupplierPresent from (
SELECT   ROW_NUMBER() OVER (ORDER BY CompanyId desc) as rownumber , COUNT(*) OVER () as TotalCount,CompanyId,CompanyName
      ,CompanyMnemonic
       ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
	  ,Region
	  ,CASE WHEN ISNULL((select top 1 RuleId from EntityRelationship fi where fi.PrimaryEntity =@CompanyId and fi.RelatedEntity=Company.CompanyId),0) = 0 THEN 0 ELSE 1 END As IsItemCatalog
	  ,CASE WHEN (select count(*) from EntityRelationship fi where fi.PrimaryEntity=@CompanyId and fi.RelatedEntity=Company.CompanyId) = 0 THEN 0 ELSE 1 END As IsSupplierPresent
	FROM Company WHERE IsActive = 1 and CompanyType=25 ) tmp
	--and CompanyId not in (Select RelatedEntity from EntityRelationship where PrimaryEntity=@companyId)
	 WHERE tmp.Region in ( select [AreaName] from  #RegionTypeList) and (tmp.CompanyName  like '%'+@searchValue+'%')
	  order by  tmp.CompanyId
	  OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY
	FOR XML path('SupplierList'),ELEMENTS,ROOT('Json')) AS XML)
   end
   else
   begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((
Select 'true' AS [@json:Array] ,CompanyId,CompanyName
      ,CompanyMnemonic
       ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
	  ,IsItemCatalog
	  ,IsSupplierPresent from (
SELECT   ROW_NUMBER() OVER (ORDER BY CompanyId desc) as rownumber , COUNT(*) OVER () as TotalCount,CompanyId,CompanyName
      ,CompanyMnemonic
       ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
	  ,CASE WHEN ISNULL((select top 1 RuleId from EntityRelationship fi where fi.PrimaryEntity =@CompanyId and fi.RelatedEntity=Company.CompanyId),0) = 0 THEN 0 ELSE 1 END As IsItemCatalog
	  ,CASE WHEN (select count(*) from EntityRelationship fi where fi.PrimaryEntity=@CompanyId and fi.RelatedEntity=Company.CompanyId) = 0 THEN 0 ELSE 1 END As IsSupplierPresent
	FROM Company WHERE IsActive = 1 and CompanyType=25 ) tmp
	--and CompanyId not in (Select RelatedEntity from EntityRelationship where PrimaryEntity=@companyId)
	 WHERE (tmp.CompanyName  like '%'+@searchValue+'%')
	  order by  tmp.CompanyId
	  OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY
	FOR XML path('SupplierList'),ELEMENTS,ROOT('Json')) AS XML)
END
end

