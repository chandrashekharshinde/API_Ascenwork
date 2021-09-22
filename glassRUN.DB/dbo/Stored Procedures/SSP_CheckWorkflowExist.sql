CREATE PROCEDURE [dbo].[SSP_CheckWorkflowExist] --'<Json><WorkFlowCode>MBCP</WorkFlowCode></Json>'
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @WorkFlowCode nvarchar(50)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @WorkFlowCode = tmp.[WorkFlowCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[WorkFlowCode] nvarchar(100)
			)tmp;
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT WorkFlowId,
					WorkFlowCode
	FROM [dbo].[WorkFlow]
	 WHERE  IsActive=1 and WorkFlowCode = @WorkFlowCode
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)
	
END
