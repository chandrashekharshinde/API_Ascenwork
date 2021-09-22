-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.RoleSecurityQuestionMapping table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_RoleSecurityQuestionMapping]
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

        INSERT INTO	[RoleSecurityQuestionMapping]
        (
        	[RoleMasterId],
        	[SecurityQuestionId],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress],
        	[UpdatedDate],
        	[UpdatedBy],
        	[UpdatedFromIPAddress]
        )

        SELECT
        	tmp.[RoleMasterId],
        	tmp.[SecurityQuestionId],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress],
        	tmp.[UpdatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedFromIPAddress]
            FROM OPENXML(@intpointer,'RoleSecurityQuestionMapping',2)
        WITH
        (
            [RoleMasterId] bigint,
            [SecurityQuestionId] bigint,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20),
            [UpdatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @RoleSecurityQuestionMapping bigint
	    SET @RoleSecurityQuestionMapping = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @RoleSecurityQuestionMapping
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
