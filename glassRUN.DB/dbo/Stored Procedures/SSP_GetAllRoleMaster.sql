CREATE PROCEDURE [dbo].[SSP_GetAllRoleMaster] --'<Json><CarrierId>333</CarrierId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


declare @CompanyType bigint=0

select @CompanyType =tmp.[CompanyType]
			  FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
            [CompanyType] bigint
            )tmp  ;






print @CompanyType;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array], RoleMasterId,RoleName,RoleParentId
  FROM RoleMaster where IsActive = 1   
  and ((RoleMasterId  in (select  Roleid  From  CompanyTypeRoleMapping  where CompanyType=@CompanyType )) or @CompanyType=0)
	FOR XML path('RoleMasterList'),ELEMENTS,ROOT('Json')) AS XML)
END
