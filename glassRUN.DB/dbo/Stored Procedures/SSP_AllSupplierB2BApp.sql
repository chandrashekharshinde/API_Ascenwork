


CREATE PROCEDURE [dbo].[SSP_AllSupplierB2BApp] --'<Json><ServicesAction>GetAllSupplierDetailsB2BApp</ServicesAction><CompanyId>10001</CompanyId><ShowLocationInformation>0</ShowLocationInformation></Json>'

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0
Declare @ShowLocationInformation bit='0'
Declare @ShowLocationInfo nvarchar(50);
Declare @RoleId bigint;
Declare @UserId bigint;
Declare @PageName nvarchar (100);




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	SELECT

	@CompanyId=tmp.CompanyId,
	@ShowLocationInformation=tmp.ShowLocationInformation,
	@RoleId=tmp.RoleId,
	@UserId=tmp.UserId,
	@PageName=tmp.PageName
	FROM OPENXML(@intpointer,'Json',2)
	   WITH
	   (
		 CompanyId bigint,
		 ShowLocationInformation bit,
		RoleId bigint,
		UserId bigint,
		PageName nvarchar (100)
	   )tmp;

  print @CompanyId
  set @ShowLocationInfo=(select top 1 SettingValue from PageWiseConfiguration where RoleId=@RoleId and SettingName='ShowLocationInformation' and Pageid=(select top 1 PageId from Pages where PageName=@PageName)) --and UserId=@UserId)
  --if @ShowLocationInformation='1'
  if @ShowLocationInfo='1'
  Begin
 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
 SELECT CAST((Select 'true' AS [@json:Array] 
	,c.CompanyId
	,c.LocationName as CompanyName
	,c.LocationCode as CompanyMnemonic
	,c.[AddressLine1]
	,c.[AddressLine2]
	,c.LocationId
	,c.LocationCode
	,'1'IsSynced
	,(case  WHEN EXISTS ( select DefaultSupplierID from defaultsupplier s where s.IsActive=1 and s.CompanyId=@CompanyId and s.ParentCompanyId = c.CompanyId) then 1 else 0 end)IsDefault 
	,(select c1.companyId from [Location] c1 where c1.CompanyId=@CompanyId) as ChildCompanyId
	  ,(select c1.LocationCode from [Location] c1 where c1.CompanyId=@CompanyId) as ChildCompanyCode
	FROM [location] c
WHERE c.IsActive = 1  
and c.CompanyId in (select h.ParentCompanyId from Hierarchy h where  h.IsActive = 1 and h.CompanyId= @CompanyId)
	 FOR XML path('SupplierList'),ELEMENTS,ROOT('Json')) AS XML)
 end
 else
  begin
 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
 SELECT CAST((Select 'true' AS [@json:Array] ,
        c.CompanyId
	  ,c.CompanyName
      ,c.CompanyMnemonic
      ,c.[AddressLine1]
      ,c.[AddressLine2]
	  ,0 as LocationId
	  ,'0'as LocationCode
	  ,'1'IsSynced
	  ,(case  WHEN EXISTS ( select DefaultSupplierID from defaultsupplier s where s.IsActive=1 and s.CompanyId=@CompanyId and s.ParentCompanyId = c.CompanyId) then 1 else 0 end)IsDefault 
	  ,(select c1.companyId from company c1 where c1.CompanyId=@CompanyId) as ChildCompanyId
	  ,(select c1.CompanyMnemonic from company c1 where c1.CompanyId=@CompanyId) as ChildCompanyCode
	   from Company c
	   where c.IsActive = 1
	   and c.CompanyId in (select h.ParentCompanyId from Hierarchy h where  h.IsActive = 1 and h.CompanyId= @CompanyId)

	  
	 FOR XML path('SupplierList'),ELEMENTS,ROOT('Json')) AS XML)


 end
end
