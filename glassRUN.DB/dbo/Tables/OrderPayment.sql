CREATE TABLE [dbo].[OrderPayment] (
    [OrderPaymentId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderNumber]      NVARCHAR (50)   NULL,
    [UserId]           BIGINT          NULL,
    [CollectedAmount]  DECIMAL (18, 2) NULL,
    [TotalAmount]      DECIMAL (18, 2) NULL,
    [CustomerCode]     NVARCHAR (50)   NULL,
    [SoldTo]           BIGINT          NULL,
    [ShipTo]           BIGINT          NULL,
    [StockLocationId]  BIGINT          NULL,
    [DeliveryDateTime] DATETIME        NULL,
    [RunNumber]        NVARCHAR (50)   NULL,
    [CreatedBy]        BIGINT          NOT NULL,
    [CreatedDate]      DATETIME        NOT NULL,
    [ModifiedBy]       BIGINT          NULL,
    [ModifiedDate]     DATETIME        NULL,
    [IsActive]         BIT             NOT NULL,
    [IsApproved]       BIT             NULL,
    [IsReceiptCreated] BIT             NULL,
    CONSTRAINT [PK_OrderPayment] PRIMARY KEY CLUSTERED ([OrderPaymentId] ASC)
);

