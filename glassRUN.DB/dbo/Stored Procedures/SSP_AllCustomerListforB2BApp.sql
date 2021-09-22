
CREATE PROCEDURE [dbo].[SSP_AllCustomerListforB2BApp] --'<Json><ServicesAction>GetAllSupplierDetailsB2BApp</ServicesAction><CompanyId>142</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0

Declare @RoleId bigint;
Declare @UserId bigint;
Declare @PageName nvarchar (100);
Declare @ShowLocationInformation bit='0'
Declare @ShowLocationInfo nvarchar(50);




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

  set @ShowLocationInfo=(select top 1 SettingValue from PageWiseConfiguration where RoleId=@RoleId and SettingName='ShowLocationInformationforcutomerPage' and Pageid=(select top 1 PageId from Pages where PageName=@PageName)) --and UserId=@UserId)
  --if @ShowLocationInformation='1'
  if @ShowLocationInfo='1'
  Begin
    WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

	 	select cast ((SELECT 'true' AS [@json:Array],c.CompanyId
		,c.LocationName as CompanyName
		,c. LocationCode as  CompanyMnemonic
		,c.[AddressLine1]
		,c.[AddressLine2]
		, '1' as  ShowCustomerListflag
		,c.LocationId
		,c.LocationCode
		,isNull(c.Field4,'NC') ContractOrNonContract
		,isNull(c.Field9,'0') Region 
		,(select top 1 Name from LookUp where LookUpId=c.Field3) As CustomerGroupName
		,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=c.LocationId and p.IsActive=1 and p.ParentCompanyId=@CompanyId),0) as PriorityRating
		,c.Field3 as LookUpId
		,(select top 1 DisplayIcon from LookUp where LookUpId=c.Field3) As Img
		,c.Field3 as CustomerTypeId
		 ,(select L1.loCationId from [Location] L1 where L1.loCationId=@CompanyId) as ParentCompanyId
	  ,(select L1.LocationCode from [Location] L1 where L1.loCationId=@CompanyId) as ParentCompanyCode
		FROM [location] c WHERE c.IsActive = 1 and c.LocationId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId)  and isnull(c.Field3,'0')!=0 order by AddressLine1 asc
	   FOR XML path('CustomerList'),ELEMENTS,ROOT('Json')) AS XML)
  end
  else
  begin
   WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

	 	select cast ((SELECT 'true' AS [@json:Array],c.CompanyId
		,c.CompanyName
		, c.CompanyMnemonic
		,c.[AddressLine1]
		,c.[AddressLine2]
		, '1' ShowCustomerListflag
		,0 as LocationId
		,'0'as LocationCode
		,(select top 1 Name from LookUp where LookUpId=c.Field3) As CustomerGroupName
		,isNull(c.Field4,'NC') ContractOrNonContract
		,isNull(c.Field9,'0') Region 
		,c.Field3 as LookUpId
		,(select top 1 DisplayIcon from LookUp where LookUpId=c.Field3) As Img
		,c.Field3 as CustomerTypeId
		,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=c.companyId and p.IsActive=1 and p.ParentCompanyId=@CompanyId),0) as PriorityRating
	  ,(select c1.companyId from company c1 where c1.CompanyId=@CompanyId) as ParentCompanyId
	  ,(select c1.CompanyMnemonic from company c1 where c1.CompanyId=@CompanyId) as ParentCompanyCode
	   from Company c
	   where c.IsActive = 1 and c.CompanyId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId)
	    and isnull(c.Field3,'0')!=0   order by AddressLine1 asc
	   FOR XML path('CustomerList'),ELEMENTS,ROOT('Json')) AS XML)
  end

  -- set @ShowLocationInfo=(select top 1 SettingValue from PageWiseConfiguration where RoleId=@RoleId and SettingName='ShowLocationInformationforcutomerPage' and Pageid=(select top 1 PageId from Pages where PageName=@PageName)) --and UserId=@UserId)
  ----if @ShowLocationInformation='1'
  --if @ShowLocationInfo='1'
  --Begin
  --  WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

	 --	select cast ((SELECT 'true' AS [@json:Array],Name as CustomerGroupName,LookUpId,[displayIcon] as Img,'1' IsSynced,
		--(select cast ((select 'true' AS [@json:Array],c.CompanyId
		--,c.LocationName as CompanyName
		--,c. LocationCode as  CompanyMnemonic
		--,c.[AddressLine1]
		--,c.[AddressLine2]
		--, '1' as  ShowCustomerListflag
		--,c.LocationId
		--,c.LocationCode
		--,isNull(c.Field4,'NC') ContractOrNonContract
		--,isNull(c.Field9,'0') Region 
		--,(select top 1 Name from LookUp where LookUpId=c.Field3)CustomerGroupName
		--,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=c.LocationId and p.IsActive=1 and p.ParentCompanyId=@CompanyId),0) as PriorityRating
		--,c.Field3 as CustomerTypeId
		-- ,(select L1.loCationId from [Location] L1 where L1.loCationId=@CompanyId) as ParentCompanyId
	 -- ,(select L1.LocationCode from [Location] L1 where L1.loCationId=@CompanyId) as ParentCompanyCode
		--FROM [location] c WHERE c.IsActive = 1 and c.LocationId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId)  and isnull(c.Field3,'0')=LookUp.LookUpId order by AddressLine1 asc
		--FOR XML path('ChildCustomer'),ELEMENTS)AS XML))
		--from LookUp where LookUp.LookUpId 
		--in (select isnull(c1.Field3,'0') from Company c1 where c1.CompanyId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId) and c1.IsActive = 1)
		----where EXISTS (Select c.CompanyId FROM [location] c right join Hierarchy h on  h.CompanyId=c.CompanyId  
		----WHERE c.IsActive = 1 and h.IsActive = 1 and isnull(c.Field3,'0')=LookUp.LookUpId  and h.ParentCompanyId=@CompanyId)
		-- and LookupCategory=47
	 --  FOR XML path('CustomerList'),ELEMENTS,ROOT('Json')) AS XML)
  --end
  --else
  --begin
  -- WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

	 --	select cast ((SELECT 'true' AS [@json:Array],Name as CustomerGroupName,LookUpId,[displayIcon] as Img,'1'IsSynced,
		--(select cast ((select 'true' AS [@json:Array],c.CompanyId
		--,c.CompanyName
		--, c.CompanyMnemonic
		--,c.[AddressLine1]
		--,c.[AddressLine2]
		--, '1' ShowCustomerListflag
		--,0 as LocationId
		--,'0'as LocationCode
		--,(select top 1 Name from LookUp where LookUpId=c.Field3)CustomerGroupName
		--,isNull(c.Field4,'NC') ContractOrNonContract
		--,isNull(c.Field9,'0') Region 
		--,c.Field3 as CustomerTypeId
		--,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=c.companyId and p.IsActive=1 and p.ParentCompanyId=@CompanyId),0) as PriorityRating
	 -- ,(select c1.companyId from company c1 where c1.CompanyId=@CompanyId) as ParentCompanyId
	 -- ,(select c1.CompanyMnemonic from company c1 where c1.CompanyId=@CompanyId) as ParentCompanyCode
	 --  from Company c
	 --  where c.IsActive = 1 and c.CompanyId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId)
	 --   and isnull(c.Field3,'0')=LookUp.LookUpId   order by AddressLine1 asc
		--FOR XML path('ChildCustomer'),ELEMENTS)AS XML))
		--from LookUp where LookUp.LookUpId 
		--in (select isnull(c1.Field3,'0') from Company c1 where c1.CompanyId in (select h.CompanyId from Hierarchy h where  h.IsActive = 1 and h.ParentCompanyId= @CompanyId) and c1.IsActive = 1)
		----EXISTS (Select c.CompanyId FROM Company c right join Hierarchy h on  h.CompanyId=c.CompanyId  
		----WHERE c.IsActive = 1 and h.IsActive = 1 and isnull(c.Field3,'0')=LookUp.LookUpId  and h.ParentCompanyId=@CompanyId) 
		--and LookupCategory=47
	 --  FOR XML path('CustomerList'),ELEMENTS,ROOT('Json')) AS XML)
  --end
end
