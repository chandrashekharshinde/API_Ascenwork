-- =============================================
-- Author:		Vinod
-- Create date: 28/12/2015
-- Description:	SSP_RoleMaster_SelectByPrimaryKey
-- =============================================
CREATE PROCEDURE [dbo].[SSP_PasswordRecoveryFlowManagment_SelectAll] 
AS
BEGIN

SELECT CAST((SELECT PasswordRecoveryFlowManagmentId ,
                    IsOtpRequired ,
					[IsSecurityQuestionMandatory],
			[RecoveryThroughPrimaryEmail],
[RecoveryThroughAlternateEmail],
[RecoveryThroughRegisteredMobile],
[RecoveryThroughSecurityQuestion],
[CanAdminResetPassword],
                    IsActive ,
                    CreatedDate ,
                    CreatedBy ,
                    CreatedFromIPAddress ,
                    UpdatedDate ,
                    UpdatedBy ,
                    UpdatedFromIPAddress FROM dbo.PasswordRecoveryFlowManagment WHERE IsActive = 1
	    FOR XML RAW('PasswordRecoveryFlowManagmentList'),ELEMENTS,ROOT('PasswordRecoveryFlowManagment')) AS XML)

		END
