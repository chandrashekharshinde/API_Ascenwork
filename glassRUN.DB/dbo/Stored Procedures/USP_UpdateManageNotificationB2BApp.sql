

 
CREATE PROCEDURE [dbo].[USP_UpdateManageNotificationB2BApp] -- ''

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	DECLARE @modifiedBy bigINT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
	
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
        DECLARE @UserId bigint;

		SELECT * INTO #tmpNotificationList
		FROM OPENXML(@intpointer,'Json/NotificationList',2)
			WITH
        (
		[CompanyId] BIGINT,
		[EventUserType] BIGINT,
		[DisplayIcon] nvarchar(Max),
		[EventCode] nvarchar(200),
		[UserType] nvarchar(200),
		[DescriptionResourceKey] nvarchar(500),
		[EventMasterId] BIGINT,
		[IsSelectedNotification] bit,
		[IsSelectedNotificationicon] bit,
		[ModifiedBy] BIGINT,
		[NotificationDays] bigint
		)tmp 

		

	

		--select * from #tmpNotificationList
		

		

		 

			UPDATE dbo.NotificationPreferences
			SET dbo.NotificationPreferences.[Notification]=0,dbo.NotificationPreferences.ModifiedBy=#tmpNotificationList.[ModifiedBy],dbo.NotificationPreferences.ModifiedDate=GETDATE()
			FROM #tmpNotificationList
			WHERE dbo.NotificationPreferences.CompanyId=#tmpNotificationList.CompanyId
			and isnull(dbo.NotificationPreferences.EventMasterId,0)=isnull(#tmpNotificationList.EventMasterId,0)
	

			UPDATE dbo.NotificationPreferences 
			SET dbo.NotificationPreferences.[Notification]=1,dbo.NotificationPreferences.ModifiedBy=tmpnotifi.[ModifiedBy],dbo.NotificationPreferences.ModifiedDate=GETDATE()
			FROM #tmpNotificationList tmpnotifi
			WHERE dbo.NotificationPreferences.CompanyId=tmpnotifi.CompanyId
			and isnull(dbo.NotificationPreferences.EventMasterId,0)=isnull(tmpnotifi.EventMasterId,0)
			and isnull(tmpnotifi.IsSelectedNotification,'0')!='0'

		INSERT INTO [dbo].[NotificationPreferences]
           ([CompanyId]
		   ,[userName]
		   ,[EventMasterId]
           ,[Notification]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])

		select 
		 tmpsp.[CompanyId]
		 ,(select top 1 UserName from [Login] l where l.LoginId=tmpsp.[ModifiedBy])
		,tmpsp.[EventMasterId]
		,isnull(tmpsp.IsSelectedNotification,'0')
		,tmpsp.[ModifiedBy]
		,GETDATE()
		,1
		FROM #tmpNotificationList tmpsp
		WHERE --isnull(tmpsp.IsSelectedNotification,'0')!='0'and 
		NOT EXISTS(SELECT 1 FROM [NotificationPreferences] a WHERE a.CompanyId=tmpsp.CompanyId and a.IsActive=1
	    and isnull(a.EventMasterId,0)=isnull(tmpsp.EventMasterId,0))

		Declare @companyId bigint
		Declare @createdby bigint
		Declare @notificationDays nvarchar(500)

		set @companyId = (select top 1 tmp.[CompanyId] from #tmpNotificationList tmp)
		set @notificationDays = (select top 1 tmp.[NotificationDays] from #tmpNotificationList tmp)
		set @createdby = (select top 1 tmp.ModifiedBy from #tmpNotificationList tmp)

		if ((select count(*) from [UserPreferences] where [CompanyId] = @companyId and [UserPreferencesKey] = 'NotificationStoreDays') > 0)
		Begin
			Update [dbo].[UserPreferences] set [UserPreferencesValue] = @notificationDays, [UpdatedDate] = GETDATE(), [UpdatedBy] = @createdby
			 where [CompanyId] = @companyId 
			and [UserPreferencesKey] = 'NotificationStoreDays'
		End
		Else
		Begin
			INSERT INTO [dbo].[UserPreferences]
			   ([UserPreferencesKey]
			   ,[CompanyId]
			   ,[UserPreferencesValue]
			   ,[IsActive]
			   ,[CreatedDate]
			   ,[CreatedBy])

			   Values
			   ('NotificationStoreDays'
			   ,@companyId
			   ,@notificationDays
			   ,1
			   ,GETDATE()
			   ,@createdby)
		end

		select top 1 @UserId= tmp.ModifiedBy from #tmpNotificationList tmp where isnull(tmp.ModifiedBy,0)!=0

	   truncate table #tmpNotificationList;
		
            SELECT @UserId as UserId FOR XML RAW('Json'),ELEMENTS

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.[USP_UpdateManageNotificationB2BApp]'



