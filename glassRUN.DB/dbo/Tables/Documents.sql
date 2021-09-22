CREATE TABLE [dbo].[Documents] (
    [DocumentsId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [DocumentName]      NVARCHAR (50)  NULL,
    [DocumentExtension] NVARCHAR (50)  NULL,
    [DocumentBase64]    NVARCHAR (MAX) NULL,
    [ObjectId]          BIGINT         NULL,
    [ObjectType]        NVARCHAR (50)  NULL,
    [SequenceNo]        BIGINT         NULL,
    [IsActive]          BIT            NOT NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [DocumentTypeId]    BIGINT         NULL,
    CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED ([DocumentsId] ASC) WITH (FILLFACTOR = 80)
);

