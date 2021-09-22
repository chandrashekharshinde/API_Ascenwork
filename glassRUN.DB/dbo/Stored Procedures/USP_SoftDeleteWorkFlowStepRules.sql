
Create PROCEDURE [dbo].[USP_SoftDeleteWorkFlowStepRules]
@WorkFlowStepRulesId BIGINT
AS
BEGIN
	Update [dbo].[WorkFlowStepRules] SET IsActive=1 WHERE WorkFlowStepRulesId=@WorkFlowStepRulesId
	Select @@Rowcount
	
END
