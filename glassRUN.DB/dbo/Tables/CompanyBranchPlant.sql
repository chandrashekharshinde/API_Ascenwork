CREATE TABLE [dbo].[CompanyBranchPlant] (
    [CompanyBranchPlantId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]            BIGINT        NULL,
    [BranchPlantId]        BIGINT        NULL,
    [LocationName]         NVARCHAR (50) NULL,
    [IsActive]             BIT           NULL,
    [CreatedBy]            BIGINT        NOT NULL,
    [CreatedDate]          DATETIME      NULL,
    [UpdatedBy]            BIGINT        NULL,
    [UpdatedDate]          DATETIME      NULL,
    CONSTRAINT [PK_CompenyBranchPlant] PRIMARY KEY CLUSTERED ([CompanyBranchPlantId] ASC)
);

