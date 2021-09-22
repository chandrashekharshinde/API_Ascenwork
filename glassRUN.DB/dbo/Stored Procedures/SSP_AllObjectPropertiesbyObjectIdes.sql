
CREATE PROCEDURE [dbo].[SSP_AllObjectPropertiesbyObjectIdes] --'<Json><ServicesAction>LoadObjectDocumentByObjectId</ServicesAction><ObjectId>9</ObjectId><ObjectType>Profile</ObjectType></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @ObjectId nvarchar(100)=0;
declare @ObjectType nvarchar(50)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ObjectId = tmp.[ObjectId],
	  @ObjectType = tmp.[ObjectType]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ObjectId] nvarchar(100),
				[ObjectType] nvarchar(50)
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

Select Cast((SELECT 'true' AS [@json:Array], [ObjectPropertiesId] AS ObjectPropertyId
      ,[ObjectPropertiesId] as Id
	  ,[PropertyName] as [Name]
      ,[ObjectId]
      ,[PropertyName]
      ,[ResourceKey]	 
      ,[OnScreenDisplay]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
FROM [ObjectProperties] WHERE IsActive = 1 and ObjectId in (select * from dbo.[fnSplitValuesForNvarchar](@ObjectId))
					
	FOR XML path('ObjectPropertiesList'),ELEMENTS,ROOT('Json')) AS XML)
END