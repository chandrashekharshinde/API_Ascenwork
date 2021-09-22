CREATE PROCEDURE [dbo].[USP_UploadPhotoForSubDApp]  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @LoginId BIGINT 

	  

      SET @ErrSeverity = 15; 
	  SET @LoginId=1;
      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
			
			--select Row_Number() Over(order by tmp.[UserId]) as rownum,* into #UserDetails
			--FROM OPENXML(@intpointer,'Json/UserProfileList',2)
			--WITH (
			--		[UserId] bigint,
			--		[Photo] nvarchar(max),
			--		CreatedBy bigint,
			--		[UserName] nvarchar(2000)
			--		)tmp

			select * into #UserDetails
			FROM OPENXML(@intpointer,'Json/UserProfileList',2)
			WITH (
					[UserId] bigint,
					[Photo] nvarchar(max),
					CreatedBy bigint,
					[UserName] nvarchar(2000)
					)tmp
			
			--declare @rownum bigint
			--set @rownum=1
			--declare @rowCount bigint

			--set @rowCount=(select Count(*) from #UserDetails)
			--while(@rownum<=@rowCount)
			--begin
				
				DECLARE @UserId BIGINT 
				DECLARE @CompanyId BIGINT 
				DECLARE @ContactName NVARCHAR(500)
				DECLARE @CreatedBy BIGINT
				DECLARE @photo NVARCHAR(max)

				select top 1 @UserId = #UserDetails.[UserId], @photo = #UserDetails.[Photo], @CreatedBy = #UserDetails.[CreatedBy] from #UserDetails --where #UserDetails.rownum=@rownum
				select top 1 @CompanyId= [Login].ReferenceId, @ContactName = [Login].[Name] from [Login] where [Login].LoginId = @UserId

				if(@photo != '')
				Begin
					if((select count(*) from ContactInformation where ObjectId = @CompanyId and ContactType='Photo') > 0)
					Begin
						update [contactinformation] set contacts=@photo,ContactPerson=@ContactName,ModifiedBy=@CreatedBy,modifiedDate=GetDate()
						where objectid=@CompanyId and ContactType='Photo';
					End;
					Else
					Begin
	
						INSERT INTO [dbo].[ContactInformation]
							   ([ObjectId]
							   ,[ObjectType]
							   ,[ContactType]
							   ,[ContactPerson]
							   ,[Contacts]
							   ,[Purpose]
							   ,[CreatedBy]
							   ,[CreatedDate]
							   ,[IsActive])
						 VALUES
							   (@CompanyId
							   ,'Company'
							   ,'Photo'
							   ,@ContactName
							   ,@photo
							   ,null
							   ,@CreatedBy
							   ,getdate()
							   ,1)

					End;
				End;

			--end;

				--UPDATE [dbo].[Login] 
				--	SET @LoginId=1,
				--	UserProfilePicture= tmp.[Photo],
				--	[UpdatedDate] = Getdate(),
				--	[UpdatedBy]=tmp.[CreatedBy]
                
				--FROM   OPENXML(@intpointer, 'Json/UserProfileList', 2) 
				--WITH (
				--	[UserId] bigint,
				--	[Photo] nvarchar(max),
				--	CreatedBy bigint,
				--	[UserName] nvarchar(2000)
				--	)tmp  WHERE [Login].[LoginId]=tmp.[UserId];

				drop table #UserDetails;	
			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
			SELECT CAST((SELECT   'true' AS [@json:Array],
            1 AS UserId , (case when (@LoginId=0 or @LoginId='') then 'Failed' else 'Success'end) as Status
          FOR XML path('userId'),ELEMENTS,ROOT('Json')) AS XML)

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 
          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END