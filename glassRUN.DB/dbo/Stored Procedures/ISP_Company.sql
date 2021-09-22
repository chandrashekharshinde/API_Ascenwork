
CREATE PROCEDURE [dbo].[ISP_Company] 
  --'NSaveEventContent0162This is  Test Foe the EmailBCC3717eb8c-62b6-405c-ad8a-8ce36feb2e8801621AdminBCCBCC18018')  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @CompanyId BIGINT 
	  DECLARE @companymnemonic NVARCHAR(100) ;
      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 




			SELECT @companymnemonic = tmp.[CompanyMnemonic]
	  
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			 [CompanyMnemonic] NVARCHAR(100)
			
			)tmp ;
			if not exists(select 1 from [Company] where [CompanyMnemonic] = @companymnemonic and IsActive=1)
			BEGIN
          INSERT INTO [dbo].[company] 
                      ([companyname], 
                       [companymnemonic], 
                       [companytype], 
                       [parentcompany], 
                       [addressline1], 
                       [addressline2], 
                       [addressline3], 
                       [city], 
                       [state], 
                       [countryid], 
                       [country], 
                       [postcode], 
                       [region], 
                       [routecode], 
                       [zonecode], 
                       [categorycode], 
                       [branchplant], 
                       [email], 
                       [taxid], 
                       [siteurl], 
                       [contactpersonnumber], 
                       [contactpersonname], 
                       [logo], 
                       [createdby], 
                       [createddate], 
                       [isactive], 
                       [subchannel], 
                       [field1], 
                       [field2], 
                       [field3], 
                       [field4], 
                       [field5], 
                       [field6], 
                       [field7], 
                       [field8], 
                       [field9], 
                       [field10], 
                       [creditlimit], 
                       [availablecreditlimit], 
                       [emptieslimit], 
                       [actualempties], 
                       [paymenttermcode]) 
          SELECT tmp.[CompanyName], 
                 tmp.[companymnemonic], 
                 tmp.[companytype], 
                 tmp.[parentcompany], 
                 tmp.[addressline1], 
                 tmp.[addressline2], 
                 tmp.[addressline3], 
                 tmp.[city], 
                 tmp.[state], 
                 0, 
                 tmp.[country], 
                 tmp.[PostCode], 
                 tmp.[region], 
                 tmp.[routecode], 
                 tmp.[zonecode], 
                 tmp.[categorycode], 
                 tmp.[branchplant], 
                 tmp.[email], 
                 tmp.[taxid], 
                 tmp.[SiteUrl], 
                 tmp.[contactpersonnumber], 
                 tmp.[contactpersonname], 
                 tmp.[Logo], 
                 tmp.[createdby], 
                 Getdate(), 
                 tmp.[isactive], 
                 tmp.[subchannel], 
                 tmp.[field1], 
                 tmp.[field2], 
                 tmp.[field3], 
                 tmp.[field4], 
                 tmp.[field5], 
                 tmp.[field6], 
                 tmp.[field7], 
                 tmp.[field8], 
                 tmp.[field9], 
                 tmp.[field10], 
                 tmp.[creditlimit], 
                 tmp.[availablecreditlimit], 
                 tmp.[emptieslimit], 
                 tmp.[ActualEmpties], 
                 tmp.[paymenttermcode] 
          FROM   OPENXML(@intpointer, 'Json', 2) 
                    WITH ( [CompanyName]         NVARCHAR(500), 
                           [CompanyMnemonic]     NVARCHAR(200), 
                           [CompanyType]         NVARCHAR(50), 
                           [ParentCompany]       BIGINT, 
                           [AddressLine1]        NVARCHAR(max), 
                           [AddressLine2]        NVARCHAR(max), 
                           [AddressLine3]        NVARCHAR(max), 
                           [City]                NVARCHAR(100), 
                           [State]               NVARCHAR(100), 
                           [CountryId]           BIGINT, 
                           [Country]             NVARCHAR(50), 
                           [PostCode]            NVARCHAR(20), 
                           [Region]              NVARCHAR(20), 
                           [RouteCode]           NVARCHAR(20), 
                           [ZoneCode]            NVARCHAR(20), 
                           [CategoryCode]        NVARCHAR(20), 
                           [BranchPlant]         NVARCHAR(200), 
                           [Email]               NVARCHAR(max), 
                           [TaxId]               NVARCHAR(200), 
                           [SiteUrl]             NVARCHAR(200), 
                           [ContactPersonNumber] NVARCHAR(20), 
                           [ContactPersonName]   NVARCHAR(500), 
                           [Logo]                NVARCHAR(max), 
                           [CreatedBy]           BIGINT, 
                           [IsActive]            BIT, 
                           [SubChannel]          NVARCHAR(50), 
                           [Field1]              NVARCHAR(500), 
                           [Field2]              NVARCHAR(500), 
                           [Field3]              NVARCHAR(500), 
                           [Field4]              NVARCHAR(500), 
                           [Field5]              NVARCHAR(500), 
                           [Field6]              NVARCHAR(500), 
                           [Field7]              NVARCHAR(500), 
                           [Field8]              NVARCHAR(500), 
                           [Field9]              NVARCHAR(500), 
                           [Field10]             NVARCHAR(500), 
                           [CreditLimit]         BIGINT, 
                           [AvailableCreditLimit]BIGINT, 
                           [EmptiesLimit]        BIGINT, 
                           [ActualEmpties]       BIGINT, 
                           [PaymentTermCode]     BIGINT )tmp 

          SET @CompanyId = @@IDENTITY 

		  
			select *  into #tmpDocumentInformationList
				FROM OPENXML(@intpointer,'Json/DocumentInformationList',2)
				WITH
				(
					[DocumentType] nvarchar(250),
					[DocumentTypeId] bigint,
					[DocumentName] nvarchar(250),
					[DocumentExtension] nvarchar(250),
					[DocumentBase64] nvarchar(max),
					[ObjectType] nvarchar(250)
				)tmp

          INSERT INTO [zonecode] 
                      ([companyid], 
                       [zonecode], 
                       [zonename], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @CompanyId, 
                 tmp1.[zonecode], 
                 tmp1.[zonename], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/ZonCodeList', 2) 
                    WITH ( [CompanyId] BIGINT, 
                           [ZoneCode]  NVARCHAR(max), 
                           [ZoneName]  NVARCHAR(max), 
                           [IsActive]  BIT, 
                           [CreatedBy] BIGINT )tmp1 

          INSERT INTO [companybranchplant] 
                      ([companyid], 
                       [branchplantid], 
                       [locationname], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @CompanyId, 
                 tmp1.[branchplantid], 
                 tmp1.[locationname], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/CompanyBranchPlantList', 2) 
                    WITH ( [CompanyId]    BIGINT, 
                           [BranchPlantId]NVARCHAR(max), 
                           [LocationName] NVARCHAR(max), 
                           [IsActive]     BIT, 
                           [CreatedBy]    BIGINT )tmp1 

          INSERT INTO [companyproducttype] 
                      ([companyid], 
					   [ProductTypeCode],
                       [producttypename], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @CompanyId, 
		         tmp1.[ProductTypeCode],
                 tmp1.[producttypename], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/CompanyProductTypeList', 2) 
                    WITH ( [CompanyId]      BIGINT, 
					       [ProductTypeCode] NVARCHAR(MAX),
                           [ProductTypeName]NVARCHAR(max), 
                           [IsActive]       BIT, 
                           [CreatedBy]      BIGINT )tmp1 

          INSERT INTO [contactinformation] 
                      ([objectid], 
                       [objecttype], 
                       [contacttype], 
                       [contactperson], 
                       [contacts], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @CompanyId, 
                 tmp1.[objecttype], 
                 tmp1.[contacttype], 
                 tmp1.[ContactPersonName], 
                 tmp1.[ContactPersonNumber], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/ContactInformationList', 2) 
                    WITH ( [ObjectType]    NVARCHAR(max), 
                           [ContactType]   NVARCHAR(max), 
                           [ContactPersonName] NVARCHAR(max), 
                           [ContactPersonNumber]      NVARCHAR(max), 
                           [IsActive]      BIT, 
                           [CreatedBy]     BIGINT )tmp1 

          INSERT INTO [transporteraccountdetail] 
                      ([ObjectId],
					   [ObjectType],
					   [AccountName],
                       [bankname], 
                       [accountnumber], 
                       [accounttypeid], 
                       [accounttype], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @CompanyId,
		          'Company',
                 [AccountName],
				 [BankName],  
                 [accountnumber], 
                 [AccountTypeId], 
                 [accounttype], 
                 [isactive], 
                 [createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/TransporterAccountDetailList', 2) 
                    WITH ( [AccountName]      NVARCHAR(max),
				       	   [BankName]      NVARCHAR(max), 
                           [AccountNumber] NVARCHAR(max), 
                           [AccountTypeId] BIGINT, 
                           [AccountType]   NVARCHAR(max), 
                           [IsActive]      BIT, 
                           [CreatedBy]     BIGINT )tmp1 

				INSERT INTO [LocationAndProductCategoryMapping] 
					([ObjectId],
					[ObjectType],
					[ProductCategoryId], 
					[Isactive], 
					[createdby], 
					[createddate]) 
					SELECT @CompanyId,
					'Company',
					[ProductCategoryId], 
					[isactive], 
					[createdby], 
					Getdate() 
				FROM   OPENXML(@intpointer, 'Json/ProductCategoryList', 2) 
				WITH ([ProductCategoryId]      NVARCHAR(max), 
					  [IsActive]      BIT, 
					  [CreatedBy]     BIGINT )tmp1 







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
        	tmp.TransporterId,
        	@CompanyId,
        	tmp.[Amount],
			Convert(datetime, tmp.[FromDate], 103),
			Convert(datetime, tmp.[ToDate], 103),        				
			1,
			GETDATE(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/TransporterFinanceMappingList',2)
			WITH
        (
            [TransporterId] bigint,
            [FinancePartnerId] bigint,
            [Amount] decimal(18,2),
            [FromDate]  nvarchar(100),
			[ToDate]  nvarchar(100),	
			[CreatedBy] bigint,
			[CreatedDate] datetime,
		    [IsActive] BIT
        )tmp


		 INSERT INTO [dbo].[Documents] ([DocumentName] ,[DocumentExtension] ,[DocumentBase64] ,[ObjectId] ,[ObjectType] ,[IsActive] ,[CreatedBy] ,[CreatedDate],[DocumentTypeId])
		   select #tmpDocumentInformationList.[DocumentName]   , #tmpDocumentInformationList.[DocumentExtension],
		   #tmpDocumentInformationList.[DocumentBase64],@CompanyId,
		   'Company',1 ,1,GETDATE(),  #tmpDocumentInformationList.[DocumentTypeId]from    #tmpDocumentInformationList     where  @CompanyId is not null 



          SELECT @CompanyId AS CompanyId 
          FOR xml raw('Json'), elements 

          EXEC Sp_xml_removedocument 
            @intPointer 
			 end
	else
	begin
	    set @CompanyId=-1;	

		SELECT @CompanyId as CompanyId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer
    end;
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END