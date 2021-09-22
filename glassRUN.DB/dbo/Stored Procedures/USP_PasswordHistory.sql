-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.PasswordHistory table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_PasswordHistory]

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
            DECLARE @PasswordHistoryId bigint
            UPDATE dbo.PasswordHistory SET
        	[ProfileId]=tmp.ProfileId ,
			[LoginId]=tmp.LoginId ,
        	[HashedPassword]=tmp.HashedPassword ,
        	[PasswordSalt]=tmp.PasswordSalt ,
        	[PasswordChangedDate]=tmp.PasswordChangedDate ,
        	[PasswordResetBy]=tmp.PasswordResetBy ,
        	[EmailAddress]=tmp.EmailAddress ,
        	[PhoneNo]=tmp.PhoneNo ,
        	[OneTimePassword]=tmp.OneTimePassword ,
        	[IsActive]=tmp.IsActive ,
        	
        	[UpdatedDate]=getdate() ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress,
			ResetPasswordCode = tmp.ResetPasswordCode
            FROM OPENXML(@intpointer,'PasswordHistory',2)
			WITH
			(
            [PasswordHistoryId] bigint,
           
            [ProfileId] bigint,
			[LoginId] bigint,
           
            [HashedPassword] nchar(10),
           
            [PasswordSalt] nvarchar(100),
           
            [PasswordChangedDate] datetime,
           
            [PasswordResetBy] nvarchar(50),
           
            [EmailAddress] nvarchar(150),
           
            [PhoneNo] nvarchar(50),
           
            [OneTimePassword] nvarchar(50),
           
            [IsActive] bit,
           
            
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20),
			ResetPasswordCode nvarchar(200)
           
            )tmp WHERE PasswordHistory.[PasswordHistoryId]=tmp.[PasswordHistoryId]
            SELECT  @PasswordHistoryId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_PasswordHistory'
