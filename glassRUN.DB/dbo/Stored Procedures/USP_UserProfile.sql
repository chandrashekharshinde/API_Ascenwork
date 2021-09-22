CREATE PROC [dbo].[USP_UserProfile] 
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
			DECLARE @UserProfileId BIGINT


			UPDATE dbo.Profile SET
        	--[RoleMasterId]=tmp.RoleMasterId ,

        	[Name]=tmp.Name ,
        	[EmailId]=tmp.EmailId ,

			[ContactNumber]  =tmp.[ContactNumber],
        	[IsActive]=tmp.IsActive ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy 
        	--[IPAddress]=tmp.IPAddress
            FROM OPENXML(@intpointer,'Profile',2)
			WITH
			(
            [ProfileId] bigint,
           
            --[RoleMasterId] bigint,
           
            [Name] nvarchar(50),
           
            --[MiddleName] nvarchar(50),
           
            --[LastName] nvarchar(50),
           
            [EmailId] nvarchar(100),
           --[AlternetEmail] nvarchar(250),
			[ContactNumber] nvarchar(50),
            [IsActive] bit,
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [IPAddress] nvarchar(20)
           
            )tmp WHERE Profile.[ProfileId]=tmp.[ProfileId]
           -- SELECT  @UserProfileId


			SELECT * INTO #TMPTABLE 
			FROM OPENXML(@intpointer,'Profile',2)
			WITH(
				
				[ProfileId] bigint,
            [RoleMasterId] bigint,
			[Name] nvarchar(50),
			--[MiddleName] nvarchar(50),
			--[LastName] nvarchar(50),
			[EmailId] nvarchar(250),
			--[AlternetEmail] nvarchar(250),
			[ContactNumber] nvarchar(50),
			UserName nvarchar(100),
			ChangePasswordonFirstLoginRequired bit,
            [IsActive] bit,
            UpdatedDate datetime,
            UpdatedBy bigint,
            [IPAddress] nvarchar(20)
				)tmp
			

				UPDATE dbo.[Login] SET
				[RoleMasterId]=tmp.[RoleMasterId],
									 UserName=tmp.UserName,
									 ChangePasswordonFirstLoginRequired=tmp.ChangePasswordonFirstLoginRequired,
									
									 UpdatedBy=tmp.UpdatedBy ,
									 UpdatedDate=GETDATE()
									 --UpdatedFromIPAddress= tmp.[UpdatedFromIPAddress]
									 --[State]=tmp.[State] 
									 FROM #TMPTABLE tmp WHERE [dbo].Login.ProfileId=tmp.ProfileId 
									
					SET @UserProfileId=(select  [ProfileId] from #TMPTABLE)
	 

        Select @@ROWCOUNT
			DROP TABLE #TMPTABLE
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
