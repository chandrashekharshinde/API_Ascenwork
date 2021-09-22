CREATE PROCEDURE [dbo].[SSP_ActivityPossibleSteps]--'<Json><WorkFlowCode>ds</WorkFlowCode></Json>'
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @StatusCode bigint



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @StatusCode = tmp.[StatusCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[StatusCode] bigint
			)tmp;

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

		SELECT CAST((SELECT 'true' AS [@json:Array] 
		,a.StatusCode
		,a.ActivityName 
		from ActivityPossibleSteps aps 
		join Activity a on a.StatusCode=aps.PossibleStatusCode 
		where aps.CurrentStatusCode=@StatusCode
		FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)

--WITH cte AS 
--  (
-- select a.StatusCode,a.ActivityName from ActivityPossibleSteps aps join Activity a on a.StatusCode=aps.PossibleStatusCode where aps.CurrentStatusCode=@StatusCode
--    UNION ALL
--select a.StatusCode,a.ActivityName from ActivityPossibleSteps aps join Activity a on a.StatusCode=aps.PossibleStatusCode  INNER JOIN cte
--            ON cte.StatusCode = aps.CurrentStatusCode
--  )
 
--SELECT CAST((Select StatusCode,ActivityName from(SELECT StatusCode,ActivityName FROM cte union all Select 0 AS StatusCode,'-' AS ActivityName) as PossibleStep  
--FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)


END