CREATE TABLE [dbo].[WaveDefinition] (
    [WaveDefinitionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [WaveDateTime]     DATETIME       NULL,
    [RuleText]         NVARCHAR (MAX) NULL,
    [RuleType]         BIGINT         NULL,
    [IsActive]         BIT            NULL,
    [CreatedBy]        BIGINT         NULL,
    [CreatedDate]      DATETIME       NULL,
    [ModifiedBy]       BIGINT         NULL,
    [ModifiedDate]     DATETIME       NULL,
    CONSTRAINT [PK_WaveDefinition] PRIMARY KEY CLUSTERED ([WaveDefinitionId] ASC) WITH (FILLFACTOR = 80)
);

