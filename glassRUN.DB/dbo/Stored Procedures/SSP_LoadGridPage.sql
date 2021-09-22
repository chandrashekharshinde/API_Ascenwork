CREATE PROCEDURE [dbo].[SSP_LoadGridPage]
(
@xmlDoc XML
)
AS

BEGIN

DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
	SELECT CAST((SELECT 'true' AS [@json:Array], 
					pc.PageControlId,p.PageName +' - '+ ControlName as PageControlName
from PageControl pc join Pages p on p.PageId = pc.PageId --join PageObjectMapping pom on pom.PageId = p.PageId where p.ControllerName LIKE '%Grid%'
FOR XML path('GridPageList'),ELEMENTS,ROOT('Json')) AS XML)
END
