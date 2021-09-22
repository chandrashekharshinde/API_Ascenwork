
CREATE PROCEDURE [dbo].[SSP_AllRuleFunctionList] --'<Json><ServicesAction>LoadRuleFunctions</ServicesAction><CompanyId>12</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
rf.RuleFunctionId,
rf.FunctionText,
rf.FunctionType,
rf.IsActive ,
(select cast ((SELECT  'true' AS [@json:Array]  ,rfp.[RuleFunctionParametersId]
      ,rfp.[RuleFunctionId]
      ,LOWER(rfp.[ParameterType]) as [ParameterType]
      ,LOWER(rfp.[ParameterDataType]) as [ParameterDataType]
	  ,isnull(rfp.SequenceNumber,0) as SequenceNumber
  FROM [dbo].[RuleFunctionParameters] rfp where rfp.IsActive=1 and rfp.[RuleFunctionId]=rf.[RuleFunctionId]
  order by isnull(rfp.SequenceNumber,0) asc
	 FOR XML path('RuleFunctionParametersList'),ELEMENTS) AS XML))
from RuleFunction rf where rf.IsActive = 1

	FOR XML path('RuleFunctionList'),ELEMENTS,ROOT('Json')) AS XML)
END
