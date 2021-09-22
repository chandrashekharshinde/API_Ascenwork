-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SSP_SecurityQuestion_SelectByRoleMasterId] 
	-- Add the parameters for the stored procedure here
	@RoleMasterId NVARCHAR(50)
AS
BEGIN
Declare @NoOfQuestionForRegiter int

Set @NoOfQuestionForRegiter = (Select NumberOfSecurityQuestionsForRegistration from PasswordPolicy Where PasswordPolicyId = (Select PasswordPolicyId From  RolePasswordPolicyMapping Where RoleMasterId=@RoleMasterId))




SELECT CAST((SELECT TOP (SELECT @NoOfQuestionForRegiter) sq.SecurityQuestionId AS 'SecurityQuestionId',
                    sq.Question AS 'Question',
                    rsq.RoleMasterId AS 'RoleMasterId'
					FROM dbo.SecurityQuestion sq INNER JOIN  [dbo].[RoleSecurityQuestionMapping] rsq
					ON rsq.SecurityQuestionId = sq.SecurityQuestionId  WHERE rsq.RoleMasterId=@RoleMasterId AND  sq.IsActive = 1 AND rsq.IsActive=1 and rsq.RoleMasterId=@RoleMasterId --AND PasswordSalt=@PasswordSalt AND HashedPassword=@HashedPassword
	    FOR XML RAW('SecurityQuestionList'),ELEMENTS,ROOT('SecurityQuestion')) AS XML)

		END
