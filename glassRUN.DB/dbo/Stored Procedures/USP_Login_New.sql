CREATE PROCEDURE [dbo].[USP_Login_New] 
  --'<Json><ServicesAction>CreateLogin</ServicesAction><Login><Name>mis2</Name><EmailAddress></EmailAddress><ContactNumber></ContactNumber><FileFormat></FileFormat><UserProfilePicture>/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHQAdAMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAgYBBQcEA//EADsQAAIBAwEFAwcJCQAAAAAAAAABAgMEEQUGEiExUUGBoRUiYXKRweETFDI1UnOxstEjJCUzNEJidPD/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAf/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AO4gAAAAB5ri/tbZ4rVop/ZTy/YajV9WjPeo2zbS4Oalhd2OZo2wLT5dsuK3p98Xg8k9o0m922bXY3P4FfZFsC02OvUK81CtF0ZN4TbzF95tznzNtYa9UtbZUalJ1d1+bJzxw6cgLWDXaZq9DUG4RjKFRLLjLp6GbEAAAAAAAAAavaCvOjZKMHj5SW636DaGk2oeKFD13+AFeZFhsi2Blsi2GyLYBsi2GyIHv0SqqWqUJOagm93jyeeGP+9BeDnC+ksdTo6AAAAAAAAAGl2oj+6UZdKmPB/obor+0l7SlF2ai3UjJScuyPD4gV/JhsMi2AbIthsiwBhsNkWyj6UFvXFKPWcV4nRjnFvVVC5pVpR3lTnGbj1w8l+0+8pX1rG4o5UZZTT5prsIPSAAAAAAAAUrWc+VLnPPf9xdSvbR6ZVqVPndvBzysVIxWXw5MCutkWyVSM6cnGpGUJLmpLDR8wDMNhsi2UGyLYbItgGy47H58lzzy+WePYiq2tjdXkoxt6E5qTwpY83vfIvumWcbCypW0XncXGXV9rIPUAAAAAAAAAAKrtXauFzTuYrzai3Zesvh+BoWzoF/aQvbWdCpykuD6PsZQrqjO1uKlCrjfg8PAHybIthsi2UGzCy2lFNt8FgwywbKaZ8vV+fVuNOnLEI9Zde4CyaTafMtPo0H9KMfO9Z8WewAgAAAAAAB8q9zQt1mvWp0/WkkB9Qae42jsaWVTc6z/wAI4XtZq7nai4nwt6FOmusnvMC2FC19/wAZuvWX5UfO51S+uf5t1Ua+zF7q9iPE2AbIsMw2UGy6bH/VD+9l7ilNinWqUZb9GpOnLrCTTCOpA5/bbSanb4TrRqx6VY58VxNta7ZU3hXdrKPWVOWfBkVagay117TLnChd04yf9tTzH4myjJSSlFpp8mgMgADWa9fysbPNJpVaj3YN9nVlLqTlUm5zk5SfNyeWzf7YT/b20OxRk/FfoV1gGRbMtkGyg2RBhgGYYZFsINkGw2YbANkQYYBmy0HV6umXdPM27aUkqkOzHVelGrbIvkB17PQHm0yo62m2lWT4zowk++KBFV3a/wDraH3XvZoGABFkWAUYZFgBEWRYAEWRYAGGYZgARZFgAdT0P6msf9eH5UZAIr//2Q==</UserProfilePicture><AllowFileFormat>jpg,png</AllowFileFormat><AllowFileSize>10</AllowFileSize><ReferenceId>1</ReferenceId><ReferenceType>23</ReferenceType><CompanyName>HEINEKEN VIETNAM BREWERY LIMITED COMPANY</CompanyName><UserName>mis2</UserName><Password></Password><RoleMasterId>1         </RoleMasterId><RoleName>Admin</RoleName><IsActive></IsActive><CreatedDate></CreatedDate><CreatedBy></CreatedBy><LicenseType>2501</LicenseType><DefaultLanguage>1101</DefaultLanguage><LoginId>10660</LoginId><LicenseNumber /><HashedPassword>UyT7B7SPBBHRMWDL/atnsdifENQHN/mjj1+ySms1Vck=</HashedPassword><PasswordSalt>276748554</PasswordSalt></Login></Json>' 
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @LoginId BIGINT; 
      DECLARE @LicenseNumber NVARCHAR(100); 
	  DECLARE @userProfilePhoto NVARCHAR(max); 
      DECLARE @RoleMasterId BIGINT; 
	  DECLARE @GlobalRoleName nvarchar(50); 
	    DECLARE @Login BIGINT 
	  Declare @documentIdentity bigint=0
	   Declare @Documentaction nvarchar(50);

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

          SELECT @LicenseNumber = tmp1.[licensenumber], 
                 @RoleMasterId = tmp1.[rolemasterid],
				 @userProfilePhoto=tmp1.[UserProfilePicture],
				 @GlobalRoleName=tmp1.[GlobalRoleName],
				 @LoginId= tmp1.[LoginId]
          FROM   OPENXML(@intpointer, 'Json/Login', 2) 
                    WITH ( [LicenseNumber] NVARCHAR(100),
				         	[LoginId]         BIGINT, 
							[UserProfilePicture] NVARCHAR(max), 
							   [LicenseType]      NVARCHAR(50) ,
							   [GlobalRoleName] NVARCHAR(50),
                           [RoleMasterId]  BIGINT )tmp1 

          SELECT * 
          INTO   #tmpcontactinformationlist 
          FROM   OPENXML(@intpointer, 'Json/Login/ContactInformationList', 2) 
                    WITH ( [ContactInformationId] BIGINT, 
                           [ContactType]          NVARCHAR(250), 
                           [ContactTypeId]        BIGINT, 
                           [ContactPersonName]    NVARCHAR(250), 
                           [ContactPersonNumber]  NVARCHAR(250), 
                           [ObjectType]           NVARCHAR(250),
						   [GlobalRoleName] NVARCHAR(250),
                           isactive               BIT )tmp 

						        SELECT * 
          INTO   #tmpdocumentinformationlist 
          FROM   OPENXML(@intpointer, 'Json/Login/DocumentInformationList', 2) 
                    WITH ( [DocumentType]      NVARCHAR(250), 
                           [DocumentTypeId]    NVARCHAR(250), 
                           [DocumentName]      NVARCHAR(250), 
                           [DocumentExtension] NVARCHAR(250), 
                           [DocumentBase64]    NVARCHAR(max),
							DocumentTypeAction nvarchar(100) ,
                           [ObjectType]        NVARCHAR(250) )tmp 


          IF( @GlobalRoleName = 'Carrier' or @GlobalRoleName = 'TransportManager') 
            BEGIN 
                IF NOT EXISTS(SELECT 1 
                              FROM   [login] l 
                              WHERE  l.[licensenumber] = @LicenseNumber and l.LoginId<>@LoginId 
                                     AND isactive = 1 and @LicenseNumber is not null and @LicenseNumber <> '') 
                  BEGIN 
                      UPDATE [dbo].[login] 
                      SET    @LoginId = tmp.[loginid], 
					         [LicenseType] = tmp.[LicenseType],
                             [rolemasterid] = tmp.[rolemasterid], 
                             [name] = tmp.[name], 
                             --[username] = tmp.[username], 
                             --[hashedpassword] = tmp.[hashedpassword], 
                             --[passwordsalt] = tmp.[passwordsalt], 
                            [referenceid] = case when tmp.[RoleMasterId]=1 then 0  else tmp.[ReferenceId] end, 
                             [defaultlanguage] = tmp.[defaultlanguage], 
                             [updatedby] = tmp.[createdby], 
                             [updateddate] = Getdate(), 
                             [licensenumber] = tmp.[licensenumber], 
							 [userprofilepicture]=tmp.[userprofilepicture],
                             [isactive] = 1 
                     FROM   OPENXML(@intpointer, 'Json/Login', 2) 
                                WITH ( [LoginId]         BIGINT, 
								[LicenseType]   NVARCHAR(50) ,
                                       [RoleMasterId]    BIGINT, 
                                       [Name]            NVARCHAR(500), 
                                       --[UserName]        NVARCHAR(200), 
                                       --[HashedPassword]  NVARCHAR(500), 
                                       --[PasswordSalt]    BIGINT, 
                                       [ReferenceId]     BIGINT, 
                                       [CreatedBy]       BIGINT, 
                                       [DefaultLanguage] BIGINT, 
                                       [LicenseNumber]   NVARCHAR(100), 
									   [UserProfilePicture] NVARCHAR(max), 
                                       [IsActive]        BIT )tmp 
                      WHERE  [login].[loginid] = tmp.[loginid] 

                      DELETE contactinformation 
                      WHERE  objectid = @LoginId 
                             AND objecttype = 'Login' 

                      INSERT INTO [dbo].[contactinformation] 
                                  ([objectid], 
                                   [objecttype], 
                                   [contacttype], 
                                   [contactperson], 
                                   [contacts], 
                                   [createdby], 
                                   [createddate], 
                                   [isactive]) 
                      SELECT @LoginId, 
                             #tmpcontactinformationlist.[objecttype], 
                             #tmpcontactinformationlist.[contacttype], 
                             #tmpcontactinformationlist.[contactpersonname], 
                             #tmpcontactinformationlist.[contactpersonnumber], 
                             '1', 
                             Getdate(), 
                             1 
                      FROM   #tmpcontactinformationlist 



					    DELETE Documents 
                      WHERE  objectid = @LoginId 
                             AND objecttype = 'Login'
							 
							 	SET @Documentaction=(Select top 1 DocumentTypeAction from #tmpdocumentinformationlist)	 

								  If @Documentaction = 'Add'
	BEGIN
	
		INSERT INTO [LookUp]
        (
    LookUpId     
    ,LookupCategory
    ,Name  
	,Code 
    ,[IsActive]
    ,[CreatedBy]
    ,[CreatedDate]
    

    
        )

        SELECT top 1
		(select top 1 LookUpId + 1 from LookUp order by LookUpId desc),
        (Select  top 1 LookUpCategoryId from LookUpCategory where Name='LoginDocumentType'),
         #tmpdocumentinformationlist.DocumentTypeId,  
		 1    ,           
         1,
		 1,
         GETDATE()          
          FROM #tmpdocumentinformationlist
		  SET @documentIdentity = (select top 1 LookUpId from LookUp order by LookUpId desc)
	END


                      INSERT INTO [dbo].[documents] 
                                  ([documentname], 
                                   [documentextension], 
                                   [documentbase64], 
                                   [objectid], 
                                   [objecttype], 
                                   [isactive], 
                                   [createdby], 
                                   [createddate], 
                                   [documenttypeid]) 
                      SELECT #tmpdocumentinformationlist.[documentname], 
                             #tmpdocumentinformationlist.[documentextension], 
                             #tmpdocumentinformationlist.[documentbase64], 
                             @LoginId, 
                             #tmpdocumentinformationlist.[objecttype], 
                             1, 
                             1, 
                             Getdate(),                              
							 Case when @documentIdentity=0 then #tmpdocumentinformationlist.[documenttypeid]  else @documentIdentity end
                      FROM   #tmpdocumentinformationlist 
          


                  --where (#tmpContactInformationList.ContactInformationId=0 or #tmpContactInformationList.ContactInformationId is null)
                  END 
                ELSE 
                  BEGIN 
                      SET @LoginId=-1 
                  END 
            END 
          ELSE 
            BEGIN 
                UPDATE [dbo].[login] 
                SET    @LoginId = tmp.[loginid], 
							  [LicenseType] = tmp.[LicenseType],
                       [rolemasterid] = tmp.[rolemasterid], 
                       [name] = tmp.[name], 
                       [username] = tmp.[username], 
                       --[hashedpassword] = tmp.[hashedpassword], 
                       --[passwordsalt] = tmp.[passwordsalt], 
                       [referenceid] = case when tmp.[RoleMasterId]=1 then 0  else tmp.[ReferenceId] end, 
                       [defaultlanguage] = tmp.[defaultlanguage], 
                       [updatedby] = tmp.[createdby], 
                       [updateddate] = Getdate(), 
                       [licensenumber] = tmp.[licensenumber],
					    [userprofilepicture]=tmp.[userprofilepicture], 
                       [isactive] = 1 
                FROM   OPENXML(@intpointer, 'Json/Login', 2) 
                          WITH ( [LoginId]         BIGINT, 
						  	[LicenseType]   NVARCHAR(50) ,
                                 [RoleMasterId]    BIGINT, 
                                 [Name]            NVARCHAR(500), 
                                 [UserName]        NVARCHAR(200), 
                                 --[HashedPassword]  NVARCHAR(500), 
                                 --[PasswordSalt]    BIGINT, 
                                 [ReferenceId]     BIGINT, 
                                 [CreatedBy]       BIGINT, 
                                 [DefaultLanguage] BIGINT, 
                                 [LicenseNumber]   NVARCHAR(100), 
								 [UserProfilePicture] NVARCHAR(max), 
                                 [IsActive]        BIT )tmp 
                WHERE  [login].[loginid] = tmp.[loginid] 

                DELETE contactinformation 
                WHERE  objectid = @LoginId 
                       AND objecttype = 'Login' 

                INSERT INTO [dbo].[contactinformation] 
                            ([objectid], 
                             [objecttype], 
                             [contacttype], 
                             [contactperson], 
                             [contacts], 
                             [createdby], 
                             [createddate], 
                             [isactive]) 
                SELECT @LoginId, 
                       #tmpcontactinformationlist.[objecttype], 
                       #tmpcontactinformationlist.[contacttype], 
                       #tmpcontactinformationlist.[contactpersonname], 
                       #tmpcontactinformationlist.[contactpersonnumber], 
                       '1', 
                       Getdate(), 
                       1 
                FROM   #tmpcontactinformationlist 
            --where (#tmpContactInformationList.ContactInformationId=0 or #tmpContactInformationList.ContactInformationId is null)



			SET @Documentaction=(Select top 1 DocumentTypeAction from #tmpdocumentinformationlist)	
	Print @Documentaction
	Print '1'
	--SET @reasonCodeId=(Select top 1 [ReasonCodeId] from #tmpdocumentinformationlist)
	    If @Documentaction = 'Add'
	BEGIN
	
		INSERT INTO [LookUp]
        (
    LookUpId     
    ,LookupCategory
    ,Name  
	,Code 
    ,[IsActive]
    ,[CreatedBy]
    ,[CreatedDate]
    

    
        )

        SELECT top 1
		(select top 1 LookUpId + 1 from LookUp order by LookUpId desc),
        (Select  top 1 LookUpCategoryId from LookUpCategory where Name='LoginDocumentType'),
         #tmpdocumentinformationlist.DocumentTypeId,  
		 1    ,           
         1,
		 1,
         GETDATE()          
          FROM #tmpdocumentinformationlist
		  SET @documentIdentity = (select top 1 LookUpId from LookUp order by LookUpId desc)
	END


                      INSERT INTO [dbo].[documents] 
                                  ([documentname], 
                                   [documentextension], 
                                   [documentbase64], 
                                   [objectid], 
                                   [objecttype], 
                                   [isactive], 
                                   [createdby], 
                                   [createddate], 
                                   [documenttypeid]) 
                      SELECT #tmpdocumentinformationlist.[documentname], 
                             #tmpdocumentinformationlist.[documentextension], 
                             #tmpdocumentinformationlist.[documentbase64], 
                         @LoginId, 
                             #tmpdocumentinformationlist.[objecttype], 
                             1, 
                             1, 
                             Getdate(),                              
							 Case when @documentIdentity=0 then #tmpdocumentinformationlist.[documenttypeid]  else @documentIdentity end
                      FROM   #tmpdocumentinformationlist 



            END 

          SELECT @LoginId AS LoginId 
          FOR xml raw('Json'), elements
          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
