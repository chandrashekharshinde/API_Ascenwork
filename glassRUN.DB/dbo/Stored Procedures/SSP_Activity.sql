CREATE PROCEDURE [dbo].[SSP_Activity] --'<Json><WorkFlowCode></WorkFlowCode></Json>'
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @WorkFlowCode nvarchar(50)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @WorkFlowCode = tmp.[WorkFlowCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[WorkFlowCode] nvarchar(50)
			)tmp;
if(NOT Exists(select WorkFlowCode from WorkFlowStep where WorkFlowCode = @WorkFlowCode))
BEGIN

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,ProcessType, ActivityId,StatusCode,Header,ParentId,ActivityName,ServiceAction,IsResponseRequired,ResponsePropertyName,ParentSequence,Sequence,ActivityFormMappingId,FormName,IsAutomated,RowNumber,convert(xml,d1),convert(xml,d2)
 from (
		SELECT 
		a.[ProcessType],
		a.[ActivityId],
		a.[StatusCode],
		a.[Header], 
		a.ParentId,
		a.[ActivityName],
		a.[ServiceAction],
		a.[IsResponseRequired],
		a.[ResponsePropertyName],
		(Select top 1 a1.Sequence from Activity a1 where a1.StatusCode=a.ParentId and a1.ParentId=0) as ParentSequence,
		a.[Sequence] as Sequence,
		0 as ActivityFormMappingId,
		'' as FormName,
		0 as IsAutomated,
		ROW_NUMBER() OVER(Partition by Header ORDER BY [Sequence],Header) AS RowNumber,

		(SELECT CAST((SELECT 'true' AS [@json:Array] ,
		[ActivityPossibleStepId],
		[CurrentStatusCode], 
		[PossibleStatusCode]

		from [dbo].[ActivityPossibleSteps]
		WHERE [CurrentStatusCode]=a.[StatusCode]

		FOR XML path('ActivityPossibleStepsList'),ELEMENTS) AS xml)) as d1 ,

		(SELECT CAST((SELECT 'true' AS [@json:Array] ,
		ActivityPrerequisiteStepId,
		[CurrentStatusCode], 
		PrerequisiteStatusCode

		from [dbo].[ActivityPrerequisiteSteps]
		WHERE [CurrentStatusCode]=a.[StatusCode]

		FOR XML path('DependentPossibleStepsList'),ELEMENTS) AS xml)) as d2

		from [dbo].[Activity] a where a.ParentId !=0
		) as d order by ParentSequence,[Sequence]
			FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)


END
ELSE 
BEGIN

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

SELECT CAST((SELECT 'true' AS [@json:Array] ,ProcessType, IsPossibleStep,WorkFlowStepId,ActivityFormMappingId,FormName,IsAutomated,ActivityId,StatusCode,Header,ActivityName,ServiceAction,IsResponseRequired,ResponsePropertyName,ParentSequence,Sequence,RowNumber,convert(xml,d1),convert(xml,d2),convert(xml,d3)
from (
		SELECT 
		CASE WHEN ISNULL(w.WorkFlowStepId,0) = 0 THEN 'false' ELSE 'true' END as IsPossibleStep,
		w.WorkFlowStepId,
		--w.[WorkFlowCode],
		--w.[ActivityName],
		--w.[StatusCode],
		w.[ActivityFormMappingId],
		w.[FormName],
		--w.[SequenceNo],
		w.[IsAutomated],
		a.[ProcessType],
		a.[ActivityId],
		a.[StatusCode],
		a.[Header], 
		a.[ActivityName],
		a.[ServiceAction],
		a.[IsResponseRequired],
		a.[ResponsePropertyName],
		(Select top 1 a1.Sequence from Activity a1 where a1.StatusCode=a.ParentId and a1.ParentId=0) as ParentSequence,
		a.[Sequence] as Sequence,
		
		ROW_NUMBER() OVER(Partition by Header ORDER BY [Sequence],Header) AS RowNumber,

		(SELECT CAST((SELECT 'true' AS [@json:Array] ,
		[ActivityPossibleStepId],
		[CurrentStatusCode], 
		[PossibleStatusCode]

		from [dbo].[ActivityPossibleSteps]
		WHERE [CurrentStatusCode]=a.[StatusCode]

		FOR XML path('ActivityPossibleStepsList'),ELEMENTS) AS xml)) as d1 ,



		(SELECT CAST((SELECT 'true' AS [@json:Array] ,
		ActivityPrerequisiteStepId,
		[CurrentStatusCode], 
		PrerequisiteStatusCode

		from [dbo].[ActivityPrerequisiteSteps]
		WHERE [CurrentStatusCode]=a.[StatusCode]

		FOR XML path('DependentPossibleStepsList'),ELEMENTS) AS xml)) as d2,

		(SELECT CAST((SELECT 'true' AS [@json:Array] ,
		[WorkFlowStepRulesId], 
		[RuleDescription],
		[WorkFlowCode],
		[StatusCode],
		[WorkFlowRulesId], 
		[IsForNextStep],
		[IsActive]

		from [dbo].[WorkFlowStepRules]
		WHERE [StatusCode]=w.[StatusCode] and WorkFlowCode = w.WorkFlowCode and IsActive = 1

		FOR XML path('WorkFlowStepRulesList'),ELEMENTS) AS xml)) as d3

		from [dbo].[Activity] a LEFT JOIN WorkFlowStep w ON a.StatusCode = w.StatusCode and (w.WorkFlowCode = @WorkFlowCode ) and w.IsActive=1
		where a.ParentId !=0
		) as act order by act.ParentSequence,act.Sequence
		FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)


END


END
