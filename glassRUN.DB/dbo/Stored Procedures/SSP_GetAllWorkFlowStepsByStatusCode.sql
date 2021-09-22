﻿

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
 
	  WHERE IsActive = 1 and  StatusCode=1