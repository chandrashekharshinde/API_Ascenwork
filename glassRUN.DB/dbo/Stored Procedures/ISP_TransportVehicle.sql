

CREATE PROCEDURE [dbo].[ISP_TransportVehicle]
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
		
		INSERT INTO [dbo].[TransportVehicle]
		(
			[VehicleName],
			[VehicleRegistrationNumber],
			[TransporterId],
			[VehicleTypeId],
			[NumberOfCompartments],
			[TruckSizeId],
			[SequenceNumber],
			[IsVehicleInsured],
			[InsuranceValidityDate],
			[IsFitnessCertificateAvailed],
			[FitnessCertificateDate],
			[VehicleOwnerName],
			[VehicleOwnerAddress1],
			[VehicleOwnerAddress2],
			[FormatType],
			[RegisteredVehicleCertificateBlob],
			[Field1],
			[Field2],
			[Field3],
			[Field4],
			[Field5],
			[Field6],
			[Field7],
			[Field8],
			[Field9],
			[Field10],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		)
		Select
			tmp.[VehicleRegistrationNumber],
			tmp.[VehicleRegistrationNumber],
			tmp.[TransporterId],
			tmp.[VehicleTypeId],
			tmp.[NumberOfCompartments],
			tmp.[TruckSizeId],
			tmp.[SequenceNumber],
			tmp.[IsVehicleInsured],
			(Case When tmp.[InsuranceValidityDate] !='' Then Convert(datetime, tmp.[InsuranceValidityDate], 103) Else NULL End),
			tmp.[IsFitnessCertificateAvailed],
			(Case When tmp.[FitnessCertificateDate] != '' Then Convert(datetime, tmp.[FitnessCertificateDate], 103) Else NULL End),
			tmp.[VehicleOwnerName],
			tmp.[VehicleOwnerAddress1],
			tmp.[VehicleOwnerAddress2],
			tmp.[FormatType],
			tmp.[RegisteredVehicleCertificateBlob],
			tmp.[Field1],
			tmp.[Field2],
			tmp.[Field3],
			tmp.[Field4],
			tmp.[Field5],
			tmp.[Field6],
			tmp.[Field7],
			tmp.[Field8],
			tmp.[Field9],
			tmp.[Field10],
			tmp.[IsActive],
			tmp.[CreatedBy],
			Getdate()
		FROM OPENXML(@intpointer,'Json/TransportVehicleList',2)
        WITH
		(
			[VehicleName] nvarchar(500),
			[VehicleRegistrationNumber] nvarchar(200),
			[TransporterId] bigint,
			[VehicleTypeId] bigint,
			[NumberOfCompartments] bigint,
			[TruckSizeId] bigint,
			[SequenceNumber] bigint,
			[IsVehicleInsured] bit,
			[InsuranceValidityDate] nvarchar(100),
			[IsFitnessCertificateAvailed] bit,
			[FitnessCertificateDate] nvarchar(100),
			[VehicleOwnerName] nvarchar(40),
			[VehicleOwnerAddress1] nvarchar(30),
			[VehicleOwnerAddress2] nvarchar(30),
			[FormatType] nvarchar(50),
			[RegisteredVehicleCertificateBlob] nvarchar(max),
			[Field1] nvarchar(500),
			[Field2] nvarchar(500),
			[Field3] nvarchar(500),
			[Field4] nvarchar(500),
			[Field5] nvarchar(500),
			[Field6] nvarchar(500),
			[Field7] nvarchar(500),
			[Field8] nvarchar(500),
			[Field9] nvarchar(500),
			[Field10] nvarchar(500),
			[IsActive] bit,
			[CreatedBy] bigint,
			[CreatedDate] datetime
		)tmp

		DECLARE @TransportVehicleId bigint
	    SET @TransportVehicleId = @@IDENTITY

        --Add child table insert procedure when required.
		
		---------------------------------------------------------------------------------------------
		--			Insert into VehicleCompartment Table
		---------------------------------------------------------------------------------------------
		INSERT INTO [dbo].[VehicleCompartment]
		(
			[TransportVehicleId],
			[CompartmentName],
			[Capacity],
			[UnitOfMeasureId],
			[UnitOfMeasure],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		)
		Select 
			@TransportVehicleId,
			tmpc.[CompartmentName],
			tmpc.[Capacity],
			tmpc.[UnitOfMeasureId],
			tmpc.[UnitOfMeasure],
			tmpc.[IsActive],
			tmpc.[CreatedBy],
			GETDATE()
		FROM OPENXML(@intpointer,'Json/VehicleCompartmentList',2)
        WITH
		(
			[TransportVehicleId] bigint,
			[CompartmentName] nvarchar(100),
			[Capacity] decimal(18,2),
			[UnitOfMeasureId] bigint,
			[UnitOfMeasure] nvarchar(100),
			[IsActive] bit,
			[CreatedBy] bigint,
			[CreatedDate] datetime
		)tmpc
		
		---------------------------------------------------------------------------------------------
		--			Insert into VehicleProductType Table
		---------------------------------------------------------------------------------------------
		INSERT INTO [dbo].[VehicleProductType]
		(
			[TransportVehicleId],
			[ProductTypeId],
			[ProductType],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
		)
		Select 
			@TransportVehicleId,
			tmpvpt.[ProductTypeId],
			tmpvpt.[ProductType],
			tmpvpt.[IsActive],
			tmpvpt.[CreatedBy],
			GETDATE()
		FROM OPENXML(@intpointer,'Json/VehicleProductTypeList',2)
        WITH
		(
			[TransportVehicleId] bigint,
			[ProductTypeId] bigint,
			[ProductType] nvarchar(100),
			[IsActive] bit,
			[CreatedBy] bigint,
			[CreatedDate] datetime
		)tmpvpt

		
		
		
		
		
		SELECT @TransportVehicleId as TransportVehicleId FOR XML RAW('Json'),ELEMENTS
   
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
