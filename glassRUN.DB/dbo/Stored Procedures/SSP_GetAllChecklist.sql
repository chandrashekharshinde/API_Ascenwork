CREATE PROCEDURE [dbo].[SSP_GetAllChecklist]--'SupplierLOBId = 2 AND  Version <> '''''
@Output nvarchar(2000) output
AS


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
 cl.[ChecklistId]
,cl.[ChecklistDescription]
,cl.[StatusCode]
,cl.[ActivityFormMappingId]
,cl.[IsActive]
,(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
	   [ChecklistResponseId]
      ,[ChecklistId]
      ,[ControlType]
      ,[Validation]
      ,[ResponseDataType]
      ,[IsActive]
		from [dbo].[ChecklistResponse] clr 
		where clr.ChecklistId=cl.ChecklistId and clr.[IsActive]=1
		FOR XML path(''ChecklistResponse''),ELEMENTS) AS XML)
		)
	FROM [dbo].[Checklist] cl
	 WHERE cl.IsActive=1
	FOR XML PATH(''Checklist''),ELEMENTS)AS XML))'
	


SET @Output=@sql


PRINT 'Executed SSP_GetAllChecklist'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
