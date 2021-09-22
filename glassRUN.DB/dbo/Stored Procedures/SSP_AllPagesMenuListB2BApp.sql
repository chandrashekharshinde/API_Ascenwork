
CREATE PROCEDURE [dbo].[SSP_AllPagesMenuListB2BApp] --'<Json><ServicesAction>LoadMenuList</ServicesAction><RoleMasterId>4</RoleMasterId><CultureId>1102</CultureId></Json>'

@xmlDoc XML

AS
BEGIN

DECLARE @intPointer INT;
Declare @RoleMasterId bigint;
Declare @CultureId bigint;
Declare @UserId bigint=0;
Declare @UserName nvarchar(500);


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @UserName = tmp.[UserName],
       @CultureId = tmp.[CultureId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[UserName] nvarchar(500),
            [CultureId] bigint
			)tmp;

set @RoleMasterId=(select top 1 RoleMasterId from [Login] where UserName = @UserName)
set @UserId=(select top 1 LoginId from [Login] where UserName = @UserName)

IF NOT EXISTS(SELECT * FROM  RoleWisePageMapping crwpm   WHERE crwpm.LoginId=@UserId and RoleMasterId=@RoleMasterId )
BEGIN
set @UserId=0
End;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array] , p.[PageId]
      ,p.[PageName]
	  ,p.ResourceKey as ResourcePageName
      ,[ParentPageId]
      ,p.[ControllerName]
      ,[ActionName]
      ,[IsReport]
	  ,[PageIcon]
	  ,[SequenceNumber]
	  ,isnull(p.[ModuleId],0) as [ModuleId]
      ,[Description]
	  ,isnull(p.IsCommingSoonIndicator,'0') as [IsCommingSoonIndicator]
		  ,(Cast((SELECT 'true' AS [@json:Array] , cp.[PageId]
		  ,[PageName]
		  ,cp.ResourceKey as ResourcePageName
		  ,[ParentPageId]
		  ,cp.[ControllerName]
		  ,[ActionName]
		  ,[IsReport]
		  ,[PageIcon]
		  ,isnull(cp.[ModuleId],0) as [ModuleId]
	      ,[SequenceNumber]
		  ,[Description]
		  ,cp.[IsActive]
		  ,isnull(cp.IsCommingSoonIndicator,'0') as [IsCommingSoonIndicator]
		    FROM Pages cp join RoleWisePageMapping crwpm   
			on cp.PageId = crwpm.PageId and crwpm.LoginId=@UserId
			WHERE cp.IsActive = 1 and cp.ParentPageId = p.PageId and  crwpm.RoleMasterId = @RoleMasterId  and  crwpm.IsActive=1
			order by SequenceNumber asc
		    FOR XML path('PagesList'),ELEMENTS) AS XML))
	    FROM Pages p join RoleWisePageMapping rwpm  on p.PageId = rwpm.PageId  and rwpm.LoginId=@UserId
		left join Resources r on p.ResourceKey = r.ResourceKey and r.CultureId = @CultureId and r.IsActive = 1  
		
		WHERE p.IsActive = 1 and (ParentPageId = 0 or ParentPageId is NULL)   and isnull(p.IsInnerPage,0)=0
		and rwpm.RoleMasterId = @RoleMasterId  and  rwpm.IsActive=1
		and p.PageType = 4602
		order by SequenceNumber asc
		FOR XML path('PagesList'),ELEMENTS,ROOT('Json')) AS XML)
END