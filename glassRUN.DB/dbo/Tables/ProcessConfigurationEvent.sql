CREATE TABLE [dbo].[ProcessConfigurationEvent] (
    [ProcessConfigurationEventId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Proccess]                    NVARCHAR (50) NULL,
    [EventCode]                   NVARCHAR (50) NULL,
    [ResourceKey]                 NVARCHAR (50) NULL,
    [Sequence]                    BIGINT        NULL,
    CONSTRAINT [PK_ProcessConfigurationEvent] PRIMARY KEY CLUSTERED ([ProcessConfigurationEventId] ASC) WITH (FILLFACTOR = 80)
);

