CREATE TABLE [dbo].[PaymentSlab] (
    [PaymentSlabId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [PaymentPlanId]   BIGINT          NULL,
    [PlanName]        NVARCHAR (100)  NULL,
    [SlabId]          BIGINT          NULL,
    [SlabName]        NVARCHAR (100)  NULL,
    [Amount]          DECIMAL (18, 2) NULL,
    [AmountUnit]      BIGINT          NULL,
    [EffectiveFrom]   DATETIME        NULL,
    [EffectiveTo]     DATETIME        NULL,
    [ApplicableAfter] BIGINT          NULL,
    [IsActive]        BIT             CONSTRAINT [DF_PaymentPlan_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]       BIGINT          NOT NULL,
    [CreatedDate]     DATETIME        NOT NULL,
    [UpdatedBy]       BIGINT          NULL,
    [UpdatedDate]     DATETIME        NULL,
    CONSTRAINT [PK_PaymentPlan] PRIMARY KEY CLUSTERED ([PaymentSlabId] ASC)
);

