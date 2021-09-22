-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_PasswordPolicy_SelectByPrimaryKey]-- 2
	-- Add the parameters for the stored procedure here
	@PasswordPolicyId bigint
AS
BEGIN

SELECT CAST((SELECT  
		p.[PasswordPolicyId],
		r.RoleMasterId,
		RoleName
      ,[PasswordPolicyName]
      ,[IsUpperCaseAllowed]
      ,[IsLowerCaseAllowed]
      ,[IsNumberAllowed]
      ,[IsSpecialCharacterAllowed]
      ,[SpecialCharactersToBeExcluded]
      ,[MinimumUppercaseCharactersRequired]
      ,[MinimumLowercaseCharactersRequired]
      ,[MinimumSpecialCharactersRequired]
      ,[MinimumNumericsRequired]
      ,[PasswordExpiryPeriod]
      ,[NewPasswordShouldNotMatchNoOfLastPassword]
      ,[MinimumPasswordLength]
      ,[MaximumPasswordLength]
      ,[CanPasswordBeSameAsUserName]
      ,[NumberOfSecurityQuestionsForRegistration]
      ,[NumberOfSecurityQuestionsForRecovery]
      ,[OneTimePasswordExpireTime]
      ,p.[IsActive]
 From PasswordPolicy p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId Where p.PasswordPolicyId=@PasswordPolicyId
	    FOR XML RAW('PasswordPolicyList'),ELEMENTS,ROOT('PasswordPolicy')) AS XML)

		END
