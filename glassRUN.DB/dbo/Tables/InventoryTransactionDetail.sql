CREATE TABLE [dbo].[InventoryTransactionDetail] (
    [InventoryTransactionDetailId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [InventoryTransactionId]       BIGINT          NULL,
    [ProductCode]                  NVARCHAR (200)  NULL,
    [Quantity]                     DECIMAL (18, 2) NULL,
    [LocationType]                 NVARCHAR (150)  NULL,
    [LotNumber]                    NVARCHAR (250)  NULL,
    [CreatedBy]                    BIGINT          NOT NULL,
    [CreatedDate]                  DATETIME        NOT NULL,
    [ModifiedBy]                   BIGINT          NULL,
    [ModifiedDate]                 DATETIME        NULL,
    CONSTRAINT [PK_InventoryTransactionDetail] PRIMARY KEY CLUSTERED ([InventoryTransactionDetailId] ASC)
);

