
Create PROCEDURE [dbo].[SSP_ActivityPossibleStepsByStatusCode]
@StatusCode BIGINT
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
					[ActivityPossibleStepId],
					 [CurrentStatusCode], 
					 [PossibleStatusCode]
					
	from [dbo].[ActivityPossibleSteps]
	 WHERE [CurrentStatusCode]=@StatusCode 
	FOR XML path('ActivityPossibleStepsList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
