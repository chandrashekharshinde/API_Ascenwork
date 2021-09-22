
----------------------------------------------------------------- 
-- INSERT STORED PROCEDURE 
-- Date Created: Friday, December 25, 2015 
-- Created By:   Nimish 
-- Procedure to insert entries in the dbo.Login table 
----------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ISP_Login] --'<Json><ServicesAction>CreateLogin</ServicesAction><Login><Name>T</Name><EmailAddress></EmailAddress><ContactNumber></ContactNumber><FileFormat></FileFormat><UserProfilePicture>/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHQAdAMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAgYBBQcEA//EADsQAAIBAwEFAwcJCQAAAAAAAAABAgMEEQUGEiExUUGBoRUiYXKRweETFDI1UnOxstEjJCUzNEJidPD/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAf/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AO4gAAAAB5ri/tbZ4rVop/ZTy/YajV9WjPeo2zbS4Oalhd2OZo2wLT5dsuK3p98Xg8k9o0m922bXY3P4FfZFsC02OvUK81CtF0ZN4TbzF95tznzNtYa9UtbZUalJ1d1+bJzxw6cgLWDXaZq9DUG4RjKFRLLjLp6GbEAAAAAAAAAavaCvOjZKMHj5SW636DaGk2oeKFD13+AFeZFhsi2Blsi2GyLYBsi2GyIHv0SqqWqUJOagm93jyeeGP+9BeDnC+ksdTo6AAAAAAAAAGl2oj+6UZdKmPB/obor+0l7SlF2ai3UjJScuyPD4gV/JhsMi2AbIthsiwBhsNkWyj6UFvXFKPWcV4nRjnFvVVC5pVpR3lTnGbj1w8l+0+8pX1rG4o5UZZTT5prsIPSAAAAAAAAUrWc+VLnPPf9xdSvbR6ZVqVPndvBzysVIxWXw5MCutkWyVSM6cnGpGUJLmpLDR8wDMNhsi2UGyLYbItgGy47H58lzzy+WePYiq2tjdXkoxt6E5qTwpY83vfIvumWcbCypW0XncXGXV9rIPUAAAAAAAAAAKrtXauFzTuYrzai3Zesvh+BoWzoF/aQvbWdCpykuD6PsZQrqjO1uKlCrjfg8PAHybIthsi2UGzCy2lFNt8FgwywbKaZ8vV+fVuNOnLEI9Zde4CyaTafMtPo0H9KMfO9Z8WewAgAAAAAAB8q9zQt1mvWp0/WkkB9Qae42jsaWVTc6z/wAI4XtZq7nai4nwt6FOmusnvMC2FC19/wAZuvWX5UfO51S+uf5t1Ua+zF7q9iPE2AbIsMw2UGy6bH/VD+9l7ilNinWqUZb9GpOnLrCTTCOpA5/bbSanb4TrRqx6VY58VxNta7ZU3hXdrKPWVOWfBkVagay117TLnChd04yf9tTzH4myjJSSlFpp8mgMgADWa9fysbPNJpVaj3YN9nVlLqTlUm5zk5SfNyeWzf7YT/b20OxRk/FfoV1gGRbMtkGyg2RBhgGYYZFsINkGw2YbANkQYYBmy0HV6umXdPM27aUkqkOzHVelGrbIvkB17PQHm0yo62m2lWT4zowk++KBFV3a/wDraH3XvZoGABFkWAUYZFgBEWRYAEWRYAGGYZgARZFgAdT0P6msf9eH5UZAIr//2Q==</UserProfilePicture><AllowFileFormat>jpg,png</AllowFileFormat><AllowFileSize>3</AllowFileSize><ReferenceId>674</ReferenceId><ReferenceType>28</ReferenceType><CompanyName></CompanyName><UserName>D1</UserName><Password>12345</Password><RoleMasterId>8</RoleMasterId><RoleName></RoleName><IsActive></IsActive><CreatedDate></CreatedDate><CreatedBy></CreatedBy><LicenseType>2500</LicenseType><DefaultLanguage>1101</DefaultLanguage><ContactInformationList><ContactinfoGUID>ac43d26a-dfcb-4a9e-9dcf-a360112a13e1</ContactinfoGUID><ContactType>Fax</ContactType><ContactTypeId>1284</ContactTypeId><ContactPersonName>F</ContactPersonName><ContactPersonNumber>23456</ContactPersonNumber><ObjectType>Login</ObjectType><IsActive>true</IsActive><CreatedBy>409</CreatedBy></ContactInformationList><ContactInformationList><ContactinfoGUID>2cbd8a2e-2ce8-413e-acc3-2ddef85ef308</ContactinfoGUID><ContactType>MobileNo</ContactType><ContactTypeId>1282</ContactTypeId><ContactPersonName>M</ContactPersonName><ContactPersonNumber>4567</ContactPersonNumber><ObjectType>Login</ObjectType><IsActive>true</IsActive><CreatedBy>409</CreatedBy></ContactInformationList><LoginId>0</LoginId><LicenseNumber>234567</LicenseNumber><HashedPassword>HVoTFlWa3VQU6SUrmjrNhBmKSbgoHfxlZvdil8QzyI0=</HashedPassword><PasswordSalt>1748342828</PasswordSalt></Login></Json>'
  -- 'CreateLoginsonusImages/download.jpgaruns123456782282d3a88f5-53f0-47ba-9748-88fbfb381debEmail12832342323423Logintrue88d77df40-2dfc-4b15-a03c-61748d494a70MobileNo128223423423234Logintrue8ws43JjFBDj3d1Vw7zWaNiGQ7gLaI6jhh+Qu31JDsAok=2076609237'
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 

      SET @ErrSeverity = 15; 

      DECLARE @LicenseNumber NVARCHAR(100); 
      DECLARE @RoleMasterId BIGINT; 
      DECLARE @Login BIGINT ;
	  DECLARE @GlobalRoleName nvarchar(50); 
	  Declare @documentIdentity bigint=0
					  Declare @Documentaction nvarchar(50)
      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

          SELECT @LicenseNumber = tmp1.[licensenumber], 
                 @RoleMasterId = tmp1.[rolemasterid] ,
				 @GlobalRoleName=tmp1.[GlobalRoleName]
          FROM   OPENXML(@intpointer, 'Json/Login', 2) 
                    WITH ( [LicenseNumber] NVARCHAR(100), 
                           [RoleMasterId]  BIGINT,
						   [GlobalRoleName] NVARCHAR(50) )tmp1 

          SELECT * 
          INTO   #tmplogin 
          FROM   OPENXML(@intpointer, 'Json/Login', 2) 
                    WITH ( [Name]               NVARCHAR(250), 
                           [ReferenceId]        BIGINT, 
                           [ReferenceType]      BIGINT, 
                           [UserName]           NVARCHAR(250), 
                           [HashedPassword]     NVARCHAR(250), 
                           [PasswordSalt]       BIGINT, 
                           [RoleMasterId]       BIGINT, 
                           [CompanyType]        BIGINT, 
                           [CreatedBy]          BIGINT, 
                           [UserProfilePicture] NVARCHAR(max),
						   [LicenseType]      NVARCHAR(50) ,
                           [LicenseNumber]      NVARCHAR(100) )tmp 

          -----get contact  information 
          SELECT * 
          INTO   #tmpcontactinformationlist 
          FROM   OPENXML(@intpointer, 'Json/Login/ContactInformationList', 2) 
                    WITH ( [ContactType]         NVARCHAR(250), 
                           [ContactTypeId]       BIGINT, 
                           [ContactPersonName]   NVARCHAR(250), 
                           [ContactPersonNumber] NVARCHAR(250), 
                           [ObjectType]          NVARCHAR(250) )tmp 

          -----get document  information 
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
                              WHERE  l.[licensenumber] = @LicenseNumber 
                                     AND isactive = 1 and @LicenseNumber is not null and @LicenseNumber <> '') 
                  BEGIN 
				  
                      INSERT INTO [dbo].[login] 
                                  ([rolemasterid], 
                                   [name], 
                                   [username], 
                                   [hashedpassword], 
                                   [passwordsalt], 
                                   [parentloginid], 
                                   [referenceid], 
                                   [referencetype], 
                                   [isactive], 
                                   [createddate], 
                                   [createdby], 
                                   [createdfromipaddress], 
                                   [activationcode], 
                                   [userprofilepicture],
								   [LicenseType], 
                                   [licensenumber],
								   ChangePasswordonFirstLoginRequired,
								   DefaultLanguage) 
                      SELECT #tmplogin.[rolemasterid], 
                             #tmplogin.[name], 
                             #tmplogin.[username], 
                             #tmplogin.[hashedpassword], 
                             #tmplogin.[passwordsalt], 
                             NULL, 
                           (case when #tmplogin.[rolemasterid]=1 then 0  else #tmplogin.[referenceid] end)[referenceid], 
                             #tmplogin.[referencetype], 
                             1, 
                             Getdate(), 
                             '1', 
                             '', 
                             '', 
                             #tmplogin.[userprofilepicture], 
							 #tmplogin.[LicenseType],
                             #tmplogin.licensenumber 
							 ,1
							 ,1101
                      FROM   #tmplogin 
                             LEFT JOIN login l 
                                    ON #tmplogin.[username] = l.username 
                      WHERE  l.loginid IS NULL 

                      SET @Login = @@IDENTITY 
					  
                      INSERT INTO [dbo].[contactinformation] 
                                  ([objectid], 
                                   [objecttype], 
                                   [contacttype], 
                                   [contactperson], 
                                   [contacts], 
                                   [createdby], 
                                   [createddate], 
                                   [isactive]) 
                      SELECT @Login, 
                             #tmpcontactinformationlist.[objecttype], 
                             #tmpcontactinformationlist.[contacttype], 
                             #tmpcontactinformationlist.[contactpersonname], 
                             #tmpcontactinformationlist.[contactpersonnumber], 
                             '1', 
                             Getdate(), 
                             1 
                      FROM   #tmpcontactinformationlist 
                      WHERE  @Login IS NOT NULL 
					   
					   
	SET @Documentaction=(Select top 1 DocumentTypeAction from #tmpdocumentinformationlist)	
	
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
                             @Login, 
                             #tmpdocumentinformationlist.[objecttype], 
                             1, 
                             1, 
                             Getdate(),                              
							 Case when @documentIdentity=0 then #tmpdocumentinformationlist.[documenttypeid]  else @documentIdentity end
                      FROM   #tmpdocumentinformationlist 
                      WHERE  @Login IS NOT NULL 

                      SELECT @Login  AS LoginId, 
                             ( CASE 
                                 WHEN ( @Login = 0 
                                         OR @Login IS NULL ) THEN 'error' 
                                 ELSE 'success' 
                               END ) AS 'Message' 
                      FOR xml raw('Json'), elements 
                  END 
                ELSE 
                  BEGIN 
                      SET @Login=-1 

                      SELECT @Login  AS LoginId, 
                             ( CASE 
                                 WHEN ( ( @Login = 0 
                                           OR @Login IS NULL ) 
                                         OR @Login = -1 ) THEN 'error' 
                                 ELSE 'success' 
                               END ) AS 'Message' 
                      FOR xml raw('Json'), elements 
                  END 
            END 
          ELSE 
            BEGIN 
                INSERT INTO [dbo].[login] 
                            ([rolemasterid], 
                             [name], 
                             [username], 
                             [hashedpassword], 
                             [passwordsalt], 
                             [parentloginid], 
                             [referenceid], 
                             [referencetype], 
                             [isactive], 
                             [createddate], 
                             [createdby], 
                             [createdfromipaddress], 
                             [activationcode], 
                             [userprofilepicture], 
                             [licensenumber],
							 ChangePasswordonFirstLoginRequired,
							 DefaultLanguage) 
                SELECT #tmplogin.[rolemasterid], 
                       #tmplogin.[name], 
                       #tmplogin.[username], 
                       #tmplogin.[hashedpassword], 
                       #tmplogin.[passwordsalt], 
                       NULL, 
                     (case when #tmplogin.[rolemasterid]=1 then 0  else #tmplogin.[referenceid] end)[referenceid] , 
                       #tmplogin.[referencetype], 
                       1, 
                       Getdate(), 
                       '1', 
                       '', 
                       '', 
                       #tmplogin.[userprofilepicture], 
                       #tmplogin.licensenumber 
					   ,1
					   ,1101
                FROM   #tmplogin 
                       LEFT JOIN login l 
                              ON #tmplogin.[username] = l.username 
                WHERE  l.loginid IS NULL 

                SET @Login = @@IDENTITY 

                INSERT INTO [dbo].[contactinformation] 
                            ([objectid], 
                             [objecttype], 
                             [contacttype], 
                             [contactperson], 
                             [contacts], 
                             [createdby], 
                             [createddate], 
                             [isactive]) 
                SELECT @Login, 
                       #tmpcontactinformationlist.[objecttype], 
                       #tmpcontactinformationlist.[contacttype], 
                       #tmpcontactinformationlist.[contactpersonname], 
                       #tmpcontactinformationlist.[contactpersonnumber], 
                       '1', 
                       Getdate(), 
                       1 
                FROM   #tmpcontactinformationlist 
                WHERE  @Login IS NOT NULL 

                  
					   
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
                             @Login, 
                             #tmpdocumentinformationlist.[objecttype], 
                             1, 
                             1, 
                             Getdate(),                              
							 Case when @documentIdentity=0 then #tmpdocumentinformationlist.[documenttypeid]  else @documentIdentity end
                      FROM   #tmpdocumentinformationlist 
                      --WHERE  @Login IS NOT NULL 

                SELECT @Login  AS LoginId, 
                       ( CASE 
                           WHEN ( @Login = 0 
                                   OR @Login IS NULL ) THEN 'error' 
                           ELSE 'success' 
                         END ) AS 'Message'
                FOR xml raw('Json'), elements 




            END 
			--IF( @GlobalRoleName = 'Carrier' or @GlobalRoleName = 'TransportManager') 
			--   BEGIN
			--	Update Login set UserName=@Login where LoginId=@Login
			--   END
          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
