CREATE PROCEDURE [dbo].[USP_FinancePartner] --'<Json><ServicesAction>InsertFinancePartner</ServicesAction><FinancePartnerList><FinancePartnerId>4</FinancePartnerId><FinancerName>test11111</FinancerName><AddressLine1>add1</AddressLine1><AddressLine2>add2</AddressLine2><AddressLine3>add3</AddressLine3><State>1</State><City>1</City><CreatedBy>8</CreatedBy><IsActive>true</IsActive><ContactPersonList><ContactInformationId>3</ContactInformationId><ObjectId>4</ObjectId><ObjectType>FinancePatner</ObjectType><Email>Email</Email><ContactPersonName>test1</ContactPersonName><ContactPersonNumber>1234556</ContactPersonNumber><CreatedBy>1</CreatedBy><CreatedDate>2019-01-15T13:39:50.727</CreatedDate><IsActive>1</IsActive></ContactPersonList><TransporterAccountDetailsList><AccountdetailGUID>fc5cfaf7-918a-47d8-b672-442f0c7b56c2</AccountdetailGUID><TransporterAccountDetailId>0</TransporterAccountDetailId><AccountNumber>1234</AccountNumber><AccountType>Savings</AccountType><AccountName>test</AccountName><IsActive>true</IsActive><CreatedBy>8</CreatedBy></TransporterAccountDetailsList><FinanceTransporterMappingList><TransporterFinanceGUID>0b8d942a-31e6-415d-90a0-3437e8936323</TransporterFinanceGUID><FinanceTransporterMappingId>0</FinanceTransporterMappingId><Transporter>CTY TNHH QUYET THANG</Transporter><TransporterId>1222</TransporterId><Amount>200</Amount><FromDate>16/01/2019</FromDate><ToDate>16/01/2019</ToDate><IsActive>true</IsActive><CreatedBy>8</CreatedBy></FinanceTransporterMappingList></FinancePartnerList></Json>'

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
            DECLARE @FinancePatnerId bigint
            UPDATE dbo.FinancePatner SET
			@FinancePatnerId=tmp.FinancePartnerId,
        	[FinancerName]=tmp.FinancerName ,
        	[AddressLine1]=tmp.AddressLine1 ,        	
        	[AddressLine2]=tmp.AddressLine2   ,  
			[AddressLine3]=tmp.AddressLine3  ,   
			[City]=tmp.City   ,  
			[State]=tmp.State   , 
			Postcode=tmp.Postcode,
			ModifiedBy=1	,
			ModifiedDate=GETDATE()
        	
            FROM OPENXML(@intpointer,'Json/FinancePartnerList',2)
			WITH
			(
            [FinancePartnerId] bigint,           
            [FinancerName] nvarchar(500),     
			 [AddressLine1] nvarchar(500),     
			  [AddressLine2] nvarchar(500),     
			   [AddressLine3] nvarchar(500),           
            [City] nvarchar(50),
			[State] nvarchar(50),
            [PrimaryUnitOfMeasure] nvarchar(20),
			Postcode nvarchar(50)
            )tmp WHERE FinancePatner.[FinancePatnerId]=tmp.[FinancePartnerId]


			  select * into #tmpTransporterAccountDetailList
    FROM OPENXML(@intpointer,'Json/FinancePartnerList/TransporterAccountDetailsList',2)
        WITH
        (
		TransporterAccountDetailId bigint,
		[ObjectId] bigint,
		[ObjectType] nvarchar(50),
		AccountName nvarchar(500),
		[AccountNumber] nvarchar(50),
		[AccountTypeId] nvarchar(500),
		[AccountType] nvarchar(50),
		[CreatedBy] bigint,
		[CreatedDate] datetime,
		[IsActive] BIT
			
        )tmp





	update TransporterAccountDetail set IsActive = 0 where ObjectId = @FinancePatnerId and ObjectType='FinancePatner'


	 UPDATE dbo.TransporterAccountDetail SET dbo.TransporterAccountDetail.IsActive=#tmpTransporterAccountDetailList.IsActive
	 ,dbo.TransporterAccountDetail.BankName=#tmpTransporterAccountDetailList.AccountName
	 ,dbo.TransporterAccountDetail.AccountNumber=#tmpTransporterAccountDetailList.AccountNumber
	 ,dbo.TransporterAccountDetail.AccountType=#tmpTransporterAccountDetailList.AccountType
	 FROM #tmpTransporterAccountDetailList WHERE dbo.TransporterAccountDetail.TransporterAccountDetailId=#tmpTransporterAccountDetailList.TransporterAccountDetailId



	 	INSERT INTO [dbo].[TransporterAccountDetail]
           ([ObjectId]
           ,[ObjectType]
           ,[BankName]
           ,[AccountNumber]
		   ,[AccountTypeId]
		   ,[AccountType]
		   ,[CreatedBy]
		   ,[CreatedDate]
		   ,[IsActive])
     SELECT
        	@FinancePatnerId,
        	'FinancePatner',
        	#tmpTransporterAccountDetailList.[AccountName],
        	#tmpTransporterAccountDetailList.[AccountNumber],
			#tmpTransporterAccountDetailList.[AccountTypeId],
			#tmpTransporterAccountDetailList.[AccountType],			
			1,
			GETDATE(),
			#tmpTransporterAccountDetailList.[IsActive]
			 FROM #tmpTransporterAccountDetailList
           where #tmpTransporterAccountDetailList.TransporterAccountDetailId=0




		    select * into #tmpContactPersonList
    FROM OPENXML(@intpointer,'Json/FinancePartnerList/ContactPersonList',2)
        WITH
        (
		ContactInformationId bigint,
		[ObjectId] bigint,
            [ObjectType] nvarchar(50),
            [ContactType] nvarchar(500),
            [ContactPersonName] nvarchar(100),
			[ContactPersonNumber] nvarchar(250),
			[Purpose] nvarchar(50),
			[CreatedBy] bigint,
			[CreatedDate] datetime,
		   [IsActive] BIT
			
        )tmp



	update ContactInformation set IsActive = 0 where ObjectId = @FinancePatnerId and ObjectType='FinancePatner'


	 UPDATE dbo.ContactInformation SET dbo.ContactInformation.IsActive=#tmpContactPersonList.IsActive
	 ,dbo.ContactInformation.ContactType=#tmpContactPersonList.ContactType
	 ,dbo.ContactInformation.ContactPerson=#tmpContactPersonList.ContactPersonName
	 ,dbo.ContactInformation.Contacts=#tmpContactPersonList.ContactPersonNumber
	 FROM #tmpContactPersonList WHERE dbo.ContactInformation.ContactInformationId=#tmpContactPersonList.ContactInformationId


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
     SELECT
        	@FinancePatnerId,
        	'FinancePatner',
        	#tmpContactPersonList.[ContactType],
        	#tmpContactPersonList.[ContactPersonName],
			#tmpContactPersonList.[ContactPersonNumber],
			NULL,
			1,
			GETDATE(),
			#tmpContactPersonList.[IsActive]
           from #tmpContactPersonList
		   where #tmpContactPersonList.ContactInformationId=0




		   	    select * into #tmpFinanceTransporterMappingList
    FROM OPENXML(@intpointer,'Json/FinancePartnerList/FinanceTransporterMappingList',2)
        WITH
        (
		FinanceTransporterMappingId bigint,
		 [TransporterId] bigint,
            [FinancePartnerId] bigint,
            [Amount] decimal(18,2),
            [FromDate] nvarchar(100),
			[ToDate] nvarchar(100),			
			[CreatedBy] bigint,
			[CreatedDate] datetime,
		    [IsActive] BIT
			
        )tmp
		--select * from #tmpFinanceTransporterMappingList


	update FinanceTransporterMapping set IsActive = 0 where FinancePartnerId = @FinancePatnerId 


	 UPDATE dbo.FinanceTransporterMapping SET dbo.FinanceTransporterMapping.IsActive=#tmpFinanceTransporterMappingList.IsActive
	 ,dbo.FinanceTransporterMapping.[Amount]=#tmpFinanceTransporterMappingList.[Amount]
	 ,dbo.FinanceTransporterMapping.[FromDate]= Convert(datetime, #tmpFinanceTransporterMappingList.[FromDate], 103)
	 ,dbo.FinanceTransporterMapping.[ToDate]=Convert(datetime, #tmpFinanceTransporterMappingList.[ToDate], 103)
	 FROM #tmpFinanceTransporterMappingList WHERE dbo.FinanceTransporterMapping.FinanceTransporterMappingId=#tmpFinanceTransporterMappingList.FinanceTransporterMappingId


	 	INSERT INTO [dbo].[FinanceTransporterMapping]
           ([TransporterId]
           ,[FinancePartnerId]
           ,[Amount]
           ,[FromDate]
		   ,[ToDate]		 
		   ,[CreatedBy]
		   ,[CreatedDate]
		   ,[IsActive])
     SELECT
        	#tmpFinanceTransporterMappingList.TransporterId,
        	@FinancePatnerId,
			#tmpFinanceTransporterMappingList.[Amount],
        	Convert(datetime, #tmpFinanceTransporterMappingList.[FromDate], 103),
        	Convert(datetime, #tmpFinanceTransporterMappingList.[ToDate], 103),       					
			1,
			GETDATE(),
			#tmpFinanceTransporterMappingList.[IsActive]           
		    from #tmpFinanceTransporterMappingList
		   where #tmpFinanceTransporterMappingList.FinanceTransporterMappingId=0


             SELECT @FinancePatnerId as FinancePatnerId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
