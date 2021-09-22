-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.PasswordRecoveryFlowManagment table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_PasswordRecoveryFlowManagment]

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
            DECLARE @PasswordRecoveryFlowManagmentId bigint

            UPDATE dbo.PasswordRecoveryFlowManagment SET
        	[IsOTPRequired]=tmp.IsOtpRequired ,
			[IsSecurityQuestionMandatory]=tmp.[IsSecurityQuestionMandatory] ,
			[RecoveryThroughPrimaryEmail] =tmp.[RecoveryThroughPrimaryEmail] ,
[RecoveryThroughAlternateEmail]=tmp.[RecoveryThroughAlternateEmail] ,
[RecoveryThroughRegisteredMobile]=tmp.[RecoveryThroughRegisteredMobile] ,
[RecoveryThroughSecurityQuestion]=tmp.[RecoveryThroughSecurityQuestion] ,

        	[CanAdminResetPassword]=tmp.CanAdminResetPassword ,
        	[IsActive]=tmp.IsActive ,

        	[UpdatedDate]=getDate(),
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'PasswordRecoveryFlowManagment',2)
			WITH
			(
            [PasswordRecoveryFlowManagmentId] bigint,
           
             IsOtpRequired bit,
			[IsSecurityQuestionMandatory] bit,
			[RecoveryThroughPrimaryEmail] bit,
[RecoveryThroughAlternateEmail] bit,
[RecoveryThroughRegisteredMobile] bit,
[RecoveryThroughSecurityQuestion] bit,
[CanAdminResetPassword] bit,
           
            [IsActive] bit,

           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE PasswordRecoveryFlowManagment.[PasswordRecoveryFlowManagmentId]=tmp.[PasswordRecoveryFlowManagmentId]
            SELECT  @@ROWCOUNT
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_PasswordRecoveryFlowManagment'
