CREATE PROC [dbo].[DSP_DeleteRoleWiseFieldAccessById]
(
@RoleWiseFieldAccessId BIGINT
)
AS
BEGIN
	
	UPDATE dbo.RoleWiseFieldAccess
	SET IsActive=0
	WHERE RoleWiseFieldAccessId=@RoleWiseFieldAccessId

	SELECT @RoleWiseFieldAccessId AS RoleWiseFieldAccessId

END
