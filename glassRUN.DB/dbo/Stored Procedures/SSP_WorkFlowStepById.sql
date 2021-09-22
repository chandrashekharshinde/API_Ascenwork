
Create PROCEDURE [dbo].[SSP_WorkFlowStepById]
@WorkFlowStepId BIGINT
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
					[WorkFlowStepId] ,
					[WorkFlowCode] ,
					[ActivityName] ,
					[StatusCode] ,
					[ActivityFormMappingId] ,
					[FormName] ,
					[SequenceNo] ,
					[IsAutomated] ,
					[IsActive] 
	FROM [dbo].[WorkFlowStep]
	 WHERE [WorkFlowStepId]=@WorkFlowStepId AND IsActive=1
	FOR XML path('WorkFlowStepList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
