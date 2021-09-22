CREATE PROCEDURE [dbo].[ISP_Profile] --'<Json><RequestDate>2017-10-26T00:00:00</RequestDate><EnquiryType>ST</EnquiryType><ShipTo>18</ShipTo><SoldTo>0</SoldTo><TruckSizeId>1</TruckSizeId><branchPlant>7</branchPlant><IsActive>true</IsActive><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CreatedBy>2</CreatedBy><OrderProductList><ItemId>97</ItemId><ItemName>Affligem Blond 300x24B Ctn</ItemName><ProductCode>65801001</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>1</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList><OrderProductList><ItemId>105</ItemId><ItemName>Desperados 330x12C Ctn</ItemName><ProductCode>65705131</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>3</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList></Json>'
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
			




        INSERT INTO	[Profile]
        (
        	[Name],
        	[EmailId],
        	[ContactNumber],
        	UserProfilePicture,
        	ParentUser,
        	ReferenceId,
        	ReferenceType,
			LicenseNumber,
			DriverId,
        	IsActive,
        	[CreatedBy],
        	[CreatedDate]
        )

        SELECT
        	
        	tmp.[Name],
        	tmp.[EmailId],
        	tmp.[ContactNumber],
        	tmp.UserProfilePicture,
        	tmp.ParentUser,
        	tmp.ReferenceId,
        	tmp.ReferenceType,
			tmp.LicenseNumber,
			tmp.DriverId,
        	tmp.IsActive,
        	tmp.[CreatedBy],
        	GETDATE()

            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [Name] nvarchar(50),
        	[EmailId] nvarchar(100),
        	[ContactNumber] nvarchar(50),
        	UserProfilePicture nvarchar(max),
        	ParentUser bigint,
        	ReferenceId bigint,
        	ReferenceType bigint,
			LicenseNumber nvarchar(50),
			DriverId nvarchar(50),
        	IsActive bit,
        	[CreatedBy] bigint
        )tmp
        
        DECLARE @ProfileId bigint
	    SET @ProfileId = @@IDENTITY
        

		 INSERT INTO [Login] 
		(
			[ProfileId],
			[RoleMasterId],
			[UserName],
			[PasswordSalt],
			[HashedPassword],
			LoginAttempts,
			AccessKey,
			
			ChangePasswordonFirstLoginRequired,
			[IsActive],
			[CreatedDate],
			[CreatedBy]
        )

        SELECT
        	@ProfileId,
        	
			tmp.[RoleMasterId],
			tmp.[UserName],
			tmp.[PasswordSalt],
			tmp.[HashedPassword],
			tmp.LoginAttempts,
			tmp.AccessKey,
			
			tmp.ChangePasswordonFirstLoginRequired,
			tmp.[IsActive],
			GETDATE(),
			tmp.[CreatedBy]
            FROM OPENXML(@intpointer,'Json/Login',2)
        WITH
        (
          
            RoleMasterId bigint,
			UserName nvarchar(50),
            HashedPassword nvarchar(50),
            PasswordSalt int,
			LoginAttempts int,
			AccessKey nvarchar(250),
            
			ChangePasswordonFirstLoginRequired bit,
			 [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime          
           
           
        )tmp

		DECLARE @LoginId bigint
	    SET @LoginId = @@IDENTITY

		  INSERT INTO	[Documents] 
		(
			DocumentName,
			DocumentExtension,
			DocumentBase64,
			ObjectId,
			ObjectType,
			SequenceNo,
			[IsActive],
			[CreatedDate],
			[CreatedBy]
        )

        SELECT
        	
        	
			tmp.DocumentName,
			tmp.DocumentExtension,
			tmp.DocumentBase64,
			@ProfileId,
			'Profile',
			SequenceNo,
			tmp.[IsActive],
			GETDATE(),
			tmp.[CreatedBy]
            FROM OPENXML(@intpointer,'Json/Document',2)
        WITH
        (
            DocumentName nvarchar(50),
			DocumentExtension nvarchar(50),
			DocumentBase64 nvarchar(max),
			ObjectType nvarchar(50),
			SequenceNo bigint,
			 [IsActive] bit,
            [CreatedBy] bigint        
           
           
        )tmp




     SELECt   ProfileId  ,LoginId , RoleMasterId  from Login  where LoginId=@loginId  FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
