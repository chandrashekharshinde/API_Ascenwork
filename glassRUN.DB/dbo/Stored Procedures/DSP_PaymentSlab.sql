CREATE PROCEDURE [dbo].[DSP_PaymentSlab]
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

		Declare @PaymentSlabId bigint
		Declare @PaymentPlanId bigint

		SELECT 
			@PaymentSlabId = tmp.[PaymentSlabId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentSlabId] bigint
        )tmp ;

		set @PaymentPlanId = (select top 1 PaymentPlanId from PaymentSlab where IsActive = 1 and PaymentSlabId = @PaymentSlabId)
	
		Update PaymentSlab
		SET 
			IsActive=0 
		where [PaymentSlabId]=@PaymentSlabId


	Declare @Count bigint = 0;

	Set @Count = (select COUNT(*) from PaymentSlab where IsActive = 1 and PaymentPlanId = @PaymentPlanId)
	print @Count
	if(@Count = 0)
	begin
	Update PaymentPlan
		SET 
			IsActive=0 
		where PaymentPlanId = @PaymentPlanId
	end

		SELECT @PaymentSlabId as PaymentSlabId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
