CREATE PROCEDURE [dbo].[SSP_LoadAllPagesList] --'<Json><ServicesAction>LoadAllPagesList</ServicesAction><RoleId>0</RoleId><ObjectId>0</ObjectId><ConfigurationAvailable>1</ConfigurationAvailable></Json>'
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT
Declare @RoleId Nvarchar(100)
Declare @ObjectId Nvarchar(100)
Declare @Configuration Bigint=0

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@RoleId = tmp.[RoleId],
		@ObjectId = tmp.[ObjectId],
		@Configuration=ISNULL(tmp.[ConfigurationAvailable],0)

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [RoleId] bigint,
	[ObjectId] bigint,
	ConfigurationAvailable bigint
   )tmp;
   Print @Configuration;
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
  and (ISNULL(ConfigurationAvailable,0)= @Configuration or @Configuration=0)
   order by PageName
  
  FOR XML PATH('PagesList'),ELEMENTS,ROOT('Json')) AS XML)
END
