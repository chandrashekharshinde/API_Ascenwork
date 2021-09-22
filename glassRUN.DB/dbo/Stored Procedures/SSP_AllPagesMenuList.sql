
CREATE PROCEDURE [dbo].[SSP_AllPagesMenuList] --'<Json><ServicesAction>LoadMenuList</ServicesAction><RoleMasterId>4</RoleMasterId><CultureId>1102</CultureId></Json>'

@xmlDoc XML

AS
BEGIN

DECLARE @intPointer INT;
Declare @RoleMasterId bigint;
Declare @CultureId bigint;
Declare @UserId bigint=0;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RoleMasterId = tmp.[RoleMasterId],
       @CultureId = tmp.[CultureId],
	   @UserId= tmp.[UserId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[RoleMasterId] bigint,
            [CultureId] bigint,
			[UserId] bigint
			)tmp;



IF NOT EXISTS(SELECT * FROM  RoleWisePageMapping crwpm   WHERE crwpm.LoginId=@UserId and RoleMasterId=@RoleMasterId )
BEGIN
set @UserId=0
End;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array] , p.[PageId]
      ,[ModuleId]
      ,p.[PageName]
	  ,r.ResourceValue as ResourcePageName
      ,[ParentPageId]
      ,[ControllerName]
      ,[ActionName]
      ,[IsReport]
	  ,[PageIcon]
	  ,[SequenceNumber]
      ,[Description]
		  ,(Cast((SELECT 'true' AS [@json:Array] , cp.[PageId]
		  ,[ModuleId]
		  ,[PageName]
		  ,[ParentPageId]
		  ,[ControllerName]
		  ,[ActionName]
		  ,[IsReport]
		  ,[PageIcon]
	      ,[SequenceNumber]
		  ,[Description]
		  ,cp.[IsActive]
		    FROM Pages cp join RoleWisePageMapping crwpm   
			on cp.PageId = crwpm.PageId and crwpm.LoginId=@UserId
			WHERE cp.IsActive = 1 and cp.ParentPageId = p.PageId and  crwpm.RoleMasterId = @roleMasterId
			order by SequenceNumber asc
		    FOR XML path('PagesList'),ELEMENTS) AS XML))
	    FROM Pages p join RoleWisePageMapping rwpm  on p.PageId = rwpm.PageId  and rwpm.LoginId=@UserId
		left join Resources r on p.ResourceKey = r.ResourceKey 
		
		WHERE p.IsActive = 1 and (ParentPageId = 0 or ParentPageId is NULL)   and isnull(p.IsInnerPage,0)=0
		and rwpm.RoleMasterId = @roleMasterId and r.IsActive = 1 and r.CultureId = @CultureId   and  rwpm.IsActive=1
		order by SequenceNumber asc
		FOR XML path('PagesList'),ELEMENTS,ROOT('Json')) AS XML)
END