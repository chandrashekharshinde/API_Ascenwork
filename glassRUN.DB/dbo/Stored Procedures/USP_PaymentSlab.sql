CREATE PROCEDURE [dbo].[USP_PaymentSlab]
(
	@xmlDoc xml
)
AS
BEGIN 

	-- exec USP_PaymentSlab '<Json><ServicesAction>SavePaymentSlab</ServicesAction><PaymentSlabList><PaymentSlabId>177</PaymentSlabId><PaymentPlanId>18</PaymentPlanId><PlanName>Pune</PlanName><SlabId>1252</SlabId><SlabName>Advance</SlabName><Amount>60000.00</Amount><AmountUnit>1259</AmountUnit><AmountUnitName>Amount</AmountUnitName><EffectiveFrom>17/01/2019</EffectiveFrom><EffectiveTo>17/01/2019</EffectiveTo><ApplicableAfter>520</ApplicableAfter><ApplicableAfterName>Order creation</ApplicableAfterName><IsActive>1</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-16T09:32:53.333</CreatedDate><PaymentPlanGUID>2b9da592-cc0c-4545-966b-48535b543ad2</PaymentPlanGUID></PaymentSlabList><PaymentSlabList><PaymentPlanGUID>b0595bd7-8fb8-4e94-a693-6463a4d00837</PaymentPlanGUID><PaymentSlabId>0</PaymentSlabId><PaymentPlanId>18</PaymentPlanId><PlanName>Pune</PlanName><SlabId>1253</SlabId><SlabName>Slab 1</SlabName><Amount>40000</Amount><AmountUnit>1259</AmountUnit><AmountUnitName>Amount</AmountUnitName><EffectiveFrom>18/01/2019</EffectiveFrom><EffectiveTo>18/01/2019</EffectiveTo><ApplicableAfter>1</ApplicableAfter><ApplicableAfterName>Create Enquiry</ApplicableAfterName><IsActive>true</IsActive><CreatedBy>8</CreatedBy></PaymentSlabList></Json>'

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        DECLARE @PaymentPlanId bigint

		--print 'Declared'
		Declare @PlanName nvarchar(100)

		SELECT 
			@PlanName = tmp.[PlanName]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PlanName] nvarchar(100)
		)tmp ;

        Update [dbo].[PaymentPlan]
		Set
			@PaymentPlanId=tmp.PaymentPlanId,
			PlanName=@PlanName,
			UpdatedBy=tmp.UpdatedBy,
			UpdatedDate=GETDATE()
		FROM OPENXML(@intpointer,'Json/PaymentSlabList',2)
		WITH
		(
            [PaymentPlanId] bigint,
			[PlanName] nvarchar(100),
			[IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedDate] datetime
		)tmp 
		Where [dbo].[PaymentPlan].[PaymentPlanId]=tmp.PaymentPlanId
		And tmp.PaymentPlanId!=0
        
		--print '@PaymentPlanId'
		--print @PaymentPlanId

		Delete From PaymentSlab Where PaymentPlanId=@PaymentPlanId

		print 'Deleted'

		INSERT INTO	[PaymentSlab]
        (
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
        	[CreatedDate]
        )
        SELECT
        	tmp.[PaymentPlanId],
        	tmp.[PlanName],
        	tmp.[SlabId],
        	tmp.[SlabName],
        	tmp.[Amount],
        	tmp.[AmountUnit],
        	Convert(datetime, tmp.[EffectiveFrom], 103),
        	Convert(datetime, tmp.[EffectiveTo], 103),
        	tmp.[ApplicableAfter],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
		FROM OPENXML(@intpointer,'Json/PaymentSlabList',2)
        WITH
        (
            [PaymentPlanId] bigint,
            [PlanName] nvarchar(100),
            [SlabId] bigint,
            [SlabName] nvarchar(100),
            [Amount] decimal(18, 2),
            [AmountUnit] bigint,
            [EffectiveFrom] nvarchar(100),
            [EffectiveTo] nvarchar(100),
            [ApplicableAfter] bigint,
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
        
        DECLARE @PaymentSlabId bigint
	    SET @PaymentSlabId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @PaymentSlabId as PaymentSlabId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
