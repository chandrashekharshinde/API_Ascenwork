-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_Location] --'<Json><ServicesAction>InsertLocation</ServicesAction><LocationList><LocationId>0</LocationId><LocationName>Test11</LocationName><DeliveryName>Test11</DeliveryName><DeliveryLocationCode></DeliveryLocationCode><DisplayName></DisplayName><LocationCode></LocationCode><LocationCodeAutomated>true</LocationCodeAutomated><LocationType>27</LocationType><AddressLine1>sss</AddressLine1><AddressLine2></AddressLine2><AddressLine3></AddressLine3><AddressLine4></AddressLine4><CompanyID>1483</CompanyID><City>Singapore</City><State>Singapore</State><PostCode>440011</PostCode><Capacity></Capacity><Safefill></Safefill><Field1></Field1><Field2></Field2><Field3></Field3><Field4></Field4><Field5></Field5><Field6></Field6><Field7></Field7><Field8></Field8><Field9></Field9><Field10></Field10><WMSBranchPlantCode></WMSBranchPlantCode><WareHouseType>0</WareHouseType><IsActive>true</IsActive><CreatedBy>409</CreatedBy></LocationList></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max) 
	DECLARE @ErrMsg NVARCHAR(max) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	--DECLARE @LocationId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc



		


        INSERT INTO	[Location]
        (
        	[LocationName],
			[DisplayName],
			[LocationCode],
			[CompanyID],
			[LocationType],	
        	[AddressLine1],
        	[AddressLine2],
        	[AddressLine3],
			[AddressLine4],
      	[City],
        	[State],        	
        	[Pincode],
			
			[CreatedBy],
			[CreatedDate],
        	[IsActive],
			--[Capacity],
			--[Safefill]
			[Field1],
			[Field2],
			[Field3],
			[Field4],
			[Field5],
			[Field6],
			[Field7],
			[Field8],
			[Field9],
			[Field10]
			--[WMSBranchPlantCode],
   --         [WareHouseType]
        	
        )

        SELECT
        	tmp.[LocationName],
        	tmp.[DisplayName],
			tmp.[LocationCode],
			tmp.[CompanyID],
			tmp.[LocationType],
			tmp.[AddressLine1],
        	tmp.[AddressLine2],
        	tmp.[AddressLine3],
			tmp.[AddressLine4],
        	tmp.[City],
        	tmp.[State],        	
        	tmp.[PostCode],
			1,
			GETDATE(),	
			tmp.[IsActive],
			--tmp.[Capacity],
			--tmp.[Safefill]
			tmp.[Field1],
			tmp.[Field2],
			tmp.[Field3],
			tmp.[Field4],
			tmp.[Field5],
			tmp.[Field6],
			tmp.[Field7],
			tmp.[Field8],
			tmp.[Field9],
			tmp.[Field10]
			--tmp.[WMSBranchPlantCode],
   --         tmp.[WareHouseType]
            FROM OPENXML(@intpointer,'Json/LocationList',2)
        WITH
        (
            [LocationName] nvarchar(500),
			[DisplayName] nvarchar(150),
			[LocationCode] nvarchar(150),
			[CompanyID] bigint,
			[LocationType] bigint,
            [AddressLine1] nvarchar(max),
			[AddressLine2] nvarchar(max),
			[AddressLine3] nvarchar(max),
			[AddressLine4] nvarchar(max),
            [City] nvarchar(100),
            [State] nvarchar(100),           
           PostCode nvarchar(200), 
			[CreatedBy] bigint,
			[CreatedDate] datetime      ,
            [IsActive] bit,
			--[Capacity] DECIMAL(10,2),
			--[Safefill]   DECIMAL(10,2)
			[Field1]   nvarchar(100),
			[Field2]   nvarchar(100),
			[Field3]   nvarchar(100),
			[Field4]   nvarchar(100),
			[Field5]   nvarchar(100),
			[Field6]   nvarchar(100),
			[Field7]   nvarchar(100),
			[Field8]   nvarchar(100),
			[Field9]   nvarchar(100),
			[Field10]  nvarchar(100)
			--[WMSBranchPlantCode] nvarchar(100),
   --         [WareHouseType] bigint
            
        )tmp
        
        DECLARE @LocationId bigint
	    SET @LocationId = @@IDENTITY
		SELECT * INTO #tmpLocation  FROM OPENXML(@intpointer,'Json/LocationList',2)
        WITH
        (
            LocationCodeAutomated nvarchar(500)
			
            
        )tmp


		Declare @automatedLocationCodeCheck nvarchar(20)
		Declare @automatedLocationCode nvarchar(20)
		SET @automatedLocationCodeCheck=(Select LocationCodeAutomated from #tmpLocation)
		If @automatedLocationCodeCheck='true'
		Begin

			update Location set LocationCode=@LocationId where LocationId=@LocationId
		End
		Print @automatedLocationCodeCheck


		INSERT INTO [contactinformation] 
                      ([objectid], 
                       [objecttype], 
                       [contacttype], 
                       [contactperson], 
                       [contacts], 
                       [isactive], 
                       [createdby], 
                       [createddate]) 
          SELECT @LocationId, 
                 tmp1.[objecttype], 
                 tmp1.[contacttype], 
                 tmp1.[ContactPersonName], 
                 tmp1.[ContactPersonNumber], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/LocationList/ContactInformationList', 2) 
                    WITH ( [ObjectType]    NVARCHAR(max), 
                           [ContactType]   NVARCHAR(max), 
                           [ContactPersonName] NVARCHAR(max), 
                           [ContactPersonNumber]      NVARCHAR(max), 
                           [IsActive]      BIT, 
                           [CreatedBy]     BIGINT )tmp1 



  --      SELECT @EmailContent as EmailContent FOR XML RAW('Json'),ELEMENTS
		--SET @EmailEventId=(SELECT EmailEventId FROM dbo.EmailContent WHERE EmailContentId=@EmailContent)


		--INSERT INTO [dbo].[ContactInformation]
  --         ([ObjectId]
  --         ,[ObjectType]
  --         ,[ContactType]
  --         ,[ContactPerson]
		--   ,[Contacts]
		--   ,[Purpose]
		--   ,[CreatedBy]
		--   ,[CreatedDate]
		--   ,[IsActive])
  --   SELECT
  --      	@FinancePatnerId,
  --      	'FinancePatner',
  --      	tmp.[ContactType],
  --      	tmp.[ContactPersonName],
		--	tmp.[ContactPersonNumber],
		--	NULL,
		--	1,
		--	GETDATE(),
		--	tmp.[IsActive]
  --          FROM OPENXML(@intpointer,'Json/FinancePartnerList/ContactPersonList',2)
		--	WITH
  --      (
  --          [ObjectId] bigint,
  --          [ObjectType] nvarchar(50),
  --          [ContactType] nvarchar(500),
  --          [ContactPersonName] nvarchar(100),
		--	[ContactPersonNumber] nvarchar(250),
		--	[Purpose] nvarchar(50),
		--	[CreatedBy] bigint,
		--	[CreatedDate] datetime,
		--   [IsActive] BIT
  --      )tmp


  SELECT  LocationId, LocationId as [DeliveryLocationId] ,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [DeliveryLocationName]
	  ,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [Name],ISNULL(DisplayName,'') as DisplayName,[LocationName] as DeliveryName
      ,[LocationCode] as DeliveryLocationCode,0 as [AvailableDeliveryLocationCapacity],0 as DeliveryUsedCapacity,[CompanyID],[Area] ,[AddressLine1]
      ,[AddressLine2],[AddressLine3],[AddressLine4],[City],[State],[Pincode],[Country],[Email],[Parentid],[Capacity],[Safefill],[ProductCode]
      ,[Description],[Remarks],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[IsActive],[SequenceNo]
  FROM [Location] WHERE IsActive = 1  and LocationId=@LocationId
  FOR XML RAW('Json'),ELEMENTS


         --SELECT @LocationId as LocationId FOR XML RAW('Json'),ELEMENTS
			

    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END