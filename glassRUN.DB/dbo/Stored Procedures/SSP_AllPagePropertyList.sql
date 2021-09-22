Create PROCEDURE [dbo].[SSP_AllPagePropertyList] (
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @PageId Nvarchar(100)
Declare @ControlType nvarchar(100)
Declare @CultureId nvarchar(100)
SELECT  
		@PageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], PagePropertiesId,PageId,PropertyName
  FROM [dbo].PageProperties pc where (PageId = @PageId or @PageId=0) 
  FOR XML path('PagePropertiesList'),ELEMENTS,ROOT('PageProperties')) AS XML)
END
