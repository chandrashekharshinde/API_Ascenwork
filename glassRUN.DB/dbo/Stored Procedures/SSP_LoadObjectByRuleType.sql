CREATE PROCEDURE [dbo].[SSP_LoadObjectByRuleType] --'<Json><PageId>1</PageId></Json>'
(
@xmlDoc XML 
)
AS

BEGIN
DECLARE @intPointer INT;
declare @RuleType bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RuleType = tmp.[RuleType]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[RuleType] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array] , 
ObjectRuleTypeMappingId,
ObjectRuleTypeMappingId as LookupID,
RuleType,
ObjectName,
ObjectName as Name,
IsActive from ObjectRuleTypeMapping where IsActive = 1 and (RuleType = @RuleType or @RuleType=0)
	FOR XML path('ObjectRuleTypeMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END
