-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.UserSecurityQuestion table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_UserProfileAndLogin]
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


			create table #Temp
			(
			RoleMasterId bigint,
			[Name] nvarchar(50),
			[EmailId] nvarchar(250),

			[ContactNumber] nvarchar(50),
            UserName nvarchar(100),
			PasswordSalt int,
			HashedPassword nvarchar(100),
			ChangePasswordonFirstLoginRequired bit,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)
			)

        Insert into #Temp  (
		RoleMasterId,
		   [Name],
      [EmailId],
      [ContactNumber],
	  UserName
	  ,PasswordSalt
	  ,HashedPassword
	  ,ChangePasswordonFirstLoginRequired
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
	  )
	   SELECT
        	tmp.RoleMasterId,
        	 tmp.[Name],
			tmp.[EmailId],
			tmp.[ContactNumber],
			tmp.UserName,
			tmp.PasswordSalt,
			tmp.HashedPassword,
			tmp.ChangePasswordonFirstLoginRequired,
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress]
            FROM OPENXML(@intpointer,'Profile',2)
			
        WITH
        (
           RoleMasterId bigint,
            [Name] nvarchar(50),
			[EmailId] nvarchar(250),

			[ContactNumber] nvarchar(50),
			UserName nvarchar(100),
			PasswordSalt int,
			HashedPassword nvarchar(100),
			ChangePasswordonFirstLoginRequired bit,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)
        )tmp
       

        INSERT INTO	[Profile]
        (

         [Name],
      [EmailId],
      [ContactNumber]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
        )

        SELECT

        	   tmp.[Name],
      tmp.[EmailId],
      tmp.[ContactNumber],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress]
            FROM OPENXML(@intpointer,'Profile',2)
        WITH
        (
           RoleMasterId bigint,
            [Name] nvarchar(50),
			[EmailId] nvarchar(250),

			[ContactNumber] nvarchar(50),
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @UserProfile bigint
	    SET @UserProfile = @@IDENTITY
        
		Insert into [Login] (RoleMasterId,[ProfileId],[UserName],[PasswordSalt],[HashedPassword],[LoginAttempts],ChangePasswordonFirstLoginRequired,[IsActive] ,[CreatedDate] ,[CreatedBy],[CreatedFromIPAddress]) 
		Select RoleMasterId, (Select @UserProfile),UserName,PasswordSalt,HashedPassword,0,ChangePasswordonFirstLoginRequired, [IsActive] ,[CreatedDate] ,[CreatedBy],[CreatedFromIPAddress] From #Temp

		  DECLARE @Login bigint
	    SET @Login = @@IDENTITY
        --Add child table insert procedure when required.
    
    SELECT @Login
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
