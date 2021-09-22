Create PROCEDURE [dbo].[SSP_LoadAllPages] 
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT
Declare @CompanyId Nvarchar(100)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@CompanyId = tmp.[CompanyId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
      [CompanyId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array]  ,[PageId]
      ,[ModuleId]
      ,[PageName]
      ,[ParentPageId]
      ,[ControllerName]
      ,[ActionName]
      ,[IsReport]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
      ,[IPAddress]
  FROM Pages WHERE IsActive = 1 
  
  FOR XML PATH('PagesList'),ELEMENTS,ROOT('Json')) AS XML)
END
