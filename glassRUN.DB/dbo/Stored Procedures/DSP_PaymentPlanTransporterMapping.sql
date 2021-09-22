CREATE PROCEDURE [dbo].[DSP_PaymentPlanTransporterMapping]
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

		Declare @PaymentPlanTransporterMappingId bigint

		SELECT 
			@PaymentPlanTransporterMappingId = tmp.[PaymentPlanTransporterMappingId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentPlanTransporterMappingId] bigint
        )tmp ;

	
		Delete From PaymentPlanTransporterMapping
		where [PaymentPlanTransporterMappingId]=@PaymentPlanTransporterMappingId

		SELECT @PaymentPlanTransporterMappingId as PaymentPlanTransporterMappingId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
