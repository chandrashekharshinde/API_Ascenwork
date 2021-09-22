CREATE PROCEDURE [dbo].[SSP_LoadProfileByRoleId] --29

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @roleId BIGINT
declare @PageId BIGINT
declare @ObjectId BIGINT

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @roleId = tmp.[RoleId],
		@PageId = tmp.[PageId],
		@ObjectId = tmp.[ObjectId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[RoleId] bigint,
				[PageId] bigint,
				[ObjectId] bigint
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array], 
l.UserName as [Name],
l.UserName,
l.RoleMasterId,
l.LoginId,
l.LoginId as Id,
l.IsActive
FROM  [Login] l 
WHERE RoleMasterId in (select RoleMasterId from RoleMaster where RoleMasterId = @roleId) 
and l.LoginId not in (select gcc.LoginId from GridColumnConfiguration gcc where gcc.RoleId=@roleId and gcc.PageId=@PageId and gcc.ObjectId=@ObjectId)
order by l.UserName
FOR XML path('ProfileList'),ELEMENTS,ROOT('Json')) AS XML)
END
