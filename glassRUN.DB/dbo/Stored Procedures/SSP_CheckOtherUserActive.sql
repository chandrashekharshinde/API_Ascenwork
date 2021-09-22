CREATE PROCEDURE [dbo].[SSP_CheckOtherUserActive] --'<Json><ServicesAction>CheckOtherUserActive</ServicesAction><AccessKey>1e6bf421-0afa-4c2f-8a5a-f7bd539f6419</AccessKey><LoginId>464</LoginId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @LoginId   nvarchar(250)

declare @AccessKey  nvarchar(250)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LoginId = tmp.[LoginId],
@AccessKey = tmp.[AccessKey]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LoginId] bigint,
			[AccessKey] nvarchar(250)
			)tmp;


		


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

SELECT CAST((select UserName,LoginId,AccessKey from Login where AccessKey = @AccessKey and LoginId = @LoginId
	FOR XML path('UserList'),ELEMENTS,ROOT('User')) AS XML)
END