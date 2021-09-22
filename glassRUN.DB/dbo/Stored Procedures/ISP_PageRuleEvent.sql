

Create PROCEDURE [dbo].[ISP_PageRuleEvent] --'<Json><ServicesAction>SaveLookup</ServicesAction><LookupCategoryList><LookupId>0</LookupId><Name>test</Name><LookupCategory>5</LookupCategory><IsActive>true</IsActive><ResourceKey></ResourceKey><Criteria></Criteria><Createdby>1</Createdby></LookupCategoryList></Json>'
(
@xmlDoc xml 
)
AS 
 BEGIN 
	
	-- exec [dbo].[ISP_TransportVehicle] '<Json><ServicesAction>SaveTransportVehicle</ServicesAction><TransportVehicleList><TransportVehicleId>0</TransportVehicleId><VehicleName>Tata</VehicleName><VehicleRegistrationNumber>MH02AR4447</VehicleRegistrationNumber><TransporterId>1229</TransporterId><VehicleTypeId>1264</VehicleTypeId><NumberOfCompartments>3</NumberOfCompartments><TruckSizeId>12</TruckSizeId><SequenceNumber>3</SequenceNumber><IsVehicleInsured>True</IsVehicleInsured><InsuranceValidityDate/><IsFitnessCertificateAvailed>True</IsFitnessCertificateAvailed><FitnessCertificateDate/><VehicleOwnerName>Irshad</VehicleOwnerName><VehicleOwnerAddress1>Malad</VehicleOwnerAddress1><VehicleOwnerAddress2>West</VehicleOwnerAddress2><FormatType></FormatType><RegisteredVehicleCertificateBlob></RegisteredVehicleCertificateBlob><Field1>jkh</Field1><Field2>kh</Field2><Field3>nb</Field3><Field4>hyu</Field4><Field5>bm</Field5><Field6>jhg</Field6><Field7>yu</Field7><Field8>bn</Field8><Field9>bnv</Field9><Field10>jhg</Field10><IsActive>true</IsActive><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy></TransportVehicleList><VehicleCompartmentList><VehicleCompartmentGuid>dcf402f0-16a5-477b-83c2-9ea2c1517d5f</VehicleCompartmentGuid><CompartmentName>One</CompartmentName><Capacity>2000</Capacity><UnitOfMeasureId>18</UnitOfMeasureId><UnitOfMeasure>Kg</UnitOfMeasure><IsActive>true</IsActive><CreatedBy>8</CreatedBy></VehicleCompartmentList><VehicleCompartmentList><VehicleCompartmentGuid>4a193355-a2c2-4bf5-b36d-79365d7d4f15</VehicleCompartmentGuid><VehicleCompartmentId>0</VehicleCompartmentId><CompartmentName>Two</CompartmentName><Capacity>3000</Capacity><UnitOfMeasureId>18</UnitOfMeasureId><UnitOfMeasure>Kg</UnitOfMeasure><IsActive>true</IsActive><CreatedBy>8</CreatedBy></VehicleCompartmentList><VehicleCompartmentList><VehicleCompartmentGuid>19a2f670-d551-45c1-97aa-4b552f2e0a8a</VehicleCompartmentGuid><VehicleCompartmentId>0</VehicleCompartmentId><CompartmentName>Three</CompartmentName><Capacity>4000</Capacity><UnitOfMeasureId>18</UnitOfMeasureId><UnitOfMeasure>Kg</UnitOfMeasure><IsActive>true</IsActive><CreatedBy>8</CreatedBy></VehicleCompartmentList></Json>'	

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
	
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
		DECLARE @LookupCategory bigint; 		DECLARE @LookupId bigint;		DECLARE @Name nvarchar(100); 		DECLARE @count BIGINT


		
		INSERT INTO [dbo].[PageRuleEvent]
		(
		
		[PageId],
		[PageName],
			[PageEvent],
			
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		)
		Select
		
			tmp.[PageId],
			tmp.[PageName],
			tmp.[PageEvent],					
			1,
			tmp.Createdby,
			Getdate()
		FROM OPENXML(@intpointer,'Json/PageRuleEventList',2)
        WITH
		(
			[PageId] bigint,
			[PageName] nvarchar(200),			
			[PageEvent] nvarchar(100),	
			
			[IsActive] bit,
			Createdby bigint,
			[CreatedDate] datetime
		)tmp

		

          DECLARE @PageRuleEventId bigint
     SET @PageRuleEventId = @@IDENTITY

		
		
		
		
		
		SELECT @PageRuleEventId as PageRuleEventId FOR XML RAW('Json'),ELEMENTS
   
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
