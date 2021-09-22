CREATE TABLE [dbo].[ItemStock] (
    [ItemStockId]           BIGINT          IDENTITY (1, 1) NOT NULL,
    [ItemCode]              NVARCHAR (250)  NULL,
    [DeliveryLocationCode]  NVARCHAR (250)  NULL,
    [ItemQuantity]          FLOAT (53)      NULL,
    [LocationCode]          NVARCHAR (50)   NULL,
    [LotNumber]             NVARCHAR (250)  NULL,
    [SubLocationCode]       NVARCHAR (250)  NULL,
    [QuantityOnHand]        NUMERIC (18, 2) NULL,
    [QuantitySoftCommitted] NUMERIC (18, 2) NULL,
    [QuantityHardCommitted] NUMERIC (18, 2) NULL,
    [QuantityInTransit]     NUMERIC (18, 2) NULL,
    [QuantityInInspection]  NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_ItemStock] PRIMARY KEY CLUSTERED ([ItemStockId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IDX_ItemStock_DeliveryLocationCode]
    ON [dbo].[ItemStock]([DeliveryLocationCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ItemStock_ItemCode]
    ON [dbo].[ItemStock]([ItemCode] ASC);

