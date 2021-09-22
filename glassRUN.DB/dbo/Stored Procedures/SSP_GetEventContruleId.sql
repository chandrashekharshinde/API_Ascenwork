
CREATE PROCEDURE [dbo].[SSP_GetEventContruleId] 
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @EventContentId bigint = 0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventContentId=tmp.[EventContentId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EventContentId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT distinct 'true' AS [@json:Array], 
 
STUFF( (SELECT ', ' + convert(varchar(10),op.RuleId ) 
FROM eventcontentrule op  where op.EventContentid = ecr.EventContentId and op.isactive=1  FOR XML PATH (''))  , 1, 1, '') RuleIdes
from eventcontentrule ecr where ecr.IsActive = 1 and ecr.EventContentId=@EventContentId
FOR XML path('EventContentRuleIdList'),ELEMENTS,ROOT('Json')) AS XML)
END;