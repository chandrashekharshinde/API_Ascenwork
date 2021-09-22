CREATE PROCEDURE [dbo].[SSP_UserDetails]
(
@xmlDoc XML
)
AS

BEGIN

DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
	SELECT CAST((SELECT 'true' AS [@json:Array], 
					LoginId,
					ProfileId,
					l.RoleMasterId,
					UserName,
					RoleName,
					UserTypeCode,
					UserName +' - '+ RoleName as UserRoleName
	FROM Login l join RoleMaster rm on l.RoleMasterId = rm.RoleMasterId
	where l.IsActive = 1
FOR XML path('UserList'),ELEMENTS,ROOT('Json')) AS XML)
END
