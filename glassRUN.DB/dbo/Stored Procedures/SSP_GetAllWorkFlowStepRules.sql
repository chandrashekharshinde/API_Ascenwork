
CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowStepRules]

AS
BEGIN
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
					[WorkFlowStepRulesId] ,
					[RuleDescription] ,
					[WorkFlowCode],
					[StatusCode],
					[WorkFlowRulesId] ,
					[IsForNextStep] ,
					[IsActive] 
	FROM [dbo].[WorkFlowStepRules]
	FOR XML path('WorkFlowStepRulesList'),ELEMENTS,ROOT('Json')) AS XML)
	
END