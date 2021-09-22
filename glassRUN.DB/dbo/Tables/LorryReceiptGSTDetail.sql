CREATE TABLE [dbo].[LorryReceiptGSTDetail] (
    [LorryReceiptGSTDetailId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderId]                 BIGINT         NULL,
    [GSTPaidBy]               NVARCHAR (250) NULL,
    [GSTNo]                   NVARCHAR (250) NULL,
    [CreatedBy]               BIGINT         NULL,
    [CreatedDate]             DATETIME       NULL,
    [ModifiedBy]              BIGINT         NULL,
    [ModifiedDate]            DATETIME       NULL,
    [IsActive]                BIT            NULL,
    [GSTPercentage]           BIGINT         NULL,
    CONSTRAINT [PK_LorryReceiptGSTDetail] PRIMARY KEY CLUSTERED ([LorryReceiptGSTDetailId] ASC)
);

