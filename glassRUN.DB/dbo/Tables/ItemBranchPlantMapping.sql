CREATE TABLE [dbo].[ItemBranchPlantMapping] (
    [ItemBranchPlantMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [BranchPlantId]            BIGINT   NULL,
    [ItemId]                   BIGINT   NULL,
    [IsActive]                 BIT      NOT NULL,
    [CreatedBy]                BIGINT   NOT NULL,
    [CreatedDate]              DATETIME NOT NULL,
    [ModifiedBy]               BIGINT   NULL,
    [ModifiedDate]             DATETIME NULL,
    CONSTRAINT [PK_ItemBranchPlantMapping] PRIMARY KEY CLUSTERED ([ItemBranchPlantMappingId] ASC)
);

