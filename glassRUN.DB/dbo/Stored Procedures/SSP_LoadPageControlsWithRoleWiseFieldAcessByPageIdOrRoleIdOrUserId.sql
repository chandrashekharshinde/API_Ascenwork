CREATE PROCEDURE [dbo].[SSP_LoadPageControlsWithRoleWiseFieldAcessByPageIdOrRoleIdOrUserId]-- '<Json><ServicesAction>LoadPageControlsByPageId</ServicesAction><PageId>7</PageId></Json>'
@xmlDoc XML
AS 
 BEGIN 
	
	DECLARE @intPointer INT
Declare @pageId bigint
Declare @RoleId bigint
Declare @UserId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@pageId = tmp.[PageId],
		@RoleId = tmp.[RoleId],
		@UserId = tmp.[UserId]


FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
      [PageId] bigint,
	 [RoleId] bigint,
	 [UserId] bigint
   )tmp;




	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast(( select pc.PageId  , 
pc.PageControlId ,
pc.ControlType  ,
 pc.ControlName , 
   isnull(rwfa.RoleWiseFieldAccessId,0 ) as RoleWiseFieldAccessId ,
   isnull(rwfa.AccessId,0 ) as AccessId ,
    isnull( rwfa.RoleId,0)  as RoleId ,
	isnull(rwfa.LoginId ,0) as LoginId,
	isnull(rwfa.IsActive ,0) as IsActive
From PageControl   pc  left join  RoleWiseFieldAccess  rwfa  on pc.PageId=rwfa.PageId 
  and pc.PageControlId =rwfa.PageControlId     and (rwfa.RoleId=@RoleId or  rwfa.LoginId =@UserId)
   where pc.PageId=@pageId
  FOR XML PATH('PageControlList'),ELEMENTS,ROOT('Json')) AS XML)
 
END
