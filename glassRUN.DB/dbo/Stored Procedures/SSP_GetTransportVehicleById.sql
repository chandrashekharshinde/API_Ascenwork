


CREATE PROCEDURE [dbo].[SSP_GetTransportVehicleById]
(
	@xmlDoc XML
)
AS
BEGIN
	
	-- exec [dbo].[SSP_GetTransportVehicleById] '<Json><ServicesAction>GetTransportVehicleById</ServicesAction><TransportVehicleId>24</TransportVehicleId></Json>'
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @TransportVehicleId bigint

		SELECT 
			@TransportVehicleId = tmp.[TransportVehicleId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[TransportVehicleId] bigint
		)tmp ;
			
				
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT  
				'true' AS [@json:Array],
				tv.[TransportVehicleId],
				tv.[VehicleName],
				tv.[VehicleRegistrationNumber],
				tv.[TransporterId],
				--c.[CompanyName] AS 'TransporterName',
				tv.[VehicleTypeId],
				--ltv.[Name] AS 'VehicleTypeName',
				tv.[NumberOfCompartments],
				tv.[TruckSizeId],
				--ts.[TruckSize] AS 'TruckSize',
				tv.[SequenceNumber],
				tv.[IsVehicleInsured],
				CONVERT(VARCHAR(10), tv.[InsuranceValidityDate], 103) AS InsuranceValidityDate,
				
				tv.[IsFitnessCertificateAvailed],
				CONVERT(VARCHAR(10), tv.[FitnessCertificateDate], 103) AS FitnessCertificateDate,
				
				tv.[VehicleOwnerName],
				tv.[VehicleOwnerAddress1],
				tv.[VehicleOwnerAddress2],
				tv.[FormatType],
				tv.[RegisteredVehicleCertificateBlob],
				tv.[FormatType] as DocumentFormat,
				tv.[RegisteredVehicleCertificateBlob] as DocumentBlob,
				tv.[Field1],
				tv.[Field2],
				tv.[Field3],
				tv.[Field4],
				tv.[Field5],
				tv.[Field6],
				tv.[Field7],
				tv.[Field8],
				tv.[Field9],
				tv.[Field10],
				tv.[IsActive],
				tv.[CreatedBy],
				tv.[CreatedDate],
				tv.[UpdatedBy],
				tv.[UpdatedDate],

				(SELECT CAST((
					SELECT 
						vc.[VehicleCompartmentId],
						vc.[TransportVehicleId],
						vc.[CompartmentName],
						vc.[Capacity],
						vc.[UnitOfMeasureId],
						vc.[UnitOfMeasure],
						vc.[IsActive],
						vc.[CreatedBy],
						vc.[CreatedDate],
						vc.[UpdatedBy],
						vc.[UpdatedDate]
					FROM [dbo].[VehicleCompartment] vc
					Where vc.TransportVehicleId=@TransportVehicleId
					And vc.IsActive=1
				FOR XML path('CompartmentList'),ELEMENTS) AS XML)),

				(SELECT CAST((
					SELECT 
						vpt.[VehicleProductTypeId],
						vpt.[TransportVehicleId],
						vpt.[ProductTypeId] AS 'Id',
						vpt.[ProductTypeId],
						vpt.[ProductType],
						vpt.[IsActive],
						vpt.[CreatedBy],
						vpt.[CreatedDate],
						vpt.[UpdatedBy],
						vpt.[UpdatedDate]
					FROM [dbo].[VehicleProductType] vpt
					Where vpt.TransportVehicleId=@TransportVehicleId
					And vpt.IsActive=1
				FOR XML path('VehicleProductTypeList'),ELEMENTS) AS XML))
			FROM [dbo].[TransportVehicle] tv
			--Join [dbo].[Company] c on tv.TransporterId=c.CompanyId And c.CompanyType=28 And c.IsActive=1  --Transporter==>28(Lookup)
			--Join [dbo].[LookUp] ltv on tv.VehicleTypeId=ltv.LookUpId And ltv.LookupCategory=8 And ltv.IsActive=1 --VehicleType==>8(LookupCategory)
			--Join [dbo].[TruckSize] ts on tv.TruckSizeId=ts.TruckSizeId And ts.IsActive=1
			WHERE (tv.TransportVehicleId=@TransportVehicleId OR @TransportVehicleId=0) 
			--AND tv.IsActive=1
		FOR XML path('TransportVehicleList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END