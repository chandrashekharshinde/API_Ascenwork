CREATE PROCEDURE [dbo].[SSP_GetAllSortingParametersByPageId]-- '<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>0</CompanyId><UserId>0</UserId><RoleId>0</RoleId><UserName>Subd1</UserName></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
Declare @UserId bigint
declare @RoleId BIGINT
declare @CompanyId bigint
Declare @UserName nvarchar(250)
declare @PageURL nvarchar(250)
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



IF NOT EXISTS (select rwf.SortingParametersId from RoleWiseSortingMapping rwf where rwf.RoleMasterId=@roleId and LoginId=@UserId) 
begin
set @UserId=0
end
set @UserId=0

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array]
,sp.SortingParametersId
,sp.PropertyName
,sp.ResourceKey
,sp.PropertyType
,sp.SortingDescription
,p.ControllerName
,p.ControllerName as PageURL
,sp.Sequence
from SortingParameters sp join PageSortingMapping psm 
on psm.SortingParametersId=sp.SortingParametersId 
join Pages p on p.PageId=psm.PageId
where (p.ControllerName=@PageURL or @PageURL='')
and sp.SortingParametersId  in (select rwf.SortingParametersId from RoleWiseSortingMapping rwf where rwf.RoleMasterId=@roleId and LoginId=@UserId)
order by sp.Sequence
				
FOR XML path('SortingParametersList'),ELEMENTS,ROOT('Json')) AS XML)

	  

END
