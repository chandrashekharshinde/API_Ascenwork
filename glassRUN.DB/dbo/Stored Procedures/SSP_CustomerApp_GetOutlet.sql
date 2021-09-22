
CREATE PROCEDURE [dbo].[SSP_CustomerApp_GetOutlet] --'<Json><ServicesAction>GetOutletList</ServicesAction><OutletTypeList><OutletType>Restaurant</OutletType></OutletTypeList><pageIndex>0</pageIndex><pageSize>15</pageSize><customerId>508</customerId><searchValue></searchValue></Json>'@xmlDoc XMLASBEGINdeclare @PageIndex INTdeclare @PageSize INTdeclare @searchValue nvarchar(500)DECLARE @OutletCount int;Declare @companyId bigint;DECLARE @intPointer INT;-- ISSUE QUERYDECLARE @sql nvarchar(max)Declare @username nvarchar(max)EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc select *  into #OutletTypeList
			FROM OPENXML(@intpointer,'Json/OutletTypeList',2)
			WITH
			(
				[OutletType] nvarchar(2000)
			)tmp1;select @OutletCount=count(*) from #OutletTypeList;SELECT @PageIndex =(tmp.pageIndex),@PageSize =tmp.pageSize,@searchValue =tmp.searchValue,@companyId=tmp.companyId	   FROM OPENXML(@intpointer,'Json',2)			WITH			(			pageIndex INT,			pageSize INT,			searchValue nvarchar(500),			companyId bigint			)tmp;set @PageIndex =@PageIndex+1;if @OutletCount>0begin;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,[CompanyId],rownumber,TotalCount,CompanyName,Code,OutletType,  ContactNumber,ContactPerson,IsItemCatalog,AddressLine1,
AddressLine2,
logofrom (SELECT  ROW_NUMBER() OVER (ORDER BY [CompanyId] desc) as rownumber , COUNT(*) OVER () as TotalCount,[CompanyId],c.CompanyName ,
c.CompanyMnemonic as Code,
c.Field5 as OutletType,
c.AddressLine1,
c.AddressLine2,
(case when isnull(c.logo,0)=0 then 0 else c.logo end) logo,

CASE WHEN (select count(*) from [EntityRelationship] fi where fi.[RelatedEntity] = c.CompanyId and fi.PrimaryEntity=@companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactNumber,
(select top 1 ContactPerson from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactPerson
From company c where c.IsActive=1  and CompanyType=24 --and  c.Field5 in( select OutletType from  #OutletTypeList)) as tmpWHERE   tmp.OutletType in( select OutletType from  #OutletTypeList) and(tmp.CompanyName  like '%'+@searchValue+'%')order by  tmp.CompanyIdOFFSET @PageSize * (@PageIndex - 1) ROWSFETCH NEXT @PageSize ROWS ONLYFOR XML PATH('SearchOutletList'),ELEMENTS,ROOT('Json')) AS XML)endelsebegin	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,[CompanyId],rownumber,TotalCount,CompanyName,Code,OutletType,  ContactNumber,ContactPerson,IsItemCatalog,AddressLine1,
AddressLine2,
logofrom (SELECT  ROW_NUMBER() OVER (ORDER BY [CompanyId] desc) as rownumber , COUNT(*) OVER () as TotalCount,[CompanyId],c.CompanyName ,
c.CompanyMnemonic as Code,
c.Field5 as OutletType,
c.AddressLine1,
c.AddressLine2,
(case when isnull(c.logo,0)=0 then 0 else c.logo end) logo,

CASE WHEN (select count(*) from [EntityRelationship] fi where fi.[RelatedEntity] = c.CompanyId and fi.PrimaryEntity=@companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactNumber,
(select top 1 ContactPerson from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactPerson
From company c where c.IsActive=1  and CompanyType=24) as tmpWHERE (tmp.CompanyName  like '%'+@searchValue+'%')order by  tmp.CompanyIdOFFSET @PageSize * (@PageIndex - 1) ROWSFETCH NEXT @PageSize ROWS ONLYFOR XML PATH('SearchOutletList'),ELEMENTS,ROOT('Json')) AS XML)endEND
