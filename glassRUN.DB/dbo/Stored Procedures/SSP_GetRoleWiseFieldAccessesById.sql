CREATE PROC [dbo].[SSP_GetRoleWiseFieldAccessesById]
(
@RoleWiseFieldAccessId BIGINT
)
AS
BEGIN
	DECLARE @RoleId BIGINT
    DECLARE @PageId BIGINT  

	SET @RoleId=(SELECT TOP 1 RoleId FROM dbo.RoleWiseFieldAccess WHERE RoleWiseFieldAccessId=@RoleWiseFieldAccessId AND IsActive=1)
	SET @PageId=(SELECT TOP 1 PageId FROM dbo.RoleWiseFieldAccess WHERE RoleWiseFieldAccessId=@RoleWiseFieldAccessId AND IsActive=1)

	SELECT CAST((
	SELECT * FROM dbo.RoleWiseFieldAccess
	--WHERE RoleWiseFieldAccessId=@RoleWiseFieldAccessId 
	WHERE RoleId=@RoleId
	AND PageId=@PageId
	AND IsActive=1
	FOR XML RAW('RoleWiseFieldAccessList'), ELEMENTS, ROOT('RoleWiseFieldAccess')) AS XML)
    

END
