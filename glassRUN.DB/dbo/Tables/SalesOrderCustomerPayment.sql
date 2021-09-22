CREATE TABLE [dbo].[SalesOrderCustomerPayment] (
    [SalesOrderCustomerPaymentId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SalesOrderNumber]            NVARCHAR (250) NOT NULL,
    [Amount]                      NVARCHAR (250) NULL,
    [IsBilled]                    BIT            NULL,
    [BilledReason]                NVARCHAR (250) NULL,
    [IsPaid]                      BIT            NULL,
    [PaidReason]                  NVARCHAR (250) NULL,
    [IsActive]                    BIT            NULL,
    [CreatedBy]                   BIGINT         NULL,
    [CreatedDate]                 DATETIME       NULL,
    [ModifiedBy]                  BIGINT         NULL,
    [ModifiedDate]                DATETIME       NULL,
    CONSTRAINT [PK_SalesOrderCustomerPayment] PRIMARY KEY CLUSTERED ([SalesOrderCustomerPaymentId] ASC)
);

