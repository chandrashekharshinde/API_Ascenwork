



CREATE PROCEDURE [dbo].[DSP_MiscellaneousById]
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

		Declare @PaymentRequestId bigint
		Declare @SlabId bigint
		Declare @SlabName nvarchar(100)

		SELECT 
			@PaymentRequestId = tmp.PaymentRequestId,
			@SlabId = tmp.SlabId,
			@SlabName = tmp.SlabName
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentRequestId] bigint,
			[SlabId] bigint,
			[SlabName] nvarchar(100)
        )tmp ;

	
		Update PaymentRequest
		SET 
			IsActive=0 
		where PaymentRequestId=@PaymentRequestId



		--Add child table insert procedure when required.
		
		

		SELECT @PaymentRequestId as PaymentRequestId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END


