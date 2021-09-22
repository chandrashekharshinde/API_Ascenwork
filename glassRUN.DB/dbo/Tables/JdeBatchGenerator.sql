CREATE TABLE [dbo].[JdeBatchGenerator] (
    [JdeBatchGeneratorId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [BatchValue]          NVARCHAR (50) NULL,
    CONSTRAINT [PK_JdeBatchGenerator] PRIMARY KEY CLUSTERED ([JdeBatchGeneratorId] ASC) WITH (FILLFACTOR = 80)
);

