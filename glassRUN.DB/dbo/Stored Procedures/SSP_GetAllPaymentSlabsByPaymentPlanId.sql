CREATE PROCEDURE [dbo].[SSP_GetAllPaymentSlabsByPaymentPlanId]
(
	@xmlDoc XML
)
AS
BEGIN
	
	--exec [dbo].[SSP_GetAllPaymentSlabsByPaymentPlanId] '<Json><ServicesAction>GetAllPaymentSlabsByPaymentPlanId</ServicesAction><PaymentPlanId>3</PaymentPlanId></Json>'

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
			
				
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT  
				'true' AS [@json:Array],
				ps.[PaymentSlabId],
				p.[PaymentPlanId],
				p.[PlanName],
				ps.[SlabId],
				ps.[SlabName],
				ps.[Amount],
				ps.[AmountUnit],
				(SELECT [dbo].[fn_LookupValueById](ps.[AmountUnit])) AS 'AmountUnitName',
					CONVERT(VARCHAR(10), ps.[EffectiveFrom], 103) AS EffectiveFrom,
					CONVERT(VARCHAR(10), ps.[EffectiveTo], 103) AS EffectiveTo,
				
				ps.[ApplicableAfter],
				(SELECT Top 1 ws.ActivityName From WorkFlowStep ws Where ws.StatusCode=ps.[ApplicableAfter] And ws.IsActive=1) AS 'ApplicableAfterName',
				ps.[IsActive],
				ps.[CreatedBy],
				ps.[CreatedDate],
				ps.[UpdatedBy],
				ps.[UpdatedDate]
			FROM [dbo].[PaymentSlab] ps
			Join [dbo].[PaymentPlan] p on ps.PaymentPlanId=p.PaymentPlanId
			WHERE (ps.PaymentPlanId=@PaymentPlanId OR @PaymentPlanId=0) 
			AND ps.IsActive=1
		FOR XML path('PaymentSlabList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END