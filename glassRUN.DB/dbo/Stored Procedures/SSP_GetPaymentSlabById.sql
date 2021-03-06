CREATE PROCEDURE [dbo].[SSP_GetPaymentSlabById]
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

		SELECT 
			@PaymentSlabId = tmp.[PaymentSlabId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentSlabId] bigint
		)tmp ;
			
				
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT  
				'true' AS [@json:Array],
				[PaymentPlanId],
				[PlanName],
				[SlabId],
				[SlabName],
				[Amount],
				[AmountUnit],
				[EffectiveFrom],
				[EffectiveTo],
				[ApplicableAfter],
				[IsActive],
				[CreatedBy],
				[CreatedDate],
				[UpdatedBy],
				[UpdatedDate]
		FROM [dbo].[PaymentSlab]
		WHERE (PaymentSlabId=@PaymentSlabId OR @PaymentSlabId=0) 
		AND IsActive=1
		FOR XML path('PaymentSlabList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
