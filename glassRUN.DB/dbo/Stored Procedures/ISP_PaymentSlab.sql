CREATE PROCEDURE [dbo].[ISP_PaymentSlab]
(
	@xmlDoc xml 
)
AS 
 BEGIN 

 -- exec [dbo].[ISP_PaymentSlab] '<Json><ServicesAction>SavePaymentSlab</ServicesAction><PlanName>Mumbai</PlanName><PaymentSlabList><PaymentSlabId>0</PaymentSlabId><PaymentPlanId>15</PaymentPlanId><PlanName>Mumbai</PlanName><SlabId>1254</SlabId><SlabName>Slab 2</SlabName><Amount>10</Amount><AmountUnit>1260</AmountUnit><AmountUnitName>Percentage</AmountUnitName><EffectiveFrom>11/01/2019</EffectiveFrom><EffectiveTo>11/01/2019</EffectiveTo><ApplicableAfter>1</ApplicableAfter><ApplicableAfterName>Create Enquiry</ApplicableAfterName><IsActive>true</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-16T10:04:29.09</CreatedDate><PaymentPlanGUID>6b204590-2654-4067-bb52-310eed367615</PaymentPlanGUID><UpdatedBy>8</UpdatedBy></PaymentSlabList><PaymentSlabList><PaymentSlabId>194</PaymentSlabId><PaymentPlanId>15</PaymentPlanId><PlanName>Mumbai</PlanName><SlabId>1252</SlabId><SlabName>Advance</SlabName><Amount>50.00</Amount><AmountUnit>1260</AmountUnit><AmountUnitName>Percentage</AmountUnitName><EffectiveFrom>11/01/2019</EffectiveFrom><EffectiveTo>11/01/2019</EffectiveTo><ApplicableAfter>1</ApplicableAfter><ApplicableAfterName>Create Enquiry</ApplicableAfterName><IsActive>1</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-16T10:04:29.09</CreatedDate><PaymentPlanGUID>2df2df69-12c2-4e23-9d28-0fe2011bdd81</PaymentPlanGUID></PaymentSlabList><PaymentSlabList><PaymentSlabId>195</PaymentSlabId><PaymentPlanId>15</PaymentPlanId><PlanName>Mumbai</PlanName><SlabId>1253</SlabId><SlabName>Slab 1</SlabName><Amount>50.00</Amount><AmountUnit>1260</AmountUnit><AmountUnitName>Percentage</AmountUnitName><EffectiveFrom>14/01/2019</EffectiveFrom><EffectiveTo>15/01/2019</EffectiveTo><ApplicableAfter>520</ApplicableAfter><ApplicableAfterName>Order creation</ApplicableAfterName><IsActive>1</IsActive><CreatedBy>8</CreatedBy><CreatedDate>2019-01-16T10:04:29.09</CreatedDate><PaymentPlanGUID>195a7bab-13c4-4aee-aecc-059e27ef9cde</PaymentPlanGUID></PaymentSlabList></Json>'

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
		
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @PlanName nvarchar(100)

		SELECT 
			@PlanName = tmp.[PlanName]
		FROM OPENXML(@intpointer,'Json/PaymentSlabList',2)
		WITH
		(
			[PlanName] nvarchar(100)
		)tmp ;
		
		--print 'Planname'
		--print @PlanName
		
		INSERT INTO	[PaymentPlan]
        (
        	[PlanName],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        )
        SELECT Top 1
        	tmp.[PlanName],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
		FROM OPENXML(@intpointer,'Json/PaymentSlabList',2)
        WITH
        (
            [PlanName] nvarchar(100),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
		Where tmp.[PlanName] Not In(Select PlanName From PaymentPlan)
        
        DECLARE @PaymentPlanId bigint
	    SET @PaymentPlanId = (Select PaymentPlanId From PaymentPlan Where PlanName=@PlanName And IsActive=1)

		--Select * From PaymentPlan Where PlanName=@PlanName And IsActive=1
		--print 'sdfsdfsdf'
		--print @PaymentPlanId

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
        	@PaymentPlanId,
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
