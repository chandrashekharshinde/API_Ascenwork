CREATE TABLE [dbo].[UnitOfMeasure] (
    [UnitOfMeasureId]                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [ItemId]                             BIGINT          NULL,
    [UOM]                                BIGINT          NULL,
    [RelatedUOM]                         BIGINT          NULL,
    [UOMStructure]                       NVARCHAR (50)   NULL,
    [ConversionFactor]                   NUMERIC (18, 6) NULL,
    [ConversionFactorSecondaryToPrimary] NUMERIC (18, 6) NULL,
    [UpdatedDate]                        DATETIME        NULL,
    [IsActive]                           BIT             NULL,
    CONSTRAINT [PK_UnitOfMeasure] PRIMARY KEY CLUSTERED ([UnitOfMeasureId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_UnitOfMeasure_LookUp] FOREIGN KEY ([RelatedUOM]) REFERENCES [dbo].[LookUp] ([LookUpId]),
    CONSTRAINT [FK_UnitOfMeasure_UnitOfMeasure] FOREIGN KEY ([UOM]) REFERENCES [dbo].[LookUp] ([LookUpId])
);

