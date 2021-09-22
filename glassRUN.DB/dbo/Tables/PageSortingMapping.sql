CREATE TABLE [dbo].[PageSortingMapping] (
    [PageSortingMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PageId]               BIGINT   NULL,
    [SortingParametersId]  BIGINT   NULL,
    [IsActive]             BIT      NULL,
    [CreatedBy]            BIGINT   NULL,
    [CreatedDate]          DATETIME NULL,
    [UpdatedBy]            BIGINT   NULL,
    [UpdatedDate]          DATETIME NULL,
    CONSTRAINT [PK_PageSortingMapping] PRIMARY KEY CLUSTERED ([PageSortingMappingId] ASC)
);

