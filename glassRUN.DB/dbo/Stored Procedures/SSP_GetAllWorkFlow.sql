CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlow]
AS
BEGIN
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,*
			,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText,ISnull(wfr.IsForNextStep,0) as IsForNextStep
				,Isnull(l.Field3,'0') as IsJsonRequiredFromServer
	  ,Isnull(l.Field4,'-') as ServicesAction
		from WorkFlowRules wfr join Rules wr 
		on wfr.RulesId=wr.RuleId
		left join [LookUp] l on CONVERT(nvarchar(10),wr.[RuleType]) =l.Code
		where wfr.[WorkFlowCode]=WorkFlowOut.WorkFlowCode and wr.IsActive=1 and wfr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML))
	from (Select 
					[WorkFlowId] ,
					[WorkFlowId] As Id ,
					[WorkFlowCode] ,
					[WorkFlowName] ,
					[WorkFlowName] As Name,
					[WorkFlowRule] ,
					[CompanyId] ,
					[FromDate],
					[ToDate],
					[IsActive] ,
					(Select COUNT(WorkFlowRulesId) from WorkFlowRules wfr where wfr.WorkFlowCode=[WorkFlow].WorkFlowCode) as WorkFlowRulesCount
	FROM [dbo].[WorkFlow]
	 WHERE IsActive=1 and ProcessType=4501 ) as WorkFlowOut order by WorkFlowOut.WorkFlowRulesCount desc
	FOR XML path('WorkflowList'),ELEMENTS,ROOT('Workflow')) AS XML)
	
END
