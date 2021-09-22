CREATE PROCEDURE [dbo].[SSP_RuleTypeFunctionMapping] --'<Json><RuleType>0</RuleType></Json>'
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
rfm.RuleTypeId,rfm.RuleFunctionId,rf.FunctionText 
from RuleTypeFunctionMapping rfm join RuleFunction rf 
on rfm.RuleFunctionId=rf.RuleFunctionId 
where (rfm.RuleTypeId = @RuleType or @RuleType=0) 
and rfm.IsActive=1 and rf.IsActive=1
	FOR XML path('RuleTypeFunctionMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END
