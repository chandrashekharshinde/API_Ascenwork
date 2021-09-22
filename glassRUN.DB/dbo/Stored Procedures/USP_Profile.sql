CREATE PROCEDURE [dbo].[USP_Profile] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>239</ItemId><ItemName>bb</ItemName><ItemCode>02</ItemCode><PrimaryUnitOfMeasure>11</PrimaryUnitOfMeasure><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CompanyList><CompanyId>549</CompanyId><CompanyName>AP1-DNTN KIM DAO</CompanyName><CompanyMnemonic>1110139</CompanyMnemonic><CompanyNameAndMnemonic>AP1-DNTN KIM DAO (1110139)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>1600362268</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>0</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><IsSelected>false</IsSelected><SoldTo>549</SoldTo></CompanyList><CompanyList><CompanyId>624</CompanyId><CompanyName>D14 - CONG TY TNHH LINH HUNG</CompanyName><CompanyMnemonic>1111143</CompanyMnemonic><CompanyNameAndMnemonic>D14 - CONG TY TNHH LINH HUNG (1111143)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>0401294332</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>3</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><SoldTo>624</SoldTo></CompanyList></ItemList></Json>'

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
            DECLARE @ProfileId bigint
			Declare @loginId bigint

		

            UPDATE dbo.Profile SET
			@ProfileId=tmp.ProfileId,
        	[Name]=tmp.Name,
        	[EmailId]=tmp.[EmailId],
        	[ContactNumber]=tmp.[ContactNumber],
        	UserProfilePicture=tmp.UserProfilePicture,
        	ParentUser=tmp.ParentUser,
        	ReferenceId=tmp.ReferenceId,
        	ReferenceType=tmp.ReferenceType,
			LicenseNumber=tmp.LicenseNumber,
			UpdatedBy=tmp.UpdatedBy,
        	UpdatedDate  =GETDATE()   	
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProfileId] bigint,
            [Name] nvarchar(50),
        	[EmailId] nvarchar(100),
        	[ContactNumber] nvarchar(50),
        	UserProfilePicture nvarchar(max),
        	ParentUser bigint,
        	ReferenceId bigint,
        	ReferenceType bigint,
			LicenseNumber nvarchar(50),
        	IsActive bit,
			UpdatedBy bigint
            )  tmp WHERE [Profile].ProfileId= tmp.ProfileId


				Set @loginId = (Select LoginId from Login where ProfileId = @ProfileId and IsActive = 1)

			

			 UPDATE dbo.Login SET		
        	[UserName]=tmp.[UserName],        	
			UpdatedBy=tmp.UpdatedBy,
        	UpdatedDate  =GETDATE()   	
        	
            FROM OPENXML(@intpointer,'Json/Login',2)
			WITH
			(
			[ProfileId] bigint,
            [UserName] nvarchar(50),        	
			UpdatedBy bigint
            )  tmp WHERE [Login].ProfileId= tmp.ProfileId



			 UPDATE dbo.Documents SET		
        	DocumentName=tmp.[DocumentName],        	
			DocumentBase64=tmp.[DocumentBase64],        	
			DocumentExtension=tmp.[DocumentExtension],        	
			ModifiedBy=tmp.UpdatedBy,
        	ModifiedDate  =GETDATE()   	
        	
            FROM OPENXML(@intpointer,'Json/Document',2)
			WITH
			(
			[ObjectId] bigint,
			[ObjectType] nvarchar(50),
			DocumentName nvarchar(50),
			DocumentExtension nvarchar(50),
			DocumentBase64 nvarchar(max),      	
			UpdatedBy bigint
            )  tmp WHERE [Documents].ObjectId= tmp.[ObjectId] and [Documents].ObjectType= tmp.[ObjectType]

			








             SELECt   ProfileId  ,LoginId , RoleMasterId  from Login  where LoginId=@loginId  FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
