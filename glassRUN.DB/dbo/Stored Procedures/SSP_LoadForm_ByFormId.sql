
Create PROCEDURE [dbo].[SSP_LoadForm_ByFormId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>77795</OrderId><RoleId>3</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @FormId nvarchar(100)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @FormId = tmp.[FormId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [FormId] bigint
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT 
      'true' AS [@json:Array]  , 
	  [TemplateFormId]
      ,[TemplateBody]
      ,[TemplateJson]
      ,[IsAppTemplate]
      ,[Version]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]

 FROM [dbo].TemplateForms tf
 
  WHERE (TemplateFormId = @FormId OR @FormId = '') 
 FOR XML path('FormList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END