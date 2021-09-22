CREATE PROCEDURE [dbo].[SSP_PageLevelConfigurationForApp]-- '<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>0</CompanyId><UserId>0</UserId><RoleId>0</RoleId><UserName>Subd1</UserName></Json>'
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


if(exists(select *From  PageWiseConfiguration  where UserId=@UserId))begin set @roleId  = 0endelse beginset @UserId  = 0end;set @UserId  = 0



;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array],
pwc.SettingName,
pwc.SettingValue ,
pwc.RoleId,
pwc.UserId,
pwc.CompanyId,
pwc.PageId,
p.PageName,
p.ControllerName as PageURL
from PageWiseConfiguration pwc join Pages p on p.PageId=pwc.PageId
where pwc.IsActive=1 and p.PageType=@PageType
and(pwc.RoleId=@RoleId  and pwc.UserId =@UserId)
and (p.ControllerName=@PageURL or @PageURL='')
				
	FOR XML path('PageWiseConfigurationList'),ELEMENTS,ROOT('Json')) AS XML)

	  

END
