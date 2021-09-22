CREATE PROCEDURE [dbo].[USP_Location] --'<Json><ServicesAction>InsertLocation</ServicesAction><LocationList><LocationId>10002</LocationId><LocationName>Test Location</LocationName><DeliveryName>Test Location</DeliveryName><DeliveryLocationCode>10002</DeliveryLocationCode><DisplayName>Test Location</DisplayName><LocationCode>10002</LocationCode><LocationCodeAutomated>true</LocationCodeAutomated><LocationType>21</LocationType><AddressLine1>Test</AddressLine1><AddressLine2>Test</AddressLine2><AddressLine3>Test</AddressLine3><AddressLine4 /><CompanyID>311</CompanyID><City>Singapore</City><State>Singapore</State><PostCode>401209</PostCode><Field1 /><Field2 /><Field3 /><Field4 /><Field5 /><Field6 /><Field7 /><Field8 /><Field9 /><Field10 /><IsActive>true</IsActive><CreatedBy>409</CreatedBy><ContactInformationList><ContactinfoGUID>119b2b7a-f2ef-4be4-ad78-923f89baaf9c</ContactinfoGUID><ContactType>MobileNo</ContactType><ContactTypeId>1282</ContactTypeId><ContactPersonName>Chetan</ContactPersonName><ContactPersonNumber>9970934892</ContactPersonNumber><ObjectType>Location</ObjectType><IsActive>true</IsActive><CreatedBy>409</CreatedBy></ContactInformationList></LocationList></Json>'

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
            DECLARE @LocationId bigint
            UPDATE dbo.Location SET
			@LocationId=tmp.LocationId,
			[LocationName]=tmp.LocationName ,
        	[DisplayName]=tmp.DisplayName ,
			LocationCode=tmp.LocationCode,
			CompanyID=tmp.CompanyID,
			[LocationType]=tmp.LocationType,
        	[AddressLine1]=tmp.AddressLine1,        	
        	[AddressLine2]=tmp.AddressLine2,  
			[AddressLine3]=tmp.AddressLine3,
			[AddressLine4]=tmp.AddressLine4,   
			[City]=tmp.City   ,  
			[State]=tmp.State   , 
			Pincode=tmp.PostCode,
			ModifiedBy=1	,
			ModifiedDate=GETDATE(),
        	[Capacity]=tmp.[Capacity],
			[Safefill]=tmp.[Safefill],
			[Field1]=tmp.[Field1],
			[Field2]=tmp.[Field2],
			[Field3]=tmp.[Field3],
			[Field4]=tmp.[Field4],
			[Field5]=tmp.[Field5],
			[Field6]=tmp.[Field6],
			[Field7]=tmp.[Field7],
			[Field8]=tmp.[Field8],
			[Field9]=tmp.[Field9],
			[Field10]=tmp.[Field10],
			[WMSBranchPlantCode]=tmp.[WMSBranchPlantCode],
			[WareHouseType]=tmp.[WareHouseType]
            FROM OPENXML(@intpointer,'Json/LocationList',2)
			WITH
			(
				[LocationId] bigint,           
				LocationName nvarchar(500),     
				DisplayName nvarchar(500),     
				LocationCode nvarchar(500),     
				CompanyID bigint,     
				LocationType bigint,
				AddressLine1 nvarchar(500),     
				AddressLine2 nvarchar(500),     
				AddressLine3 nvarchar(500),     
				AddressLine4 nvarchar(500),     
				[City] nvarchar(50),
				[State] nvarchar(50),            
				PostCode nvarchar(50),
				[Capacity] DECIMAL(10,2),
				[Safefill]   DECIMAL(10,2),
				[Field1]   nvarchar(100),
				[Field2]   nvarchar(100),
				[Field3]   nvarchar(100),
				[Field4]   nvarchar(100),
				[Field5]   nvarchar(100),
				[Field6]   nvarchar(100),
				[Field7]   nvarchar(100),
				[Field8]   nvarchar(100),
				[Field9]   nvarchar(100),
				[Field10]  nvarchar(100),
				[WMSBranchPlantCode] nvarchar(100),
                [WareHouseType] bigint
            )tmp WHERE Location.[LocationId]=tmp.[LocationId]


		DELETE FROM [contactinformation] 
          WHERE  objectid = @LocationId 
                 AND objecttype = 'Location' 

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
                 tmp1.[contactpersonname], 
                 tmp1.[contactpersonnumber], 
                 tmp1.[isactive], 
                 tmp1.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/LocationList/ContactInformationList', 2) 
                    WITH ( [ObjectType]          NVARCHAR(max), 
                           [ContactType]         NVARCHAR(max), 
                           [ContactPersonName]   NVARCHAR(max), 
                           [ContactPersonNumber] NVARCHAR(max), 
                           [IsActive]            BIT, 
                           [CreatedBy]           BIGINT )tmp1 

						   

             SELECT @LocationId as LocationId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END