CREATE PROCEDURE [dbo].[USP_PaymentPlan]
(
	@xmlDoc xml
)
AS
BEGIN 

--exec USP_PaymentPlan '<Json><ServicesAction>SavePaymentPlan</ServicesAction><PaymentPlanList><PaymentPlanId>4</PaymentPlanId><PlanName>Plan 3</PlanName><IsActive>true</IsActive><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy></PaymentPlanList></Json>'

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        DECLARE @PaymentPlanId bigint

		Update [dbo].[PaymentPlan]
        Set
			@PaymentPlanId=tmp.PaymentPlanId,
			PlanName=tmp.PlanName,
			UpdatedBy=tmp.UpdatedBy,
			UpdatedDate=GETDATE()
		FROM OPENXML(@intpointer,'Json/PaymentPlanList',2)
		WITH
		(
            [PaymentPlanId] bigint,
			[PlanName] nvarchar(100),
			[UpdatedBy] bigint,
			[UpdatedDate] datetime
		)tmp 
		Where [dbo].[PaymentPlan].PaymentPlanId=tmp.PaymentPlanId
		And tmp.PaymentPlanId!=0
        
		--print 'zzxczxczxc' 
		--print @PlanName

		--Delete From PaymentPlan Where PlanName=@PlanName

		--INSERT INTO	[PaymentPlan]
  --      (
  --      	[PlanName],
  --      	[SlabId],
  --      	[SlabName],
  --      	[Amount],
  --      	[AmountUnit],
  --      	[EffectiveFrom],
  --      	[EffectiveTo],
  --      	[ApplicableAfter],
  --      	[IsActive],
  --      	[CreatedBy],
  --      	[CreatedDate]
  --      )
  --      SELECT
  --      	tmp.[PlanName],
  --      	tmp.[SlabId],
  --      	tmp.[SlabName],
  --      	tmp.[Amount],
  --      	tmp.[AmountUnit],
  --      	Convert(datetime, tmp.[EffectiveFrom], 103),
  --      	Convert(datetime, tmp.[EffectiveTo], 103),
  --      	tmp.[ApplicableAfter],
  --      	tmp.[IsActive],
  --      	tmp.[CreatedBy],
  --      	GETDATE()
		--FROM OPENXML(@intpointer,'Json/PaymentPlanList',2)
  --      WITH
  --      (
  --          [PlanName] nvarchar(100),
  --          [SlabId] bigint,
  --          [SlabName] nvarchar(100),
  --          [Amount] decimal(18, 2),
  --          [AmountUnit] bigint,
  --          [EffectiveFrom] nvarchar(100),
  --          [EffectiveTo] nvarchar(100),
  --          [ApplicableAfter] bigint,
  --          [IsActive] bit,
  --          [CreatedBy] bigint
		--	--,
  --          --[CreatedDate] datetime
  --      )tmp
        
  --      DECLARE @PaymentPlanId bigint
	 --   SET @PaymentPlanId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @PaymentPlanId as PaymentPlanId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
