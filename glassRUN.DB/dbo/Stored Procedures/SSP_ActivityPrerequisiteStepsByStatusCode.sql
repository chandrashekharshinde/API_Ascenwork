
Create PROCEDURE [dbo].[SSP_ActivityPrerequisiteStepsByStatusCode]
@StatusCode BIGINT
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
					[ActivityPrerequisiteStepId], 
					[CurrentStatusCode], 
					[PrerequisiteStatusCode]
					
	from [dbo].[ActivityPrerequisiteSteps]
	 WHERE [CurrentStatusCode]=@StatusCode 
	FOR XML path('ActivityPrerequisiteStepsList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
