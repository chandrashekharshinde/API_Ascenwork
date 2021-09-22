CREATE TABLE [dbo].[EventRecipient] (
    [EventRecipientId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventContentId]           BIGINT         NULL,
    [EventMasterId]            BIGINT         NULL,
    [EventCode]                NVARCHAR (250) NOT NULL,
    [NotificationTypeMasterId] BIGINT         NULL,
    [NotificationType]         NVARCHAR (250) NOT NULL,
    [RecipientType]            NVARCHAR (250) NULL,
    [Recipient]                NVARCHAR (250) NULL,
    [RoleMasterId]             BIGINT         NULL,
    [UserId]                   BIGINT         NULL,
    [IsSpecific]               BIT            NULL,
    [IsActive]                 BIT            NOT NULL,
    [CreatedBy]                BIGINT         NOT NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedBy]                BIGINT         NULL,
    [UpdatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_EventRecipient] PRIMARY KEY CLUSTERED ([EventRecipientId] ASC)
);

