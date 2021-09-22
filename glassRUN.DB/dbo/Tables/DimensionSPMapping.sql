CREATE TABLE [dbo].[DimensionSPMapping] (
    [DimensionSPMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [DimensionName]        NVARCHAR (50)  NULL,
    [SPName]               NVARCHAR (250) NULL,
    [PageName]             NVARCHAR (250) NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    CONSTRAINT [PK_DimensionSPMapping] PRIMARY KEY CLUSTERED ([DimensionSPMappingId] ASC) WITH (FILLFACTOR = 80)
);

