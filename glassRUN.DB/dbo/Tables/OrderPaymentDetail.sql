CREATE TABLE [dbo].[OrderPaymentDetail] (
    [OrderPaymentDetailId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderPaymentId]       BIGINT          NULL,
    [ItemId]               BIGINT          NULL,
    [TotalBuybackAmount]   DECIMAL (10, 2) NULL,
    [TotalBuybackQuantity] DECIMAL (10, 2) NULL,
    [UOM]                  NVARCHAR (50)   NULL,
    [IsActive]             BIT             NULL,
    [CreatedBy]            BIGINT          NULL,
    [CreatedDate]          DATETIME        NULL,
    [ModifiedBy]           BIGINT          NULL,
    [ModifiedDate]         DATETIME        NULL,
    CONSTRAINT [PK_OrderPaymentDetail] PRIMARY KEY CLUSTERED ([OrderPaymentDetailId] ASC)
);

