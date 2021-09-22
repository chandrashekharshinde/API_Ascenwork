

CREATE PROCEDURE [dbo].[SSP_WorkFlowStepRulesById]
@WorkFlowStepRulesId BIGINT
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
	 WHERE [WorkFlowStepRulesId]=@WorkFlowStepRulesId AND IsActive=1
		FOR XML path('WorkFlowStepRulesList'),ELEMENTS,ROOT('Json')) AS XML)
	
END