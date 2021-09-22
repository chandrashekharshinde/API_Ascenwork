-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_FinancePatner]-- '<Json><ServicesAction>InsertFinancePartner</ServicesAction><FinancePartnerList><FinancePartnerId>0</FinancePartnerId><FinancerName>test</FinancerName><AddressLine1>add1</AddressLine1><AddressLine2>add2</AddressLine2><AddressLine3>add3</AddressLine3><State>0</State><City>0</City><Postcode>343434</Postcode><IsActive>true</IsActive><ContactPersonList><ContactinfoGUID>977a6479-63b6-4a0d-8c66-a5dda2101f3e</ContactinfoGUID><Email>Email</Email><ContactPersonName>ghjghj</ContactPersonName><ContactPersonNumber>ghj</ContactPersonNumber><IsActive>true</IsActive></ContactPersonList><TransporterAccountDetailsList><AccountdetailGUID>7eb2876f-d1a2-40e4-b8e7-f26402494adb</AccountdetailGUID><AccountNumber>7467567</AccountNumber><AccountType>Savings</AccountType><AccountName>tyuytu</AccountName><IsActive>true</IsActive></TransporterAccountDetailsList></FinancePartnerList></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max) 
	DECLARE @ErrMsg NVARCHAR(max) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	--DECLARE @FinancePatnerId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        INSERT INTO	[FinancePatner]
        (
        	[FinancerName],
        	[AddressLine1],
        	[AddressLine2],
        	[AddressLine3],
        	[City],
        	[State],
        	[CountryId],
        	[Country],
        	[Postcode],
			[CreatedBy],
			[CreatedDate],
        	[IsActive]
        	
			
        )

        SELECT
        	tmp.[FinancerName],
        	tmp.[AddressLine1],
        	tmp.[AddressLine2],
        	tmp.[AddressLine3],
        	tmp.[City],
        	tmp.[State],
        	tmp.[CountryId],
        	tmp.[Country],
        	tmp.[Postcode],
			1,
			GETDATE(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/FinancePartnerList',2)
        WITH
        (
            [FinancerName] nvarchar(150),
            [AddressLine1] nvarchar(max),
			[AddressLine2] nvarchar(max),
			[AddressLine3] nvarchar(max),
            [City] nvarchar(100),
            [State] nvarchar(100),
            [CountryId] bigint,
            [Country] nvarchar(50),
            Postcode nvarchar(200), 
			[CreatedBy] bigint,
			[CreatedDate] datetime,           
            [IsActive] bit
            
        )tmp
        
        DECLARE @FinancePatnerId bigint
	    SET @FinancePatnerId = @@IDENTITY
  --      SELECT @EmailContent as EmailContent FOR XML RAW('Json'),ELEMENTS
		--SET @EmailEventId=(SELECT EmailEventId FROM dbo.EmailContent WHERE EmailContentId=@EmailContent)


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
        	tmp.[ContactType],
        	tmp.[ContactPersonName],
			tmp.[ContactPersonNumber],
			NULL,
			1,
			GETDATE(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/FinancePartnerList/ContactPersonList',2)
			WITH
        (
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
        	tmp.[AccountName],
        	tmp.[AccountNumber],
			tmp.[AccountTypeId],
			tmp.[AccountType],			
			1,
			GETDATE(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/FinancePartnerList/TransporterAccountDetailsList',2)
			WITH
        (
            [ObjectId] bigint,
            [ObjectType] nvarchar(50),
            [AccountName] nvarchar(500),
            [AccountNumber] nvarchar(100),
			[AccountTypeId] bigint,
			[AccountType] nvarchar(100),
			[CreatedBy] bigint,
			[CreatedDate] datetime,
		    [IsActive] BIT
        )tmp



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
        	@FinancePatnerId,
        	tmp.[Amount],
			Convert(datetime, tmp.[FromDate], 103),
			Convert(datetime, tmp.[ToDate], 103),        				
			1,
			GETDATE(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/FinancePartnerList/FinanceTransporterMappingList',2)
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



		 DECLARE @TransporterAccountDetail bigint
	    SET @TransporterAccountDetail = @@IDENTITY



         --SELECT @EmailRecepient as EmailRecepient FOR XML RAW('Json'),ELEMENTS
			

    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
