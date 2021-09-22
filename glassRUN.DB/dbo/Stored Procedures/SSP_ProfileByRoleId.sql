CREATE PROCEDURE [dbo].[SSP_ProfileByRoleId] --29

@RoleId bigint

AS
BEGIN

SELECT CAST((SELECT  p.ProfileId,
p.Name,
l.UserName,
l.RoleMasterId,
l.LoginId,
l.IsActive
  FROM [Profile] p join [Login] l on p.ProfileId = l.ProfileId
  
  
   WHERE RoleMasterId in (select RoleMasterId from RoleMaster where RoleParentId = 29 or RoleMasterId = 29) and p.IsActive = 1 
	FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)
END
