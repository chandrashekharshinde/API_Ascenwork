CREATE TABLE [dbo].[OrderProduct] (
    [OrderProductId]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [CompanyId]                  BIGINT          NULL,
    [CompanyCode]                NVARCHAR (250)  NULL,
    [OrderId]                    BIGINT          NOT NULL,
    [OrderNumber]                NVARCHAR (100)  NULL,
    [ProductCode]                NVARCHAR (200)  NULL,
    [ProductName]                NVARCHAR (250)  NULL,
    [ParentProductCode]          NVARCHAR (250)  NULL,
    [ProductType]                NVARCHAR (200)  NOT NULL,
    [ProductQuantity]            DECIMAL (10, 2) NULL,
    [UnitPrice]                  DECIMAL (18, 4) NULL,
    [TotalUnitPrice]             DECIMAL (18, 4) NULL,
    [EffectiveDate]              DATETIME        NULL,
    [DepositeAmount]             DECIMAL (10, 2) NULL,
    [ShippableQuantity]          DECIMAL (10, 2) NULL,
    [BackOrderQuantity]          DECIMAL (10, 2) NULL,
    [CancelledQuantity]          DECIMAL (10, 2) NULL,
    [ReturnQuantity]             DECIMAL (10, 2) NULL,
    [AssociatedOrder]            NVARCHAR (100)  NULL,
    [ItemType]                   BIGINT          NULL,
    [Remarks]                    NVARCHAR (MAX)  NULL,
    [CreatedBy]                  BIGINT          NOT NULL,
    [CreatedDate]                DATETIME        NOT NULL,
    [ModifiedBy]                 BIGINT          NULL,
    [ModifiedDate]               DATETIME        NULL,
    [IsActive]                   BIT             NOT NULL,
    [LineNumber]                 BIGINT          NULL,
    [InvoiceNumber]              NVARCHAR (150)  NULL,
    [Field1]                     NVARCHAR (500)  NULL,
    [Field2]                     NVARCHAR (500)  NULL,
    [Field3]                     NVARCHAR (500)  NULL,
    [Field4]                     NVARCHAR (500)  NULL,
    [Field5]                     NVARCHAR (500)  NULL,
    [Field6]                     NVARCHAR (500)  NULL,
    [Field7]                     NVARCHAR (500)  NULL,
    [Field8]                     NVARCHAR (500)  NULL,
    [Field9]                     NVARCHAR (500)  NULL,
    [Field10]                    NVARCHAR (500)  NULL,
    [DiscountPercent]            DECIMAL (18, 2) NULL,
    [DiscountAmount]             DECIMAL (18, 2) NULL,
    [IsProductShipConfirmed]     BIT             NULL,
    [ReferenceOrderId]           BIGINT          NULL,
    [ReferenceOrderProductId]    BIGINT          NULL,
    [OrderProductGuid]           NVARCHAR (350)  NULL,
    [PalletNumber]               NVARCHAR (250)  NULL,
    [ReplacementParentProductId] BIGINT          NULL,
    [IsReplaceable]              BIT             NULL,
    [LotNumber]                  NVARCHAR (250)  NULL,
    [CollectedQuantity]          DECIMAL (18, 2) NULL,
    [DeliveredQuantity]          DECIMAL (18, 2) NULL,
    [LastStatus]                 BIGINT          NULL,
    [NextStatus]                 BIGINT          NULL,
    [StockLocationCode]          NVARCHAR (250)  NULL,
    [StockLocationName]          NVARCHAR (250)  NULL,
    [TotalVolume]                DECIMAL (18, 2) NULL,
    [TotalWeight]                DECIMAL (18, 2) NULL,
    [IsGRN]                      BIT             NULL,
    [SignalValue]                BIGINT          NULL,
    [PackingItemCount]           DECIMAL (18, 2) NULL,
    [PackingItemCode]            NVARCHAR (200)  NULL,
    [IsPackingItem]              BIT             NULL,
    [UOM]                        VARCHAR(50)     NULL   
    CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED ([OrderProductId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId])
);


GO
CREATE NONCLUSTERED INDEX [IDX_OrderProduct_Order]
    ON [dbo].[OrderProduct]([OrderId] ASC, [IsActive] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_OrderProduct_OrderProductCode]
    ON [dbo].[OrderProduct]([ProductCode] ASC);


GO
CREATE NONCLUSTERED INDEX [Index_OrderProduct_Ordergrid]
    ON [dbo].[OrderProduct]([ProductCode] ASC)
    INCLUDE([OrderId], [ProductQuantity]);

