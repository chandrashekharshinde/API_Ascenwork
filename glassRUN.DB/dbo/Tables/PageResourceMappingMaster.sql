CREATE TABLE [dbo].[PageResourceMappingMaster] (
    [PageResourceMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [PageId]                BIGINT NOT NULL,
    [ResourceId]            BIGINT NOT NULL,
    CONSTRAINT [PK_PageResourceMappingMaster] PRIMARY KEY CLUSTERED ([PageResourceMappingId] ASC) WITH (FILLFACTOR = 80)
);

