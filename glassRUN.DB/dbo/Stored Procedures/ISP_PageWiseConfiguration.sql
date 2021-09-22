CREATE PROCEDURE [dbo].[ISP_PageWiseConfiguration]  --'<Json><ServicesAction>SavePagewiseconfiguration</ServicesAction><PageWiseConfigurationList><PageWiseConfigurationId>0</PageWiseConfigurationId><RoleId>4</RoleId><PageId>6</PageId><UserId></UserId><CompanyId>0</CompanyId><SettingName>AddItemInTruckApplicable</SettingName><SettingValue>1</SettingValue><CreatedBy>409</CreatedBy><IsActive>true</IsActive></PageWiseConfigurationList></Json>'
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @PageWiseConfigurationId BIGINT 

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

		SELECT * INTO #tmpPageWiseConfiguration 
			FROM OPENXML(@intpointer,'Json/PageWiseConfigurationList',2)
			 WITH
             (
			 [PageId]         Bigint, 
                           [RoleId]         Bigint, 
                           [UserId]         Bigint,
                           [CompanyId]	    Bigint,
						   [SettingName]    NVARCHAR(max), 
                           [SettingValue]   NVARCHAR(max), 
						   [IsActive]		bit,
						   [CreatedBy]      bigint
			 ) tmp

			 Declare @userId bigint=0
			 Declare @roleId bigint=0
			 Declare @pageId bigint=0
			 SET @userId=(Select top 1 [UserId] from #tmpPageWiseConfiguration)
			 SET @roleId=(Select top 1 [RoleId] from #tmpPageWiseConfiguration)
			 SET @pageId=(Select top 1 [PageId] from #tmpPageWiseConfiguration)
			 Print @userId
			 Print @roleId
			 Print @pageId
			 
if @userId=0
	BEGIN
				Delete from PageWiseConfiguration where PageId=@pageId and RoleId=@roleId

				INSERT INTO [dbo].[PageWiseConfiguration]
		           ([PageId]
		           ,[RoleId]
		           ,[UserId]
		          -- ,[CompanyId]
		           ,[SettingName]
		           ,[SettingValue]
		           ,[IsActive]
		           ,[CreatedBy]
		           ,[CreatedDate])
          SELECT 
				 tmp.[PageId],
				 Case when (tmp.[UserId] is not null and tmp.[UserId]!='') then 0 else tmp.[RoleId] end, 
				 tmp.[UserId], 
				-- tmp.[CompanyId], 
				 tmp.[SettingName], 
				 ISNULL(tmp.[SettingValue],0),
				 tmp.[IsActive], 
				 tmp.[CreatedBy],
				 Getdate()
                  
          FROM   OPENXML(@intpointer, 'Json/PageWiseConfigurationList', 2) 
                    WITH ( [PageId]         Bigint, 
                           [RoleId]         Bigint, 
                           [UserId]         Bigint,
                           [CompanyId]	    Bigint,
						   [SettingName]    NVARCHAR(max), 
                           [SettingValue]   NVARCHAR(max), 
						   [IsActive]		bit,
						   [CreatedBy]      bigint
                           )tmp 

          SET @PageWiseConfigurationId = @@IDENTITY 


          SELECT @PageWiseConfigurationId AS PageWiseConfigurationId 
          FOR xml raw('Json'), elements
	END
ELSE 
BEGIN
	Delete from PageWiseConfiguration where PageId=@pageId and RoleId=0 and UserId=@userId

	INSERT INTO [dbo].[PageWiseConfiguration]
		           ([PageId]
		           ,[RoleId]
		           ,[UserId]
		          -- ,[CompanyId]
		           ,[SettingName]
		           ,[SettingValue]
		           ,[IsActive]
		           ,[CreatedBy]
		           ,[CreatedDate])
          SELECT 
				 tmp.[PageId],
				 Case when (tmp.[UserId] is not null and tmp.[UserId]!='') then 0 else tmp.[RoleId] end, 
				 tmp.[UserId], 
				-- tmp.[CompanyId], 
				 tmp.[SettingName], 
				 ISNULL(tmp.[SettingValue],0),
				 tmp.[IsActive], 
				 tmp.[CreatedBy],
				 Getdate()
                  
          FROM   OPENXML(@intpointer, 'Json/PageWiseConfigurationList', 2) 
                    WITH ( [PageId]         Bigint, 
                           [RoleId]         Bigint, 
                           [UserId]         Bigint,
                           [CompanyId]	    Bigint,
						   [SettingName]    NVARCHAR(max), 
                           [SettingValue]   NVARCHAR(max), 
						   [IsActive]		bit,
						   [CreatedBy]      bigint
                           )tmp 

          SET @PageWiseConfigurationId = @@IDENTITY 


          SELECT @PageWiseConfigurationId AS PageWiseConfigurationId 
          FOR xml raw('Json'), elements
END

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END