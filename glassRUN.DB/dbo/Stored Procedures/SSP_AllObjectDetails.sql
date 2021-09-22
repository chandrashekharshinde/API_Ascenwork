

create PROCEDURE [dbo].[SSP_AllObjectDetails] (
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @PageId Nvarchar(100)

SELECT  
		@PageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array],  [ObjectId]
      ,[ObjectId] as Id
      ,[ObjectName]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
	  ,[GridConfiguration]
	  ,isnull([DisplayName],'-') as [Name]
      ,[ModifiedBy]
      ,[ModifiedDate]
  FROM [Object] WHERE IsActive = 1
  FOR XML path('ObjectList'),ELEMENTS,ROOT('Object')) AS XML)
END