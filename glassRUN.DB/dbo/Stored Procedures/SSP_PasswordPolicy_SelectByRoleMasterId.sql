

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SSP_PasswordPolicy_SelectByRoleMasterId]-- 2
	-- Add the parameters for the stored procedure here
	@RoleMasterId bigint
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
 From PasswordPolicy p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId
  inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId Where rpm.RoleMasterId=@RoleMasterId and p.IsActive=1

	    FOR XML RAW('PasswordPolicyList'),ELEMENTS,ROOT('PasswordPolicy')) AS XML)

		END