CREATE PROCEDURE [dbo].[SSP_GetWorkFlowStepByCode]
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
	 WHERE  IsActive=1 and WorkFlowCode = @WorkFlowCode
	FOR XML path('WorkFlowStepList'),ELEMENTS,ROOT('Json')) AS XML)
	
END