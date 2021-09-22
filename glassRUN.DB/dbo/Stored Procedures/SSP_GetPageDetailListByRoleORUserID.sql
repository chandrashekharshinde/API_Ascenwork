CREATE PROCEDURE [dbo].[SSP_GetPageDetailListByRoleORUserID]-- '<Json><ServicesAction>GetPageRoleWiseAccessDetailByRoleORUserID</ServicesAction><RoleId>3</RoleId></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
declare @roleId BIGINT
Declare @UserId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @roleId = tmp.[RoleId],
@UserId =tmp.[UserId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
							[RoleId] bigint,
							 [UserId] bigint
			)tmp;




if(@UserId is  not  null)
begin
     
	if( not exists  (select *From  RoleWisePageMapping   where IsActive=1  and LoginId=@UserId  )) 

	begin

	set @roleId=(select RoleMasterId  From  Login  where LoginId=@UserId)

	end
	else
	begin
	set @roleId=0

	end


end
else if(@UserId is    null)
begin


set @UserId=0

end;




WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  




	   	Select Cast((SELECT	 (Select Cast((SELECT	 [RoleMasterId]
      ,[RoleName]
      ,[Description]
	  ,PolicyName
			
   from RoleMaster
   WHERE IsActive = 1 AND RoleMasterId = @roleId

      FOR XML path('RoleMaster'),ELEMENTS) AS xml)) ,
	  (Select Cast((SELECT 'true' AS [@json:Array],  p.PageId  ,
			   p.PageName  , 
			   isnull(RoleWisePageMappingId,0)  as RoleWisePageMappingId ,
				IsNUll(RoleMasterId,0) as RoleMasterId ,
				IsNUll(AccessId,0) as AccessId  ,
				isnull(rwpm.IsActive,0) as IsActive,
				 (Select Cast((select  'true' AS [@json:Array], pc.PageId  , 
pc.PageControlId ,
pc.ControlType  ,
 pc.ControlName , 
 pc.DisplayName,
   isnull(rwfa.RoleWiseFieldAccessId,0 ) as RoleWiseFieldAccessId ,
   isnull(rwfa.AccessId,0 ) as AccessId ,
    @RoleId  as RoleId ,
	@UserId as LoginId,
	isnull(rwfa.IsActive ,0) as IsActive
From PageControl   pc  left join  RoleWiseFieldAccess  rwfa  on pc.PageId=rwfa.PageId 
  and pc.PageControlId =rwfa.PageControlId  and rwfa.IsActive=1    and (rwfa.RoleId =@RoleId  and rwfa.LoginId =@UserId)
   where pc.PageId=p.PageId
				

      FOR XML path('RoleWiseFieldAccessList'),ELEMENTS) AS xml)) 
				 From dbo.Pages  p  left join  dbo.RoleWisePageMapping    rwpm  on rwpm.PageId=p.PageId
and p.IsActive=1  and (rwpm.RoleMasterId = @roleId   and rwpm.LoginId=@UserId)
				

      FOR XML path('RoleWisePageMappingList'),ELEMENTS) AS xml))   FOR XML PATH('Json'),ELEMENTS)AS XML)



 

END