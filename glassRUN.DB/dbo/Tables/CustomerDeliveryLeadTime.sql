CREATE TABLE [dbo].[CustomerDeliveryLeadTime] (
    [CustomerDeliveryLeadTimeId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [CompanyId]                  BIGINT   NULL,
    [DestinationId]              BIGINT   NULL,
    [LeadTime]                   DATETIME NULL,
    CONSTRAINT [PK_CustomerDeliveryLeadTime] PRIMARY KEY CLUSTERED ([CustomerDeliveryLeadTimeId] ASC) WITH (FILLFACTOR = 80)
);

