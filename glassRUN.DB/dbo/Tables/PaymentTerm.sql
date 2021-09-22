CREATE TABLE [dbo].[PaymentTerm] (
    [PaymentTermId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [PaymentTermName] NVARCHAR (50) NULL,
    [PaymentTermCode] NCHAR (10)    NULL,
    [IsActive]        BIT           NULL,
    [CreatedBy]       BIGINT        NOT NULL,
    [CreatedDate]     DATETIME      NOT NULL,
    [UpadatedBy]      BIGINT        NULL,
    [UpdatedDate]     DATETIME      NULL,
    CONSTRAINT [PK_PaymentTerm] PRIMARY KEY CLUSTERED ([PaymentTermId] ASC)
);

