CREATE PROCEDURE [dbo].[USP_TransportVehicle]
(
	@xmlDoc xml
)
AS
BEGIN 
	
	-- exec [dbo].[USP_TransportVehicle] '<Json><ServicesAction>SaveTransportVehicle</ServicesAction><TransportVehicleList><TransporterVehicleId>26</TransporterVehicleId><VehicleName>Toyota</VehicleName><VehicleRegistrationNumber>234234</VehicleRegistrationNumber><TransporterId>1223</TransporterId><VehicleTypeId>1264</VehicleTypeId><NumberOfCompartments>2</NumberOfCompartments><TruckSizeId>15</TruckSizeId><SequenceNumber>35345464576</SequenceNumber><IsVehicleInsured>1</IsVehicleInsured><InsuranceValidityDate>08/01/2019</InsuranceValidityDate><IsFitnessCertificateAvailed>1</IsFitnessCertificateAvailed><FitnessCertificateDate>20/01/2019</FitnessCertificateDate><VehicleOwnerName>sdf</VehicleOwnerName><VehicleOwnerAddress1>sdfsdf</VehicleOwnerAddress1><VehicleOwnerAddress2>cbcvb</VehicleOwnerAddress2><FormatType></FormatType><RegisteredVehicleCertificateBlob></RegisteredVehicleCertificateBlob><Field1>hgj</Field1><Field2>bn</Field2><Field3>hg</Field3><Field4>h b</Field4><Field5>jhg</Field5><Field6>bnmb n</Field6><Field7>vgh</Field7><Field8>nbvn</Field8><Field9>vghvh</Field9><Field10>nb</Field10><IsActive>true</IsActive><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy></TransportVehicleList><VehicleCompartmentList><VehicleCompartmentId>7</VehicleCompartmentId><TransportVehicleId>26</TransportVehicleId><CompartmentName>dsfs</CompartmentName><Capacity>234.00</Capacity><UnitOfMeasureId>16</UnitOfMeasureId><UnitOfMeasure>Pallet</UnitOfMeasure><IsActive>1</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-08T14:40:11.743</CreatedDate></VehicleCompartmentList><VehicleCompartmentList><VehicleCompartmentId>8</VehicleCompartmentId><TransportVehicleId>26</TransportVehicleId><CompartmentName>dfdcv</CompartmentName><Capacity>45564.00</Capacity><UnitOfMeasureId>20</UnitOfMeasureId><UnitOfMeasure>Litre</UnitOfMeasure><IsActive>1</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-08T14:40:11.743</CreatedDate></VehicleCompartmentList></Json>'

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		DECLARE @TransportVehicleId bigint

		UPDATE dbo.[TransportVehicle] 
		SET
			@TransportVehicleId=tmp.[TransportVehicleId],
			[VehicleName]=tmp.[VehicleName],
			[VehicleRegistrationNumber] =tmp.[VehicleRegistrationNumber],
			[TransporterId] =tmp.[TransporterId],
			[VehicleTypeId] =tmp.[VehicleTypeId],
			[NumberOfCompartments] =tmp.[NumberOfCompartments],
			[TruckSizeId] =tmp.[TruckSizeId],
			[SequenceNumber] =tmp.[SequenceNumber],
			[IsVehicleInsured] =tmp.[IsVehicleInsured],
			[InsuranceValidityDate] =(Case When tmp.[InsuranceValidityDate] !='' Then Convert(datetime, tmp.[InsuranceValidityDate], 103) Else NULL End),
			[IsFitnessCertificateAvailed] =tmp.[IsFitnessCertificateAvailed],
			[FitnessCertificateDate] =(Case When tmp.[FitnessCertificateDate] != '' Then Convert(datetime, tmp.[FitnessCertificateDate], 103) Else NULL End),
			[VehicleOwnerName] =tmp.[VehicleOwnerName],
			[VehicleOwnerAddress1] =tmp.[VehicleOwnerAddress1],
			[VehicleOwnerAddress2] =tmp.[VehicleOwnerAddress2],
			[FormatType] =tmp.[FormatType],
			[RegisteredVehicleCertificateBlob] =tmp.[RegisteredVehicleCertificateBlob],
			[Field1] =tmp.[Field1],
			[Field2] =tmp.[Field2],
			[Field3] =tmp.[Field3],
			[Field4] =tmp.[Field4],
			[Field5] =tmp.[Field5],
			[Field6] =tmp.[Field6],
			[Field7] =tmp.[Field7],
			[Field8] =tmp.[Field8],
			[Field9] =tmp.[Field9],
			[Field10] =tmp.[Field10],
			[UpdatedBy] =tmp.[UpdatedBy],
			[UpdatedDate] =GETDATE()
		FROM OPENXML(@intpointer,'Json/TransportVehicleList',2)
		WITH
		(
			[TransportVehicleId] bigint, 
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
			[UpdatedBy] bigint,
			[UpdatedDate] datetime
		)tmp 
		WHERE [TransportVehicle].[TransportVehicleId]=tmp.[TransportVehicleId]

		--Add child table insert procedure when required.
		
		---------------------------------------------------------------------------------------------
		--			Delete And Insert into VehicleCompartment Table
		---------------------------------------------------------------------------------------------

		Delete From VehicleCompartment Where TransportVehicleId=@TransportVehicleId


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
		--			Delete And Insert into VehicleProductType Table
		---------------------------------------------------------------------------------------------

		Delete From VehicleProductType Where TransportVehicleId=@TransportVehicleId

		
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
