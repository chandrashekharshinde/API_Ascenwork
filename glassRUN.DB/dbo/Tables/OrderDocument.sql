CREATE TABLE [dbo].[OrderDocument] (
    [OrderDocumentId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderId]             BIGINT         NULL,
    [OrderProductId]      BIGINT         NULL,
    [DocumentTypeId]      INT            NULL,
    [DocumentDescription] NVARCHAR (MAX) NULL,
    [DocumentFormat]      NVARCHAR (50)  NULL,
    [DocumentBlob]        NVARCHAR (MAX) NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_OrderDocument_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_OrderDocument] PRIMARY KEY CLUSTERED ([OrderDocumentId] ASC) WITH (FILLFACTOR = 80)
);

