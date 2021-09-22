
CREATE PROCEDURE [dbo].[ISP_LicenseInfo]--'<Json><LicenseId>0</LicenseId><CustomerCode>HgR</CustomerCode><ProductCode>gR</ProductCode><ActivationCode>1D4959C1ED1973B3BE8889AB2032D97AAA19D6F27FB31AFA1A0F65E8B8C15F5783A92BA10968CAFEE25B1F7BDCE3F861</ActivationCode><IsActive>true</IsActive><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><FromDate>08/01/2019</FromDate><ToDate>31/12/2999</ToDate><Concurrent>Concurrent</Concurrent><UserTypeCode>ALL</UserTypeCode><NoOfUsers>100</NoOfUsers><IPAddress>*</IPAddress><LicenseType>Permanent</LicenseType></Json>'
(
	@xmlDoc xml 
)
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

		select * into #tempLicenseInfo
			  FROM OPENXML(@intpointer,'Json/LicenseInfoList',2)
			WITH
			(
            [CustomerCode] nvarchar(100),
            [ProductCode] nvarchar(100),
            [ActivationCode] nvarchar(max),
            [FromDate] datetime, 
			[ToDate] datetime, 
			[UserTypeCode] nvarchar(100),
			[NoOfUsers] nvarchar(100), 
			[LicenseType] nvarchar(100), 
			[IPAddress] nvarchar(100),  
			[Type] bigint   
            )tmp 

			select * into #tempIndividualLicenseUserList
			  FROM OPENXML(@intpointer,'Json/IndividualLicenseUserList',2)
			WITH
			(
            [LoginId] bigint ,
			 [ActivationCode] nvarchar(max)
            )tmp 

			select * from #tempLicenseInfo
			select * from #tempIndividualLicenseUserList

			INSERT INTO [LicenseInfo] ( [CustomerCode], 
			[ProductCode], 
			[ActivationCode], 
			[FromDate], 
			[ToDate], 
			[UserTypeCode], 
			[NoOfUsers], 
			[LicenseType], 
			[IPAddress] ) 
			SELECT 
			#tempLicenseInfo.[CustomerCode],
        	#tempLicenseInfo.[ProductCode],
        	#tempLicenseInfo.[ActivationCode],
        	#tempLicenseInfo.[FromDate],
        	#tempLicenseInfo.[ToDate],
        	#tempLicenseInfo.[UserTypeCode],
        	#tempLicenseInfo.[NoOfUsers],
        	#tempLicenseInfo.[LicenseType],
        	#tempLicenseInfo.[IPAddress]
			from #tempLicenseInfo  

			 DECLARE @LicenseId bigint
	    SET @LicenseId = @@IDENTITY

		DECLARE @Type bigint
	    SET @Type = (select #tempLicenseInfo.Type from #tempLicenseInfo  )

		IF(@Type != 1)
		BEGIN
		update  Login   set 
		ActivationCode=#tempIndividualLicenseUserList.ActivationCode
		from    #tempIndividualLicenseUserList  
			 where Login.LoginId  =  #tempIndividualLicenseUserList.LoginId
		END
  --      INSERT INTO	[LicenseInfo]
  --      (
  --      	[CustomerCode], 
		--	[ProductCode], 
		--	[ActivationCode], 
		--	[FromDate], 
		--	[ToDate], 
		--	[UserTypeCode], 
		--	[NoOfUsers], 
		--	[LicenseType], 
		--	[IPAddress]
  --      )
  --      SELECT
  --      	tmp.[CustomerCode],
  --      	tmp.[ProductCode],
  --      	tmp.[ActivationCode],
  --      	tmp.[FromDate],
  --      	tmp.[ToDate],
  --      	tmp.[UserTypeCode],
  --      	tmp.[NoOfUsers],
  --      	tmp.[LicenseType],
  --      	tmp.[IPAddress]
		--FROM OPENXML(@intpointer,'Json/LicenseInfoList',2)
  --      WITH
  --      (
  --          [CustomerCode] nvarchar(100),
  --          [ProductCode] nvarchar(100),
  --          [ActivationCode] nvarchar(max),
  --          [FromDate] datetime, 
		--	[ToDate] datetime, 
		--	[UserTypeCode] nvarchar(100),
		--	[NoOfUsers] nvarchar(100), 
		--	[LicenseType] nvarchar(100), 
		--	[IPAddress] nvarchar(100)
  --      )tmp
        
  --      DECLARE @LicenseId bigint
	 --   --SET @LicenseId = @@IDENTITY
        
        --Add child table insert procedure when required.

    
  		SELECT @LicenseId as LicenseInfoId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
