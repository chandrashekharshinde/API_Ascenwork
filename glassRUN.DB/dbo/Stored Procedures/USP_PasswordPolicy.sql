-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.PasswordPolicy table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_PasswordPolicy]

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @PasswordPolicyId bigint
            UPDATE dbo.PasswordPolicy SET
        	[PasswordPolicyName]=tmp.PasswordPolicyName ,
        	[IsUpperCaseAllowed]=tmp.IsUpperCaseAllowed ,
        	[IsLowerCaseAllowed]=tmp.IsLowerCaseAllowed ,
        	[IsNumberAllowed]=tmp.IsNumberAllowed ,
        	[IsSpecialCharacterAllowed]=tmp.IsSpecialCharacterAllowed ,
        	[SpecialCharactersToBeExcluded]=tmp.SpecialCharactersToBeExcluded ,
        	[MinimumUppercaseCharactersRequired]=tmp.MinimumUppercaseCharactersRequired ,
        	[MinimumLowercaseCharactersRequired]=tmp.MinimumLowercaseCharactersRequired ,
        	[MinimumSpecialCharactersRequired]=tmp.MinimumSpecialCharactersRequired ,
        	[MinimumNumericsRequired]=tmp.MinimumNumericsRequired ,
        	[PasswordExpiryPeriod]=tmp.PasswordExpiryPeriod ,
        	[NewPasswordShouldNotMatchNoOfLastPassword]=tmp.NewPasswordShouldNotMatchNoOfLastPassword ,
        	[MinimumPasswordLength]=tmp.MinimumPasswordLength ,
        	[MaximumPasswordLength]=tmp.MaximumPasswordLength ,
        	[CanPasswordBeSameAsUserName]=tmp.CanPasswordBeSameAsUserName ,
        	[NumberOfSecurityQuestionsForRegistration]=tmp.NumberOfSecurityQuestionsForRegistration ,
        	[NumberOfSecurityQuestionsForRecovery]=tmp.NumberOfSecurityQuestionsForRecovery ,
        	[OneTimePasswordExpireTime]=tmp.OneTimePasswordExpireTime ,
        	[IsActive]=tmp.IsActive ,
 
        	[UpdatedDate]=GETDATE() ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'PasswordPolicy',2)
			WITH
			(
            [PasswordPolicyId] bigint,
           
            [PasswordPolicyName] nvarchar(150),
           
            [IsUpperCaseAllowed] bit,
           
            [IsLowerCaseAllowed] bit,
           
            [IsNumberAllowed] bit,
           
            [IsSpecialCharacterAllowed] bit,
           
            [SpecialCharactersToBeExcluded] nvarchar(50),
           
            [MinimumUppercaseCharactersRequired] int,
           
            [MinimumLowercaseCharactersRequired] int,
           
            [MinimumSpecialCharactersRequired] int,
           
            [MinimumNumericsRequired] int,
           
            [PasswordExpiryPeriod] int,
           
            [NewPasswordShouldNotMatchNoOfLastPassword] bit,
           
            [MinimumPasswordLength] int,
           
            [MaximumPasswordLength] int,
           
            [CanPasswordBeSameAsUserName] bit,
           
            [NumberOfSecurityQuestionsForRegistration] int,
           
            [NumberOfSecurityQuestionsForRecovery] int,
           
            [OneTimePasswordExpireTime] int,
           
            [IsActive] bit,

           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE PasswordPolicy.[PasswordPolicyId]=tmp.[PasswordPolicyId]
            SELECT  @@ROWCOUNT
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_PasswordPolicy'
