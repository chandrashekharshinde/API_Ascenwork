CREATE TABLE [dbo].[PrinterBranchPlantMapping] (
    [PrinterBranchPlantMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [BranchPlantCode]             NVARCHAR (50)  NULL,
    [DocumentType]                NVARCHAR (200) NULL,
    [PrinterName]                 NVARCHAR (200) NULL,
    [PrinterPath]                 NVARCHAR (MAX) NULL,
    [NumberOfCopies]              BIGINT         NULL,
    [CreatedBy]                   BIGINT         NOT NULL,
    [CreatedDate]                 DATETIME       NOT NULL,
    [ModifiedBy]                  BIGINT         NULL,
    [ModifiedDate]                DATETIME       NULL,
    [IsActive]                    BIT            NOT NULL,
    CONSTRAINT [PK_PrinterBranchPlantMapping] PRIMARY KEY CLUSTERED ([PrinterBranchPlantMappingId] ASC) WITH (FILLFACTOR = 80)
);

