CREATE PROCEDURE [dbo].[SSP_AppWorkFlowServiceAction] --1,'WorkFlow-PC'
(
@StageId bigint,
@WorkFlowCode nvarchar(100)
)
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] , WorkFlowStepId,WorkFlowCode,ActivityName,ServiceAction,
StageId,SequenceNo,IsAutomated,IsResponseRequired,ResponsePropertyName,
IsActive,
Convert(xml ,Rules),
Convert(xml ,WorkFlowSub) 
from (
SELECT 
		wsp.[WorkFlowStepId]  
		,wsp.WorkFlowCode
      ,wsp.ActivityName 
      ,ac.ServiceAction
      ,wsp.StatusCode as StageId
      ,wsp.[SequenceNo]
		,Isnull(wsp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(ac.IsResponseRequired,0) as [IsResponseRequired]
	  , ac.ResponsePropertyName
      ,wsp.[IsActive]
	
	  ,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText, ISnull(wpr.IsForNextStep,0) as IsForNextStep
		from WorkFlowStepRules wpr join Rules wr 
		on wpr.WorkFlowRulesId=wr.RuleId
		where wpr.WorkFlowCode=wsp.WorkFlowCode and wpr.StatusCode=wsp.StatusCode  and wr.IsActive=1 and wpr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		) as Rules
		,
		(SELECT CAST((SELECT 'true' AS [@json:Array] , 
		wssp.[CodeFlowId]
      ,wssp.[CodeFlowName]
      ,wssp.[ServiceAction]
      ,wssp.StatusCode as StageId
      ,wssp.[SequenceNo]
      ,Isnull(wssp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(wssp.[IsResponseRequired],0) as [IsResponseRequired]
	  ,wssp.ResponsePropertyName
      ,wssp.[IsActive]
	  ,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText,ISnull(wspr.IsForNextStep,0) as IsForNextStep
		from CodeFlowRules wspr join Rules wr 
		on wspr.WorkFlowRulesId=wr.RuleId
		where wspr.CodeFlowId=wssp.CodeFlowId and wr.IsActive=1 and wspr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		)
	from CodeFlow wssp
	where wssp.IsActive = 1 and wssp.WorkFlowStepId=wsp.[WorkFlowStepId]
	order by wssp.SequenceNo
	FOR XML path('WorkFlowSubStageServiceActionMappingList'),ELEMENTS,ROOT('WorkFlowSubStageServiceActionMapping')) AS XML)) as  WorkFlowSub
	from WorkFlowStep wsp join [dbo].[Activity] ac on wsp.StatusCode=ac.StatusCode
	where wsp.IsActive = 1 
	--and wsp.WorkFlowCode=@WorkFlowCode and wsp.SequenceNo > (select wf.SequenceNo from WorkFlowStep wf where wf.StatusCode = @StageId and wf.WorkFlowCode=@WorkFlowCode) 
		
	) as d Order by [SequenceNo]
FOR XML path('WorkFlowStageServiceActionMappingList'),ELEMENTS,ROOT('WorkFlowStageServiceActionMapping')) AS XML)

END
