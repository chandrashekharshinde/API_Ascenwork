
CREATE PROCEDURE [dbo].[USP_SoftDeleteWorkFlow]
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @WorkFlowId BIGINT
declare @WorkFlowCode nvarchar(100)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @WorkFlowId = tmp.[WorkFlowId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[WorkFlowId] bigint
			)tmp;
	select @WorkFlowCode = WorkFlowCode from Workflow where  WorkFlowId=@WorkFlowId

	Update [dbo].[WorkFlow] SET IsActive=0 WHERE WorkFlowId=@WorkFlowId
	Update Rules set IsActive = 0 where RuleId IN (select RulesId from [dbo].[WorkflowRules] WHERE WorkFlowCode=@WorkFlowCode)
	Update [dbo].[WorkflowRules] SET IsActive=0 WHERE WorkFlowCode=@WorkFlowCode
	Update [dbo].[WorkFlowStep] SET IsActive=0 WHERE WorkFlowCode=@WorkFlowCode
	Update [dbo].[WorkFlowStepRules] SET IsActive=0 WHERE WorkFlowCode=@WorkFlowCode
	Update Rules set IsActive = 0 where RuleId IN (select WorkFlowRulesId from [dbo].[WorkFlowStepRules] WHERE WorkFlowCode=@WorkFlowCode)



	Select @@Rowcount
	
END
