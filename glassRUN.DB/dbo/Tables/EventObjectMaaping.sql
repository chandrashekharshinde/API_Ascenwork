CREATE TABLE [dbo].[EventObjectMaaping] (
    [EventObjectMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [EmailEventId]         BIGINT   NULL,
    [ObjectId]             BIGINT   NULL,
    [IsActive]             BIT      NOT NULL,
    [CreatedBy]            BIGINT   NOT NULL,
    [CreatedDate]          DATETIME NOT NULL,
    [ModifiedBy]           BIGINT   NULL,
    [ModifiedDate]         DATETIME NULL,
    CONSTRAINT [PK_EventObjectMaaping] PRIMARY KEY CLUSTERED ([EventObjectMappingId] ASC) WITH (FILLFACTOR = 80)
);

