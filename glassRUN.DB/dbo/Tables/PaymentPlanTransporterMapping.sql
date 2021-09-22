CREATE TABLE [dbo].[PaymentPlanTransporterMapping] (
    [PaymentPlanTransporterMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [PaymentPlanId]                   BIGINT NULL,
    [TransporterId]                   BIGINT NULL,
    CONSTRAINT [PK_PaymentPlanTransporterMapping] PRIMARY KEY CLUSTERED ([PaymentPlanTransporterMappingId] ASC)
);

