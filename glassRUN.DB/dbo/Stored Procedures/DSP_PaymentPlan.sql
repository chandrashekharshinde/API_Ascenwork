CREATE PROCEDURE [dbo].[DSP_PaymentPlan]
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

		Declare @PaymentPlanId bigint

		SELECT 
			@PaymentPlanId = tmp.[PaymentPlanId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentPlanId] bigint
        )tmp ;

	
		Update PaymentPlan
		SET 
			IsActive=0 
		where [PaymentPlanId]=@PaymentPlanId

		SELECT @PaymentPlanId as PaymentPlanId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
