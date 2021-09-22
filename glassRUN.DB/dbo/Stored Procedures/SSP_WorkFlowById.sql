CREATE PROCEDURE [dbo].[SSP_WorkFlowById] --'<Json><ServicesAction>GetWorkFlowById</ServicesAction><WorkFlowId>1</WorkFlowId></Json>'

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @WorkFlowId BIGINT



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @WorkFlowId = tmp.[WorkFlowId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[WorkFlowId] bigint
			)tmp;
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 
					[WorkFlowId] ,
					[ProcessType],
					(SELECT [dbo].[fn_LookupValueById] ([ProcessType])) as [ProcessTypeValue],
					[WorkFlowCode] ,
					[WorkFlowName] ,
					[WorkFlowRule] ,
					[CompanyId] ,
					CONVERT(varchar(11),FromDate,103) as FromDate,
					CONVERT(varchar(11),ToDate,103) as ToDate	,
					STUFF((SELECT distinct ', ' + Convert(nvarchar(5),wr.RulesId)
         from WorkflowRules wr
         where [WorkFlow].[WorkFlowCode] = wr.[WorkFlowCode]
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,2,'') WorkflowRuleId,
					[IsActive] 
	FROM [dbo].[WorkFlow]
	 WHERE [WorkFlowId]=@WorkFlowId AND IsActive=1
	FOR XML path('WorkFlowList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
