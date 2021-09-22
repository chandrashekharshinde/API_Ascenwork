CREATE TABLE [dbo].[EventDocument] (
    [EventDocumentId]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventContentId]           BIGINT         NULL,
    [EventMasterId]            BIGINT         NULL,
    [EventCode]                NVARCHAR (250) NOT NULL,
    [NotificationTypeMasterId] BIGINT         NULL,
    [NotificationType]         NVARCHAR (250) NOT NULL,
    [DocumentTypeId]           BIGINT         NULL,
    [DocumentType]             NVARCHAR (250) NULL,
    [Remarks]                  NVARCHAR (250) NULL,
    [IsActive]                 BIT            NOT NULL,
    [CreatedBy]                BIGINT         NOT NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedBy]                BIGINT         NULL,
    [UpdatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_EventDocument] PRIMARY KEY CLUSTERED ([EventDocumentId] ASC)
);

