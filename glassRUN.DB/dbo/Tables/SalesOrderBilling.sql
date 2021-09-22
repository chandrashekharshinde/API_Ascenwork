CREATE TABLE [dbo].[SalesOrderBilling] (
    [SalesOrderBillingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SalesOrderNumber]    NVARCHAR (250) NULL,
    [InvoiceAmount]       NVARCHAR (250) NULL,
    [BillingDate]         DATETIME       NULL,
    [InvoiceNumber]       NVARCHAR (250) NULL,
    [Remarks]             NVARCHAR (250) NULL,
    CONSTRAINT [PK_SalesOrderBilling] PRIMARY KEY CLUSTERED ([SalesOrderBillingId] ASC)
);

