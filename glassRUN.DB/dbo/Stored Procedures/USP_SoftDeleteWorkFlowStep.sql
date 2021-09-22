
Create PROCEDURE [dbo].[USP_SoftDeleteWorkFlowStep]
@WorkFlowStepId BIGINT
AS
BEGIN
	Update [dbo].[WorkFlowStep] SET IsActive=1 WHERE WorkFlowStepId=@WorkFlowStepId
	Select @@Rowcount
	
END
