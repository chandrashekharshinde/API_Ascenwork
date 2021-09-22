CREATE TABLE [dbo].[PageFilterMapping] (
    [PageFilterMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PageId]              BIGINT   NULL,
    [FilterMasterId]      BIGINT   NULL,
    [IsActive]            BIT      NULL,
    [CreatedBy]           BIGINT   NULL,
    [CreatedDate]         DATETIME NULL,
    [UpdatedBy]           BIGINT   NULL,
    [UpdatedDate]         DATETIME NULL,
    CONSTRAINT [PK_PageFilterMapping] PRIMARY KEY CLUSTERED ([PageFilterMappingId] ASC)
);

