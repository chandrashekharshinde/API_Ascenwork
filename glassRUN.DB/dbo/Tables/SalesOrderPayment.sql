CREATE TABLE [dbo].[SalesOrderPayment] (
    [SalesOrderPaymentId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SalesOrderNumber]    NVARCHAR (250) NULL,
    [SalesOrderBillingId] BIGINT         NULL,
    [PaymentDate]         DATETIME       NULL,
    [ModeOfPaymentType]   BIGINT         NULL,
    [BankName]            NVARCHAR (250) NULL,
    [ReferenceNumber]     NVARCHAR (250) NULL,
    [PaymentAmount]       NVARCHAR (250) NULL,
    [Remarks]             NVARCHAR (250) NULL,
    CONSTRAINT [PK_SalesOrderPayment] PRIMARY KEY CLUSTERED ([SalesOrderPaymentId] ASC)
);

