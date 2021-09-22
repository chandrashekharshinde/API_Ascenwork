Create PROCEDURE [dbo].[SSP_ResourceDataForApp] --'<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>0</CompanyId><UserId>0</UserId><RoleId>0</RoleId><UserName>Create Enquiry</UserName></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
Declare @UserId bigint
declare @RoleId BIGINT
declare @CompanyId bigint
Declare @UserName nvarchar(250)
Declare @PageId bigint
Declare @PageType bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RoleId = tmp.[RoleId],
@UserId = tmp.[UserId],
@CompanyId = tmp.[CompanyId],
@UserName =tmp.[UserName],
@PageType=tmp.[PageType]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(	
				[PageType] bigint,
				[RoleId] bigint,
				[UserId] bigint,
				[CompanyId] bigint,
				UserName nvarchar(250)
			)tmp;

select @roleId=RoleMasterId,@UserId=LoginId  From Login  where UserName=@UserName

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array],
ResourceId,CultureId ,PageName ,ResourceType,ResourceKey,ResourceValue, IsApp, VersionNo FROM dbo.Resources WHERE   IsActive = 1 and isnull(IsApp,0)=1
				
	FOR XML path('ResourcesList'),ELEMENTS,ROOT('Resources')) AS XML)

	  

END
