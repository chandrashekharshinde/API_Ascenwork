CREATE TABLE [dbo].[ItemBranchPlant] (
    [ItemBranchPlantID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ItemCode]          NVARCHAR (200) NULL,
    [BranchPlantCode]   NVARCHAR (200) NULL,
    [LocationCode]      NVARCHAR (200) NULL,
    [SubLocationCode]   NVARCHAR (200) NULL,
    [CompanyID]         BIGINT         NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [IsActive]          BIT            NOT NULL,
    CONSTRAINT [PK_ItemBranchPlant] PRIMARY KEY CLUSTERED ([ItemBranchPlantID] ASC)
);

