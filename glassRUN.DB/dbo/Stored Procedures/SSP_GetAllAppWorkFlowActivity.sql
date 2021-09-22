CREATE PROCEDURE [dbo].[SSP_GetAllAppWorkFlowActivity]
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
SELECT CAST((SELECT 'true' AS [@json:Array] , WorkFlowStepId,WorkFlowCode,ActivityName,ActivityShortName,IsStepCompleted,ActivityForm,ActivityFormType,
ActivityFormURL,ActivityDataSource,ServiceAction,IsApp,
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
	  ,ac.ActivityShortName
	  ,0 as IsStepCompleted
      ,wsp.StatusCode as StageId
      ,wsp.[SequenceNo]
	    ,Isnull(ac.[IsApp],0) as [IsApp]
		,Isnull(wsp.[IsAutomated],0) as [IsAutomated]
	  ,Isnull(ac.IsResponseRequired,0) as [IsResponseRequired]
	  , ac.ResponsePropertyName
      ,wsp.[IsActive]
	 ,Isnull((select top 1 AFM.FormType from ActivityFormMapping AFM where AFM.ActivityFormMappingId=wsp.ActivityFormMappingId and AFM.StatusCode=wsp.StatusCode),0) as ActivityFormType
	,Isnull((select top 1 AFM.FormName from ActivityFormMapping AFM where AFM.ActivityFormMappingId=wsp.ActivityFormMappingId and AFM.StatusCode=wsp.StatusCode),'-') as ActivityForm
	,Isnull((select top 1 AFM.FormURL from ActivityFormMapping AFM where AFM.ActivityFormMappingId=wsp.ActivityFormMappingId and AFM.StatusCode=wsp.StatusCode),'-') as ActivityFormURL

	,Isnull((select top 1 AFM.DataSource from ActivityFormMapping AFM where AFM.ActivityFormMappingId=wsp.ActivityFormMappingId and AFM.StatusCode=wsp.StatusCode),'-') as ActivityDataSource

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
	and wsp.WorkFlowCode in (Select w.WorkFlowCode from Workflow w where w.ProcessType !=4501)) as d Order by [SequenceNo]
	FOR XML path('WorkFlowStageServiceActionMappingList'),ELEMENTS,ROOT('WorkFlowStageServiceActionMapping')) AS XML)
	
END
