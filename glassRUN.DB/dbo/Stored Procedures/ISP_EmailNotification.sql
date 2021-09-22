-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailNotification table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_EmailNotification] --N'<EmailNotification xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>422</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>422</CreatedBy><CreatedDate>2019-02-04T13:11:29.1875764+05:30</CreatedDate><EmailNotificationId>0</EmailNotificationId><EventType>PasswordRecover</EventType><SenderEmailAddress>Vijayw@disrptiv.com</SenderEmailAddress><IsSent>false</IsSent></EmailNotification>'
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

        INSERT INTO	[EventNotification]
        (
        	[EventMasterId],
        	[EventCode],
        	[ObjectId],
        	[ObjectType],			
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy]
        )

        SELECT
			(Select EventMasterId from EventMaster where EventCode=tmp.[EventType]),        	
        	tmp.[EventType],
			(Select LoginId from Login where LoginId=tmp.[ObjectId]),        	
        	'Login',		
        	tmp.[IsActive],
        	GETDATE(),
        	tmp.[CreatedBy]
            FROM OPENXML(@intpointer,'EmailNotification',2)
        WITH
        (
            [EventMasterId] bigint,
			[EventType] nvarchar(100),
            [ObjectType] nvarchar(50),
            [ObjectId] nvarchar(50),            
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint
        )tmp
        
        DECLARE @EventNotification bigint
	    SET @EventNotification = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @EventNotification
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END