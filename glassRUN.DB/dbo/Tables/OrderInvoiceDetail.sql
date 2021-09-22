CREATE TABLE [dbo].[OrderInvoiceDetail] (
    [OrderInvoiceDetailId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]              BIGINT          NOT NULL,
    [InvoiceNo]            NVARCHAR (250)  NULL,
    [InvoiceDate]          DATETIME        NULL,
    [InvoiceValue]         DECIMAL (18, 2) NULL,
    [DeclaredValue]        DECIMAL (18, 2) NULL,
    [EWayBillNo]           NVARCHAR (250)  NULL,
    [CreatedBy]            BIGINT          NULL,
    [CreatedDate]          DATETIME        NULL,
    [ModifiedBy]           BIGINT          NULL,
    [ModifiedDate]         DATETIME        NULL,
    [IsActive]             BIT             NULL,
    CONSTRAINT [PK_OrderInvoiceDetail] PRIMARY KEY CLUSTERED ([OrderInvoiceDetailId] ASC)
);

