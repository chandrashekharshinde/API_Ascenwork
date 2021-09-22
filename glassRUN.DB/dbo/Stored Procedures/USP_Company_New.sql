CREATE PROCEDURE [dbo].[USP_Company_New]
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @CompanyId BIGINT 

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
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

          UPDATE [dbo].[company] 
          SET    @CompanyId = tmp.[companyid], 
                 [companyname] = tmp.[companyname], 
                 [companymnemonic] = tmp.[companymnemonic], 
                 [companytype] = tmp.[companytype], 
                 [parentcompany] = tmp.[parentcompany], 
                 [addressline1] = tmp.[addressline1], 
                 [addressline2] = tmp.[addressline2], 
                 [addressline3] = tmp.[addressline3], 
                 [city] = tmp.[city], 
                 [state] = tmp.[state], 
                 [countryid] = 0, 
                 [country] = tmp.[country], 
                 [postcode] = tmp.[PostCode], 
                 [region] = tmp.[region], 
                 [routecode] = tmp.[routecode], 
                 [zonecode] = tmp.[zonecode], 
                 [categorycode] = tmp.[categorycode], 
                 [branchplant] = tmp.[branchplant], 
                 [email] = tmp.[email], 
                 [taxid] = tmp.[taxid], 
                 [siteurl] = tmp.[SiteUrl], 
                 [contactpersonnumber] = tmp.[contactpersonnumber], 
                 [contactpersonname] = tmp.[contactpersonname], 
                 [logo] = tmp.[Logo], 
                 [modifiedby] = tmp.[createdby], 
                 [modifieddate] = Getdate(), 
                 [isactive] = tmp.[isactive], 
                 [subchannel] = tmp.[subchannel], 
                 [field1] = tmp.[field1], 
                 [field2] = tmp.[field2], 
                 [field3] = tmp.[field3], 
                 [field4] = tmp.[field4], 
                 [field5] = tmp.[field5], 
                 [field6] = tmp.[field6], 
                 [field7] = tmp.[field7], 
                 [field8] = tmp.[field8], 
                 [field9] = tmp.[field9], 
                 [field10] = tmp.[field10], 
                 [creditlimit] = tmp.[creditlimit], 
                 [availablecreditlimit] = tmp.[availablecreditlimit], 
                 [emptieslimit] = tmp.[emptieslimit], 
                 [actualempties] = tmp.[ActualEmpties],
                [paymenttermcode] = tmp.[paymenttermcode] 
				
         FROM   OPENXML(@intpointer, 'Json', 2) 
                    WITH ( [CompanyId]           BIGINT, 
                           [CompanyName]         NVARCHAR(500), 
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
                           [PaymentTermCode]     NVARCHAR(500)
						   
						    )tmp  WHERE company.[CompanyId]=tmp.[CompanyId]

          DELETE FROM [zonecode] 
          WHERE  companyid = @CompanyId 

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

          DELETE FROM [companybranchplant] 
          WHERE  companyid = @CompanyId 

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

          DELETE FROM [companyproducttype] 
          WHERE  companyid = @CompanyId 

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
				           [ProductTypeCode]NVARCHAR(MAX),
                           [ProductTypeName]NVARCHAR(max), 
                           [IsActive]       BIT, 
                           [CreatedBy]      BIGINT )tmp1 

          DELETE FROM [contactinformation] 
          WHERE  objectid = @CompanyId 
                 AND objecttype = 'Company' 

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
                 tmp1.[contactpersonname], 
                 tmp1.[contactpersonnumber], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/ContactInformationList', 2) 
                    WITH ( [ObjectType]          NVARCHAR(max), 
                           [ContactType]         NVARCHAR(max), 
                           [ContactPersonName]   NVARCHAR(max), 
                           [ContactPersonNumber] NVARCHAR(max), 
                           [IsActive]            BIT, 
                           [CreatedBy]           BIGINT )tmp1 

          DELETE FROM [transporteraccountdetail] 
          WHERE  objectid = @CompanyId 

          INSERT INTO [transporteraccountdetail] 
                      ([objectid],
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
                 [accounttypeid], 
                 [accounttype], 
                 [isactive], 
                 [createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/TransporterAccountDetailList', 2) 
                    WITH ( [AccountName]     NVARCHAR(max),
					       [BankName] NVARCHAR(max),
                           [AccountNumber] NVARCHAR(max), 
                           [AccountTypeId] BIGINT, 
                           [AccountType]   NVARCHAR(max), 
                           [IsActive]      BIT, 
                           [CreatedBy]     BIGINT )tmp1 
		  
		

		    
		   DELETE FROM [FinanceTransporterMapping] 
           WHERE  FinancePartnerId = @CompanyId-- and ObjectType='Company'

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

	    DELETE FROM [LocationAndProductCategoryMapping] 
        WHERE  objectid = @CompanyId and ObjectType='Company'
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

        DELETE FROM [Documents] 
        WHERE  objectid = @CompanyId and ObjectType='Company'

		INSERT INTO [dbo].[Documents]
		([DocumentName] ,
		[DocumentExtension] ,
		[DocumentBase64] ,
		[ObjectId] ,
		[ObjectType] ,
		[IsActive] ,
		[CreatedBy] ,
		[CreatedDate],
		[DocumentTypeId])
		select #tmpDocumentInformationList.[DocumentName]   ,
		#tmpDocumentInformationList.[DocumentExtension],
		#tmpDocumentInformationList.[DocumentBase64],
		@CompanyId,
		--#tmpDocumentInformationList.[ObjectType],
		'Company',
		1 ,1,GETDATE(), 
		#tmpDocumentInformationList.[DocumentTypeId]
		from #tmpDocumentInformationList   
		where @CompanyId is not null 
          SELECT @CompanyId AS CompanyId 
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