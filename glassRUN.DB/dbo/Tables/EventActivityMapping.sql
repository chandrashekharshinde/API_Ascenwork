CREATE TABLE [dbo].[EventActivityMapping] (
    [EventActivityMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [EventMasterId]          BIGINT NOT NULL,
    [ActivityId]             BIGINT NOT NULL,
    CONSTRAINT [PK_EventActivityMapping] PRIMARY KEY CLUSTERED ([EventActivityMappingId] ASC)
);

