-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_EmailContent] 
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max) 
	DECLARE @ErrMsg NVARCHAR(max) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @EmailEventId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        INSERT INTO	[EmailContent]
        (
        	[SupplierId],
        	[CompanyId],
        	[EmailEventId],
        	[Subject],
        	[EmailHeader],
        	[EmailBody],
        	[EmailFooter],
        	[CCEmailAddress],
        	[UserProfileId],
			[OtherEmailAdresses],
        	[IsActive],
        	[CreatedBy],
			[CreatedDate]
        )

        SELECT
        	tmp.[SupplierId],
        	tmp.[CompanyId],
        	tmp.[EmailEventId],
        	tmp.[Subject],
        	tmp.[EmailHeader],
        	tmp.[EmailBody],
        	tmp.[EmailFooter],
        	tmp.[CCEmailAddress],
        	tmp.[UserProfileId],
			tmp.[OtherEmailAdresses],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
			GETDATE()
            FROM OPENXML(@intpointer,'Json/EmailContentList',2)
        WITH
        (
            [SupplierId] bigint,
            [CompanyId] bigint,
            [EmailEventId] bigint,
            [Subject] nvarchar(max),
            [EmailHeader] nvarchar(max),
            [EmailBody] nvarchar(max),
            [EmailFooter] nvarchar(max),
            [CCEmailAddress] nvarchar(max),
            [UserProfileId] nvarchar(max),
			[OtherEmailAdresses] NVARCHAR(max),
            [IsActive] bit,
            [CreatedBy] bigint,
			[CreatedDate] datetime
        )tmp
        
        DECLARE @EmailContent bigint
	    SET @EmailContent = @@IDENTITY
        SELECT @EmailContent as EmailContent FOR XML RAW('Json'),ELEMENTS
		SET @EmailEventId=(SELECT EmailEventId FROM dbo.EmailContent WHERE EmailContentId=@EmailContent)


		INSERT INTO [dbo].[EmailRecepient]
           ([EmailEventId]
           ,[EmailContentId]
           ,[EmailAddress]
           ,[ToCC]
		   ,[RoleId]
		   ,[UserName]
		   ,[IsActive])
     SELECT
        	@EmailEventId,
        	@EmailContent,
        	tmp.[Email],
        	tmp.[EmailType],
			tmp.[RoleId],
			tmp.[UserName],
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/EmailContentList/EmailRecepientList',2)
			WITH
        (
            [EmailEventId] bigint,
            [EmailContentId] bigint,
            [Email] nvarchar(500),
            [EmailType] nvarchar(10),
           [RoleId] bigint,
		   [UserName] NVARCHAR(250),
		   [IsActive] BIT
        )tmp

		 DECLARE @EmailRecepient bigint
	    SET @EmailRecepient = @@IDENTITY
         SELECT @EmailRecepient as EmailRecepient FOR XML RAW('Json'),ELEMENTS
			

    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
