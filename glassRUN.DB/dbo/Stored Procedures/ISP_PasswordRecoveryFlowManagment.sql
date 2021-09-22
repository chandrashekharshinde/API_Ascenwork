-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.PasswordRecoveryFlowManagment table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_PasswordRecoveryFlowManagment]
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

        INSERT INTO	[PasswordRecoveryFlowManagment]
        (
        	IsOtpRequired,
        	
			[IsSecurityQuestionMandatory],
			[RecoveryThroughPrimaryEmail],
[RecoveryThroughAlternateEmail],
[RecoveryThroughRegisteredMobile],
[RecoveryThroughSecurityQuestion],
[CanAdminResetPassword],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress],
        	[UpdatedDate],
        	[UpdatedBy],
        	[UpdatedFromIPAddress]
        )

        SELECT
        	tmp.IsOtpRequired,
			tmp.[IsSecurityQuestionMandatory],
			tmp.[RecoveryThroughPrimaryEmail],
tmp.[RecoveryThroughAlternateEmail],
tmp.[RecoveryThroughRegisteredMobile],
tmp.[RecoveryThroughSecurityQuestion],
tmp.[CanAdminResetPassword],
        	tmp.[IsActive],
        	Getdate(),
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress],
        	tmp.[UpdatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedFromIPAddress]
            FROM OPENXML(@intpointer,'PasswordRecoveryFlowManagment',2)
        WITH
        (
            IsOtpRequired bit,
			[IsSecurityQuestionMandatory] bit,
			[RecoveryThroughPrimaryEmail] bit,
[RecoveryThroughAlternateEmail] bit,
[RecoveryThroughRegisteredMobile] bit,
[RecoveryThroughSecurityQuestion] bit,
[CanAdminResetPassword] bit,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20),
            [UpdatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @PasswordRecoveryFlowManagment bigint
	    SET @PasswordRecoveryFlowManagment = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @PasswordRecoveryFlowManagment
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
