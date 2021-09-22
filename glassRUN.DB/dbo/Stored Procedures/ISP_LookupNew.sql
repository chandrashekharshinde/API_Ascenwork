﻿

CREATE PROCEDURE [dbo].[ISP_LookupNew] --'<JSON><LookUpId>0</LookUpId><LookupCategory>6</LookupCategory><Name>Metre</Name><Code>MTR</Code><Description>Metre</Description><ShortCode>MT</ShortCode><DisplayIcon></DisplayIcon><IsActive>true</IsActive><DBStatus>New</DBStatus></JSON>'
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
		DECLARE @LookupCategory bigint; 


		SELECT
		
		INSERT INTO [dbo].[LookUp]
		(
		[LookUpId],
			[LookupCategory],
			[Name],
			[Code],
			[Description],
			[ShortCode],
			[DisplayIcon],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		)
		Select
		@LookupId,
			tmp.[LookupCategory],
			tmp.[Name],
			tmp.[Code],
			tmp.[Description],	
			tmp.[ShortCode],	
			tmp.[DisplayIcon],	
			tmp.[IsActive],
			tmp.Createdby,
			Getdate()
		FROM OPENXML(@intpointer,'JSON',2)
        WITH
		(
			[LookupCategory] bigint,
			[Name] nvarchar(200),			
			[Code] nvarchar(100),			
			[Description] nvarchar(500),	
			[ShortCode] nvarchar(100),
			[DisplayIcon] nvarchar(max),	
			[IsActive] bit,
			Createdby bigint,
			[CreatedDate] datetime
		)tmp

		

       

		
		
		
		
		
		SELECT @LookupId as LookupId FOR XML RAW('JSON'),ELEMENTS
   
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END