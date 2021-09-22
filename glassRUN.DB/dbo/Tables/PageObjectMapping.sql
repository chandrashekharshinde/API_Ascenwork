CREATE TABLE [dbo].[PageObjectMapping] (
    [PageObjectMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PageId]              BIGINT   NULL,
    [ObjectId]            BIGINT   NULL,
    [IsGridPage]          BIT      NULL,
    [IsActive]            BIT      NOT NULL,
    [CreatedBy]           BIGINT   NOT NULL,
    [CreatedDate]         DATETIME NOT NULL,
    [ModifiedBy]          BIGINT   NULL,
    [ModifiedDate]        DATETIME NULL,
    CONSTRAINT [PK_PageObjectMapping] PRIMARY KEY CLUSTERED ([PageObjectMappingId] ASC) WITH (FILLFACTOR = 80)
);

