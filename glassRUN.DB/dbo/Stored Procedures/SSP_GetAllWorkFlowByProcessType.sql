CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowByProcessType]
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS
BEGIN

DECLARE @intPointer INT;
declare @ProcessType bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ProcessType = tmp.[ProcessType]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProcessType] bigint
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,
[WorkFlowId] ,
[WorkFlowId] As Id ,
[WorkFlowCode] ,
[WorkFlowName] ,
[WorkFlowName] As Name,
[WorkFlowRule] ,
[CompanyId] ,
[FromDate],
[ToDate],
[IsActive] 
,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText,ISnull(wfr.IsForNextStep,0) as IsForNextStep
		from WorkFlowRules wfr join Rules wr 
		on wfr.RulesId=wr.RuleId
		where wfr.[WorkFlowCode]=[WorkFlow].WorkFlowCode and wr.IsActive=1 and wfr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		)
	FROM [dbo].[WorkFlow]
	 WHERE IsActive=1 and ProcessType=@ProcessType
	Order by (Select COUNT(WorkFlowRulesId) from WorkFlowRules wfr where wfr.WorkFlowCode=[WorkFlow].WorkFlowCode) desc
	FOR XML path('WorkflowList'),ELEMENTS,ROOT('Workflow')) AS XML)
	
END
