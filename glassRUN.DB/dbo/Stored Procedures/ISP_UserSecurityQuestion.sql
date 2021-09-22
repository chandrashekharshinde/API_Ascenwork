-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.UserSecurityQuestion table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_UserSecurityQuestion]
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

        INSERT INTO	[UserSecurityQuestion]
        (
        	[SecurityQuestionId],
        	[ProfileId],
        	[Answer],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress],
        	[UpdatedDate],
        	[UpdatedBy],
        	[UpdatedFromIPAddress]
        )

        SELECT
        	tmp.[SecurityQuestionId],
        	tmp.[ProfileId],
        	tmp.[Answer],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress],
        	tmp.[UpdatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedFromIPAddress]
            FROM OPENXML(@intpointer,'UserSecurityQuestion',2)
        WITH
        (
            [SecurityQuestionId] bigint,
            [ProfileId] bigint,
            [Answer] nvarchar(150),
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20),
            [UpdatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @UserSecurityQuestion bigint
	    SET @UserSecurityQuestion = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @UserSecurityQuestion
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
