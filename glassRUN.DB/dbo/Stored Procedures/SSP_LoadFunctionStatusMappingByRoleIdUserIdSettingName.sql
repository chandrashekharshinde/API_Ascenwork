
CREATE PROCEDURE [dbo].[SSP_LoadFunctionStatusMappingByRoleIdUserIdSettingName] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><SettingName>PromiseDateScheduler</SettingName><RoleId>4</RoleId><UserId>0</UserId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @settingName nvarchar(150)
declare @roleId BIGINT
declare @userId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @settingName = tmp.[SettingName],
@roleId = tmp.[RoleId],
@userId = tmp.[UserId]

FROM OPENXML(@intpointer,'Json',2)
WITH
(
[SettingName] nvarchar(150),
[RoleId] bigint,
[UserId] bigint
)tmp;


if(ISNULL((select UserId from FunctionStatusMapping where UserId = @userId and settingname = @settingName),'') = '')
Begin

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast((SELECT * from FunctionStatusMapping  where roleid=@roleId and settingname = @settingName
FOR XML path('FunctionStatusMapping'),ELEMENTS,ROOT('Json')) AS XML)

End
else
begin
	
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast((SELECT * from FunctionStatusMapping  where roleid=@roleId  and userid=@userid and settingname = @settingName
FOR XML path('FunctionStatusMapping'),ELEMENTS,ROOT('Json')) AS XML)

end


END