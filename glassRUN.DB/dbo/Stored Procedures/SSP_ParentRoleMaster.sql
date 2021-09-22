CREATE PROCEDURE [dbo].[SSP_ParentRoleMaster] 
AS
BEGIN

SELECT CAST((SELECT  t.[RoleMasterId],
		t.[RoleName],
		t.[Description],
		t.RoleParentId,
        t.[IsActive],
        t.[CreatedBy],
        t.[CreatedDate]
  FROM RoleMaster t WHERE IsActive = 1 and (RoleParentId = 0 or RoleParentId is NULL)
	FOR XML RAW('RoleMasterList'),ELEMENTS,ROOT('RoleMaster')) AS XML)
END
