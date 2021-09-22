CREATE PROCEDURE [dbo].[SSP_GetAllFilterParametersByPageId]-- '<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>0</CompanyId><UserId>0</UserId><RoleId>0</RoleId><UserName>Subd1</UserName></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
Declare @UserId bigint
declare @RoleId BIGINT
declare @CompanyId bigint
Declare @UserName nvarchar(250)
declare @PageURL nvarchar(250)=''
Declare @PageId bigint
Declare @PageType bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc





SELECT @RoleId = tmp.[RoleId],
@UserId = tmp.[UserId],
@CompanyId = tmp.[CompanyId],
@UserName =tmp.[UserName],
@PageType=tmp.[PageType],
@PageURL=tmp.[pageUrl]
	
FROM OPENXML(@intpointer,'Json',2)
WITH
(	
	[PageType] bigint,
	[RoleId] bigint,
	[UserId] bigint,
	[CompanyId] bigint,
	UserName nvarchar(250),
	pageUrl nvarchar(250)
)tmp;

select @roleId=RoleMasterId,@UserId=LoginId  From Login  where UserName=@UserName


IF NOT EXISTS (select rwf.FilterMasterId from RoleWiseFilterMapping rwf where rwf.RoleMasterId=@roleId and LoginId=@UserId) 
begin
set @UserId=0
end


Print @UserId
Print @roleId

--;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

--SELECT CAST((SELECT 'true' AS [@json:Array],
-- pwc.[FilterParametersId]
--,pwc.[PropertyName]
--,pwc.[ResourceKey]
--,pwc.[PropertyType]
--,pwc.[PageId]
--,pwc.[HeaderName]
--,p.PageName
--,p.ControllerName as PageURL
--  FROM [dbo].[FilterParameters] pwc join Pages p on p.PageId=pwc.PageId
--where pwc.IsActive=1 and p.PageType=@PageType
--and (p.ControllerName=@PageURL or @PageURL='')
				
--FOR XML path('FilterParametersList'),ELEMENTS,ROOT('Json')) AS XML)

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array]
,hf.FilterMasterId
,hf.FilterDescription
,hf.PropertyType
,hf.PropertyName
,hf.ResourceKey
,isnull(hf.IsRange,0) as IsRange
,p.ControllerName,
p.ControllerName as PageURL,
(SELECT CAST((SELECT 'true' AS [@json:Array],
cf.FilterMasterId
,cf.PropertyType
,cf.PropertyName
,cf.FromRange
,cf.ToRange
,isnull(cf.IsRange,0) as IsRange
,hf.FilterMasterId as ParentFilterMasterId
,cf.FilterDescription
,(case when (cf.FilterDescription='102' OR cf.FilterDescription='990'OR cf.FilterDescription='525'OR cf.FilterDescription='1'
OR cf.FilterDescription='103'OR cf.FilterDescription='520'OR cf.FilterDescription='101'OR cf.FilterDescription='1027') 
then (select top 1 isnull(res.ResourceValue,cf.FilterDescription) from Resources res where res.IsActive=1  and CultureId=1101 and  res.ResourceKey=( select top 1 Rs.ResourceKey from  RoleWiseStatus Rs where  Rs.RoleId=@RoleId and rs.IsActive=1 and rs.StatusId= CONVERT(bigint,cf.FilterDescription))) 
else cf.FilterDescription end) ResourceValue
from FilterMaster cf where  cf.ParentFilterId=hf.FilterMasterId and cf.IsActive=1  and cf.ParentOrChild='C'
and cf.FilterMasterId in (select rwf.FilterMasterId 
from RoleWiseFilterMapping rwf 
where rwf.RoleMasterId=@roleId and rwf.IsActive=1 
and rwf.LoginId=@UserId
)
order by cf.Sequence 
FOR XML path('ChildFilterList'),ELEMENTS) AS XML))
from FilterMaster hf join PageFilterMapping pfm 
on pfm.FilterMasterId=hf.FilterMasterId 
join Pages p on p.PageId=pfm.PageId
where hf.ParentFilterId=0 and hf.IsActive=1 
and hf.ParentOrChild='P' 
and (p.ControllerName=@PageURL or @PageURL='')
and hf.FilterMasterId in (select rwf.FilterMasterId from RoleWiseFilterMapping rwf where rwf.RoleMasterId=@roleId 
and rwf.IsActive=1 
and rwf.LoginId=@UserId
)
order by hf.Sequence
				
FOR XML path('FilterParametersList'),ELEMENTS,ROOT('Json')) AS XML)
END
