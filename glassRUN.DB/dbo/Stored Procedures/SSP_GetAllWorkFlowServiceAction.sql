
CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowServiceAction] --525,'PSFMLMWF'
(
@StageId bigint,
@WorkFlowCode nvarchar(100)
)
AS
BEGIN

declare @CodeFlowStageId bigint

if exists (select top 1 wf.WorkFlowStepId from CodeFlow wf where wf.StatusCode = @StageId)
BEGIN
set @CodeFlowStageId=@StageId
set @StageId=(Select top 1 ws.StatusCode from WorkFlowStep WS where WS.WorkFlowStepId in( select top 1 wf.WorkFlowStepId from CodeFlow wf where wf.StatusCode = @StageId))
END


if @StageId != 0
begin
if exists (select * from Activity where isnull(RejectedStatus,0)=@StageId)
BEGIN
set @StageId=(select top 1 StatusCode from Activity where isnull(RejectedStatus,0)=@StageId)
END
end;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,WorkFlowCode,WorkFlowStepProcessId,WorkFlowSubStepProcessName,ServiceAction,
StageId,SequenceNo,IsAutomated,IsResponseRequired,ResponsePropertyName,
IsActive,
Convert(xml ,Rules),
Convert(xml ,WorkFlowSub) 
from (

SELECT 
	wssp.[CodeFlowId] as [WorkFlowStepProcessId]
      ,wssp.[CodeFlowName] as WorkFlowSubStepProcessName
	  ,@WorkFlowCode as WorkFlowCode
      ,wssp.ServiceAction
      ,wssp.[StatusCode] as StageId
      ,wssp.[SequenceNo]
      ,Isnull(wssp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(wssp.[IsResponseRequired],0) as [IsResponseRequired]
	  ,wssp.ResponsePropertyName
      ,wssp.[IsActive]
	  ,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText,ISnull(wspr.IsForNextStep,0) as IsForNextStep
	  		,Isnull(l.Field3,'0') as IsJsonRequiredFromServer
	  ,Isnull(l.Field4,'-') as ServicesAction
		from CodeFlowRules wspr join Rules wr 

		on wspr.WorkFlowRulesId=wr.RuleId
			left join [LookUp] l on  convert(nvarchar(10),wr.[RuleType]) =l.Code
		where wspr.CodeFlowId=wssp.CodeFlowId and wr.IsActive=1 and wspr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		)as Rules,
		'' as WorkFlowSub
	from CodeFlow wssp
	where wssp.IsActive = 1  
	and wssp.SequenceNo > (select top 1 wf.SequenceNo from CodeFlow wf where wf.StatusCode = @CodeFlowStageId )
	and wssp.WorkFlowStepId=(select top 1 wf.WorkFlowStepId from CodeFlow wf where wf.StatusCode = @CodeFlowStageId)


Union all

SELECT 
		wsp.[WorkFlowStepId]
      ,wsp.ActivityName as [ProcessName]
	  ,wsp.WorkFlowCode
      ,ac.ServiceAction
      ,wsp.StatusCode as StageId
      ,wsp.[SequenceNo]
		,Isnull(wsp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(ac.IsResponseRequired,0) as [IsResponseRequired]
	  , Isnull(ac.ResponsePropertyName,'-') as ResponsePropertyName
      ,wsp.[IsActive]
	
	  ,(	SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText, ISnull(wpr.IsForNextStep,0) as IsForNextStep
	   		,Isnull(l.Field3,'0') as IsJsonRequiredFromServer
	  ,Isnull(l.Field4,'-') as ServicesAction
		from WorkFlowStepRules wpr join Rules wr 
		on wpr.WorkFlowRulesId=wr.RuleId
				left join [LookUp] l on  convert(nvarchar(10),wr.[RuleType]) =l.Code
		where wpr.WorkFlowCode=wsp.WorkFlowCode and wpr.StatusCode=wsp.StatusCode  and wr.IsActive=1 and wpr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		) as Rules
		,
		(SELECT CAST((SELECT 'true' AS [@json:Array] , 
		wssp.[CodeFlowId]
	  ,wsp.WorkFlowCode
      ,wssp.[CodeFlowName]
      ,wssp.[ServiceAction]
      ,wssp.StatusCode as StageId
      ,wssp.[SequenceNo]
      ,Isnull(wssp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(wssp.[IsResponseRequired],0) as [IsResponseRequired]
	  ,wssp.ResponsePropertyName
      ,wssp.[IsActive]
	  ,(SELECT CAST((SELECT 'true' AS [@json:Array] , wr.RuleText,ISnull(wspr.IsForNextStep,0) as IsForNextStep
	   		,Isnull(l.Field3,'0') as IsJsonRequiredFromServer
	  ,Isnull(l.Field4,'-') as ServicesAction
		from CodeFlowRules wspr join Rules wr 
		on wspr.WorkFlowRulesId=wr.RuleId
					left join [LookUp] l on convert(nvarchar(10),wr.[RuleType]) =l.Code
		where wspr.CodeFlowId=wssp.CodeFlowId and wr.IsActive=1 and wspr.IsActive=1  
			FOR XML path('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
		)
	from CodeFlow wssp
	where wssp.IsActive = 1 and wssp.WorkFlowStepId=wsp.[WorkFlowStepId]
	order by wssp.SequenceNo
	FOR XML path('WorkFlowSubStageServiceActionMappingList'),ELEMENTS,ROOT('WorkFlowSubStageServiceActionMapping')) AS XML)) as  WorkFlowSub
	from WorkFlowStep wsp join [dbo].[Activity] ac on wsp.StatusCode=ac.StatusCode --and isnull(ac.IsApp,0) !=1
	where wsp.IsActive = 1 and wsp.WorkFlowCode=@WorkFlowCode 
	and wsp.SequenceNo > (select case when @StageId = 0 then 0 else (select top 1 wf.SequenceNo from WorkFlowStep wf where wf.StatusCode = @StageId and wf.WorkFlowCode= @WorkFlowCode) end)
		
	) as d Order by [SequenceNo]
FOR XML path('WorkFlowStageServiceActionMappingList'),ELEMENTS,ROOT('WorkFlowStageServiceActionMapping')) AS XML)

END