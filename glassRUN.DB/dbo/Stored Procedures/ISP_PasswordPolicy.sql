-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.PasswordPolicy table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_PasswordPolicy]
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

        INSERT INTO	[PasswordPolicy]
        (
        	[PasswordPolicyName],
        	[IsUpperCaseAllowed],
        	[IsLowerCaseAllowed],
        	[IsNumberAllowed],
        	[IsSpecialCharacterAllowed],
        	[SpecialCharactersToBeExcluded],
        	[MinimumUppercaseCharactersRequired],
        	[MinimumLowercaseCharactersRequired],
        	[MinimumSpecialCharactersRequired],
        	[MinimumNumericsRequired],
        	[PasswordExpiryPeriod],
        	[NewPasswordShouldNotMatchNoOfLastPassword],
        	[MinimumPasswordLength],
        	[MaximumPasswordLength],
        	[CanPasswordBeSameAsUserName],
        	[NumberOfSecurityQuestionsForRegistration],
        	[NumberOfSecurityQuestionsForRecovery],
        	[OneTimePasswordExpireTime],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress],
        	[UpdatedDate],
        	[UpdatedBy],
        	[UpdatedFromIPAddress]
        )

        SELECT
        	tmp.[PasswordPolicyName],
        	tmp.[IsUpperCaseAllowed],
        	tmp.[IsLowerCaseAllowed],
        	tmp.[IsNumberAllowed],
        	tmp.[IsSpecialCharacterAllowed],
        	tmp.[SpecialCharactersToBeExcluded],
        	tmp.[MinimumUppercaseCharactersRequired],
        	tmp.[MinimumLowercaseCharactersRequired],
        	tmp.[MinimumSpecialCharactersRequired],
        	tmp.[MinimumNumericsRequired],
        	tmp.[PasswordExpiryPeriod],
        	tmp.[NewPasswordShouldNotMatchNoOfLastPassword],
        	tmp.[MinimumPasswordLength],
        	tmp.[MaximumPasswordLength],
        	tmp.[CanPasswordBeSameAsUserName],
        	tmp.[NumberOfSecurityQuestionsForRegistration],
        	tmp.[NumberOfSecurityQuestionsForRecovery],
        	tmp.[OneTimePasswordExpireTime],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress],
        	tmp.[UpdatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedFromIPAddress]
            FROM OPENXML(@intpointer,'PasswordPolicy',2)
        WITH
        (
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
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20),
            [UpdatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @PasswordPolicy bigint
	    SET @PasswordPolicy = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @PasswordPolicy
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
