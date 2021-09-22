
CREATE PROCEDURE [dbo].[SSP_AllRuleTypeListByPageId] 
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT
Declare @pageId Nvarchar(100)
Declare @ObjectId Nvarchar(100)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@pageId = tmp.[PageId],
		@ObjectId = tmp.[ObjectId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint,
	[ObjectId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array]  ,[PageRuleId]
      ,[RuleType]
      ,[PageId]
  FROM PageRule WHERE [PageId]=@pageId
  --and PageId in (Select PageId from RoleWisePageMapping where (RoleMasterId = @RoleId or @RoleId=0) and IsActive = 1)
 
  FOR XML PATH('PageRuleList'),ELEMENTS,ROOT('Json')) AS XML)
END

