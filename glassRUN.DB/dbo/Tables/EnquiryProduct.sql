CREATE TABLE [dbo].[EnquiryProduct] (
    [EnquiryProductId]           BIGINT          IDENTITY (1, 1) NOT NULL,
    [CompanyId]                  BIGINT          CONSTRAINT [DF_EnquiryProduct_CompanyId] DEFAULT ((0)) NULL,
    [CompanyCode]                NVARCHAR (250)  NULL,
    [EnquiryId]                  BIGINT          CONSTRAINT [DF_EnquiryProduct_EnquiryId] DEFAULT ((0)) NOT NULL,
    [ItemID]                     BIGINT,   
    [ProductCode]                NVARCHAR (200)  NOT NULL,
    [ProductName]                NVARCHAR (250)  NULL,
    [ParentItemId]               BIGINT,
    [ParentProductCode]          NVARCHAR (200)  NULL,
    [ProductType]                NVARCHAR (200)  NOT NULL,
    [ProductQuantity]            DECIMAL (10, 2) NOT NULL,
    [AvailableQuantity]          DECIMAL (10, 2) NULL DEFAULT 0,
    [DepositeAmount]             DECIMAL (18, 4) NULL DEFAULT 0,
    [Remarks]                    NVARCHAR (MAX)  NULL,
    [AssociatedOrder]            NVARCHAR (100)  NULL,
    [EffectiveDate]              DATETIME        NULL,
    [Price]                      DECIMAL (18, 4) NULL DEFAULT 0,
    [UnitPrice]                  DECIMAL (18, 4) NULL DEFAULT 0,
    [TotalUnitPrice]             DECIMAL (18, 4) NULL DEFAULT 0,
    [CurrentStockPosition]       BIGINT          CONSTRAINT [DF_EnquiryProduct_CurrentStockPosition] DEFAULT ((0)) NULL,
    [CreatedBy]                  BIGINT          NOT NULL,
    [CreatedDate]                DATETIME        NOT NULL,
    [ModifiedBy]                 BIGINT          NULL,
    [ModifiedDate]               DATETIME        NULL,
    [ItemType]                   BIGINT          CONSTRAINT [DF_EnquiryProduct_ItemType] DEFAULT ((0)) NULL,
    [IsActive]                   BIT             NOT NULL,
    [NumberOfExtraPallet]        INT             NULL DEFAULT 0,
    [SequenceNo]                 BIGINT          CONSTRAINT [DF_EnquiryProduct_SequenceNo] DEFAULT ((0)) NULL,
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
    [DiscountPercent]            DECIMAL (18, 2) NULL DEFAULT 0,
    [DiscountAmount]             DECIMAL (18, 2) NULL DEFAULT 0,
    [PaymentType]                BIGINT          CONSTRAINT [DF_EnquiryProduct_PaymentType] DEFAULT ((0)) NULL,
    [ReplacementParentProductId] BIGINT          CONSTRAINT [DF_EnquiryProduct_ReplacementParentProductId] DEFAULT ((0)) NULL,
    [IsReplaceable]              BIT             NULL,
    [LastStatus]                 BIGINT          CONSTRAINT [DF_EnquiryProduct_LastStatus] DEFAULT ((0)) NULL,
    [NextStatus]                 BIGINT          CONSTRAINT [DF_EnquiryProduct_NextStatus] DEFAULT ((0)) NULL,
    [StockLocationCode]          NVARCHAR (250)  NULL,
    [StockLocationName]          NVARCHAR (250)  NULL,
    [TotalVolume]                DECIMAL (18, 2) NULL DEFAULT 0,
    [TotalWeight]                DECIMAL (18, 2) NULL DEFAULT 0,
    [CollectionLocationCode]     NVARCHAR (50)   NULL,
    [PackingItemCount]           DECIMAL (18, 2) NULL DEFAULT 0,
    [PackingItemCode]            NVARCHAR (200)  NULL,
    [IsPackingItem]              BIT             NULL,
    [EnquiryAutoNumber]          NVARCHAR (100)  NULL,
    [UOM]                        NVARCHAR (50)   NULL,
    CONSTRAINT [PK_EnquiryProduct] PRIMARY KEY CLUSTERED ([EnquiryProductId] ASC),
    CONSTRAINT [FK_EnquiryProduct_Enquiry] FOREIGN KEY ([EnquiryId]) REFERENCES [dbo].[Enquiry] ([EnquiryId])
);


GO
CREATE NONCLUSTERED INDEX [IDX_EnquiryProduct_EnquiryId]
    ON [dbo].[EnquiryProduct]([EnquiryId] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_EnquiryProduct_ProductCode]
    ON [dbo].[EnquiryProduct]([ProductCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IndexEnquiryProduct]
    ON [dbo].[EnquiryProduct]([ProductCode] ASC)
    INCLUDE([EnquiryId], [ProductQuantity]);

