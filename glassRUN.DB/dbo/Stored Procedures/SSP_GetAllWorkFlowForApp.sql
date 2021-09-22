CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowForApp]--'SupplierLOBId = 2 AND  Version <> '''''
@Output nvarchar(2000) output
AS


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
[WorkFlowId] ,
[WorkFlowId] As Id ,
[WorkFlowCode] ,
[WorkFlowName] ,
[WorkFlowName] As Name,
[WorkFlowRule] ,
[CompanyId] ,
[FromDate],
[ToDate],
[IsActive] 
,(SELECT CAST((SELECT ''true'' AS [@json:Array] , wr.RuleText,ISnull(wfr.IsForNextStep,0) as IsForNextStep
		from WorkFlowRules wfr join Rules wr 
		on wfr.RulesId=wr.RuleId
		where wfr.[WorkFlowCode]=[WorkFlow].WorkFlowCode and wr.IsActive=1 and wfr.IsActive=1  
			FOR XML path(''RulesList''),ELEMENTS,ROOT(''Rules'')) AS XML)
		)
	FROM [dbo].[WorkFlow]
	 WHERE IsActive=1
	FOR XML PATH(''WorkflowList''),ELEMENTS)AS XML))'
	


SET @Output=@sql


PRINT 'Executed SSP_GetAllWorkFlowForApp'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
