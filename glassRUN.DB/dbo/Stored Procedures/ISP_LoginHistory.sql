-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.LoginHistory table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_LoginHistory]
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

        INSERT INTO	[LoginHistory]
        (
        	[LoginId],
        	[LogoutType],
        	[LoggingInTime],
        	[LoggingOutTime],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress]

        )

        SELECT
        	tmp.[LoginId],
        	tmp.[LogoutType],
        	tmp.[LoggingInTime],
        	tmp.[LoggingOutTime],
        	tmp.[IsActive],
        	GetDate(),
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress]

            FROM OPENXML(@intpointer,'LoginHistory',2)
        WITH
        (
            [LoginId] bigint,
            [LogoutType] nvarchar(100),
            [LoggingInTime] datetime,
            [LoggingOutTime] datetime,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)

        )tmp




		update Login  
		set AccessKey =   	tmp.[Token]
        

            FROM OPENXML(@intpointer,'LoginHistory',2)
        WITH
        (
           [LoginId] bigint,
            [Token] nvarchar(250)

        )tmp   join [login] l on l.LoginId = tmp.[LoginId]

        
        DECLARE @LoginHistory bigint
	    SET @LoginHistory = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @LoginHistory
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
