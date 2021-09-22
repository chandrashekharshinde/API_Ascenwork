-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailConfiguration table
-----------------------------------------------------------------
CREATE PROCEDURE [dbo].[ISP_EmailConfiguration]
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

        INSERT INTO	[EmailConfiguration]
        (
        	[SupplierId],
        	[SmtpHost],
        	[FromEmail],
        	[UserName],
        	[Password],
        	[EmailBodyType],
        	[PortNumber],
        	[EnableSSL],
        	[EmailSignature],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
        	tmp.[SupplierId],
        	tmp.[SmtpHost],
        	tmp.[FromEmail],
        	tmp.[UserName],
        	tmp.[Password],
        	tmp.[EmailBodyType],
        	tmp.[PortNumber],
        	tmp.[EnableSSL],
        	tmp.[EmailSignature],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
        	
            FROM OPENXML(@intpointer,'Json/EmailConfigurationList',2)
        WITH
        (
            [SupplierId] bigint,
            [SmtpHost] nvarchar(150),
            [FromEmail] nvarchar(150),
            [UserName] nvarchar(500),
            [Password] nvarchar(150),
            [EmailBodyType] nvarchar(150),
            [PortNumber] int,
            [EnableSSL] bit,
            [EmailSignature] nvarchar(4000),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        
        )tmp
        
        DECLARE @EmailConfiguration bigint
	    SET @EmailConfiguration = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    
	SELECT @EmailConfiguration as EmailConfiguration FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
