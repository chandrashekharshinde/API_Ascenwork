CREATE PROCEDURE [dbo].[SSP_GetTemplateForms]--'SupplierLOBId = 2 AND  Version <> '''''
@Output nvarchar(2000) output
AS


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
[TemplateFormId] ,
[TemplateFormId] As Id ,
[TemplateJson] ,
[TemplateJson] as FormConatin,
[TemplateName] as FormName,
[TemplateName] As Name,
[Version] ,
[IsAppTemplate],
[IsActive] 
	FROM [dbo].[TemplateForms]
	 WHERE IsActive=1
	FOR XML PATH(''TemplateFormsList''),ELEMENTS)AS XML))'
	


SET @Output=@sql


PRINT 'Executed SSP_GetTemplateForms'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh