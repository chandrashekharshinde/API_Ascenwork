



CREATE PROCEDURE [dbo].[DSP_TransportVehicleById]
(
	@xmlDoc XML
)
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

		Declare @TransportVehicleId bigint
		Declare @IsActive bit;
		Declare @ModifiedBy bigint;

		SELECT 
			@TransportVehicleId = tmp.[TransportVehicleId],
			   @IsActive = tmp.[IsActive],
			   @ModifiedBy = tmp.[ModifiedBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[TransportVehicleId] bigint,
			[IsActive] bit,
			[ModifiedBy] bigint
        )tmp ;

	
		Update TransportVehicle
		SET 
			IsActive=@IsActive, UpdatedBy = @ModifiedBy, UpdatedDate=GETDATE() 
		where [TransportVehicleId]=@TransportVehicleId



		--Add child table insert procedure when required.
		
		Update VehicleCompartment
		SET 
			IsActive=@IsActive, UpdatedBy = @ModifiedBy, UpdatedDate=GETDATE() 
		where [TransportVehicleId]=@TransportVehicleId


		Update VehicleProductType
		SET 
			IsActive=@IsActive, UpdatedBy = @ModifiedBy, UpdatedDate=GETDATE() 
		where [TransportVehicleId]=@TransportVehicleId

		SELECT @TransportVehicleId as TransportVehicleId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
