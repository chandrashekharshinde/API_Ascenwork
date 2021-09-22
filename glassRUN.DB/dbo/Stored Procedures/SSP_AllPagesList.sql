
CREATE PROCEDURE [dbo].[SSP_AllPagesList] 
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT
Declare @RoleId Nvarchar(100)
Declare @ObjectId Nvarchar(100)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@RoleId = tmp.[RoleId],
		@ObjectId = tmp.[ObjectId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [RoleId] bigint,
	[ObjectId] bigint
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
  --and PageId in (Select PageId from RoleWisePageMapping where (RoleMasterId = @RoleId or @RoleId=0) and IsActive = 1)
  and PageId in (select PageId from PageObjectMapping where (ObjectId = @ObjectId or @ObjectId=0) and IsGridPage = 1 and IsActive = 1)
  FOR XML PATH('PagesList'),ELEMENTS,ROOT('Json')) AS XML)
END