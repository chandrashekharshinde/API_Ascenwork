CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowStepsByStatusCode] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ObjectId>0</ObjectId></Json>'@xmlDoc XMLASBEGINDECLARE @intPointer INT;Declare @objectId bigintEXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @objectId = tmp.[ObjectId]	   FROM OPENXML(@intpointer,'Json',2)			WITH			(			[ObjectId] bigint           			)tmp ;if(@objectId != 0)BEGIN	SET @objectId = (select w1.SequenceNo from WorkFlowStep w1 where w1.StatusCode = @objectId);END;			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) SELECT CAST((SELECT  'true' AS [@json:Array], * from (select [WorkFlowStepId]      ,[WorkFlowCode]      ,[ActivityName]      ,[StatusCode]	  ,[StatusCode] As StageId      ,[ActivityFormMappingId]      ,[FormName]      ,[SequenceNo]      ,[IsAutomated]      ,[IsActive]  FROM [dbo].[WorkFlowStep] 	  WHERE IsActive = 1 and SequenceNo>@objectId	  union	select w1.[WorkFlowStepId]      ,w1.[WorkFlowCode]      ,w1.[ActivityName]      ,cf.StatusCode AS [StatusCode]	  ,cf.StatusCode AS StageId      ,w1.[ActivityFormMappingId]      ,w1.[FormName]      ,w1.[SequenceNo]      ,w1.[IsAutomated]      ,w1.[IsActive]  FROM [dbo].[WorkFlowStep] w1	INNER JOIN CodeFlow cf on w1.WorkFlowStepId = cf.WorkFlowStepId and cf.IsActive = 1	  WHERE w1.IsActive = 1  and w1.SequenceNo>@objectId	   union 	   select    0 as   [WorkFlowStepId]      ,[WorkFlowCode]      ,'Cancel' As [ActivityName]      , 999 as [StatusCode]	  , 999 as [StageId]      ,[ActivityFormMappingId]      ,'Cancel' AS [FormName]      , 1000 as [SequenceNo]      ,[IsAutomated]      ,[IsActive]  FROM [dbo].[WorkFlowStep] 	  WHERE IsActive = 1 and  StatusCode=1	  union 

	   select    0 as   [WorkFlowStepId]
      ,[WorkFlowCode]
      ,'Cancel' As [ActivityName]
      , 980 as [StatusCode]
	  , 980 as [StageId]
      ,[ActivityFormMappingId]
      ,'Cancel' AS [FormName]
      , 1001 as [SequenceNo]
      ,[IsAutomated]
      ,[IsActive]
  FROM [dbo].[WorkFlowStep]
 
	  WHERE IsActive = 1 and  StatusCode=1	  ) tmp	  order by tmp.SequenceNo, tmp.WorkFlowStepId asc	FOR XML path('WorkFlowStepList'),ELEMENTS,ROOT('Json')) AS XML)END