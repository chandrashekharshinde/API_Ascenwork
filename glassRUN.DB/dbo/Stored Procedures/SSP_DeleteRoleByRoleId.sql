CREATE PROCEDURE [dbo].[SSP_DeleteRoleByRoleId] --'<Json><ServicesAction>DeleteRoleByRoleId</ServicesAction><roleMasterId>9</roleMasterId></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
declare @roleId BIGINT



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @roleId = tmp.[RoleId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
							[RoleId] bigint
			)tmp;

update RoleMaster  set IsActive=0  where RoleMasterId=@roleId;
 
 
 select @roleId;  

END
