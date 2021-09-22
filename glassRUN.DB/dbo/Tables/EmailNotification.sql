CREATE TABLE [dbo].[EmailNotification] (
    [EmailNotificationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SupplierId]          BIGINT         NULL,
    [ObjectType]          NVARCHAR (250) NULL,
    [ObjectId]            NVARCHAR (250) NULL,
    [EventType]           NVARCHAR (250) NULL,
    [Password]            NVARCHAR (150) NULL,
    [SenderEmailAddress]  NVARCHAR (250) NULL,
    [IsSent]              BIT            NULL,
    [SenderId]            INT            NULL,
    [Message]             NVARCHAR (MAX) NULL,
    [MarkAsRead]          BIT            NULL,
    [IsActive]            BIT            NOT NULL,
    [CreatedBy]           BIGINT         NOT NULL,
    [CreatedDate]         DATETIME       NOT NULL,
    [UpdatedBy]           BIGINT         NULL,
    [UpdatedDate]         DATETIME       NULL,
    CONSTRAINT [PK_EmailNotification] PRIMARY KEY CLUSTERED ([EmailNotificationId] ASC) WITH (FILLFACTOR = 80)
);

