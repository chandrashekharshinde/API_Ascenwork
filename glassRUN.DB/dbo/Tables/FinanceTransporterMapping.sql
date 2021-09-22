CREATE TABLE [dbo].[FinanceTransporterMapping] (
    [FinanceTransporterMappingId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [TransporterId]               BIGINT          NULL,
    [FinancePartnerId]            BIGINT          NULL,
    [Amount]                      DECIMAL (18, 2) NULL,
    [FromDate]                    DATETIME        NULL,
    [ToDate]                      DATETIME        NULL,
    [CreatedBy]                   BIGINT          NOT NULL,
    [CreatedDate]                 DATETIME        NOT NULL,
    [ModifiedBy]                  BIGINT          NULL,
    [ModifiedDate]                DATETIME        NULL,
    [IsActive]                    BIT             NOT NULL,
    CONSTRAINT [PK_FinanceTransporterMapping] PRIMARY KEY CLUSTERED ([FinanceTransporterMappingId] ASC)
);

