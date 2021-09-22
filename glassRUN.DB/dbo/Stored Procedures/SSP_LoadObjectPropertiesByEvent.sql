CREATE PROCEDURE [dbo].[SSP_LoadObjectPropertiesByEvent] --'<Json><PageId>1</PageId></Json>'
(
@xmlDoc XML 
)
AS

BEGIN
DECLARE @intPointer INT;
declare @EmailEventId nvarchar(100)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EmailEventId = tmp.[EmailEventId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EmailEventId] nvarchar(100)
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	SELECT CAST((SELECT  'true' AS [@json:Array] ,
	o.ObjectId,
	ObjectName,
	(SELECT CAST((SELECT 'true' AS [@json:Array] , 
	[ObjectPropertiesId],
	[ObjectPropertiesId] as LookupID,
    [ObjectId]
    ,[PropertyName]
	,[PropertyName] as Name
    ,[ResourceKey]
    ,[OnScreenDisplay] from ObjectProperties op where ObjectId = o.ObjectId
	FOR XML path('ObjectPropertiesList'),ELEMENTS) AS xml))
	FROM [Object] o join EventObjectMaaping eom on o.ObjectId = eom.ObjectId  
	  WHERE o.IsActive = 1 and eom.EmailEventId = @EmailEventId
	FOR XML path('ObjecttList'),ELEMENTS,ROOT('Json')) AS XML)
END
