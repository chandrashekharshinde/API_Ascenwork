Create PROCEDURE [dbo].[SSP_LoadObjectPropertiesByObject] --'<Json><PageId>1</PageId></Json>'
(
@xmlDoc XML 
)
AS

BEGIN
DECLARE @intPointer INT;
declare @ObjectName nvarchar(100)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ObjectName = tmp.[ObjectName]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ObjectName] nvarchar(100)
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array] , 
[ObjectPropertiesId]
, [ObjectPropertiesId] as LookupID,
[ObjectId]
      ,[PropertyName]
	  ,[PropertyName] as Name
      ,[ResourceKey]
      ,[OnScreenDisplay] from ObjectProperties op where ObjectId in (select ObjectId from [Object] where ObjectName = @ObjectName)
	FOR XML path('ObjectPropertiesList'),ELEMENTS,ROOT('Json')) AS XML)
END
