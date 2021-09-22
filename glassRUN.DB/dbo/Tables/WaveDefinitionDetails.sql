CREATE TABLE [dbo].[WaveDefinitionDetails] (
    [WaveDefinitionDetailsId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [WaveDefinitionId]        BIGINT   NULL,
    [TruckSizeId]             BIGINT   NULL,
    [IsActive]                BIT      NULL,
    [CreatedBy]               BIGINT   NULL,
    [CreatedDate]             DATETIME NULL,
    [ModifiedBy]              BIGINT   NULL,
    [ModifiedDate]            DATETIME NULL,
    CONSTRAINT [PK_WaveDefinitionDetails] PRIMARY KEY CLUSTERED ([WaveDefinitionDetailsId] ASC) WITH (FILLFACTOR = 80)
);

