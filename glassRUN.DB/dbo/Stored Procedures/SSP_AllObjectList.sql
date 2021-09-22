
CREATE PROCEDURE [dbo].[SSP_AllObjectList] (
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
      ,[ObjectName]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
	  ,[GridConfiguration]
	  ,isnull([DisplayName],'-') as [DisplayName]
      ,[ModifiedBy]
      ,[ModifiedDate]
  FROM [Object] WHERE IsActive = 1 and GridConfiguration = 1
  and [ObjectId] in (select ObjectId from PageObjectMapping where (PageId = @PageId or @PageId=0) and IsGridPage = 1 and IsActive = 1)
  FOR XML path('ObjectList'),ELEMENTS,ROOT('Object')) AS XML)
END
