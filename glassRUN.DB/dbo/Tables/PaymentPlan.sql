CREATE TABLE [dbo].[PaymentPlan] (
    [PaymentPlanId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PlanName]      NVARCHAR (100) NULL,
    [IsActive]      BIT            CONSTRAINT [DF_PaymentPlan_IsActive_1] DEFAULT ((1)) NOT NULL,
    [CreatedBy]     BIGINT         NOT NULL,
    [CreatedDate]   DATETIME       NOT NULL,
    [UpdatedBy]     BIGINT         NULL,
    [UpdatedDate]   DATETIME       NULL,
    CONSTRAINT [PK_PaymentPlan_1] PRIMARY KEY CLUSTERED ([PaymentPlanId] ASC)
);

