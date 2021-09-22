CREATE TABLE [dbo].[NotificationTypeMaster] (
    [NotificationTypeMasterId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [NotificationType]         NVARCHAR (250) NULL,
    [NotificationDescription]  NVARCHAR (250) NULL,
    [IsActive]                 BIT            NOT NULL,
    [CreatedBy]                BIGINT         NOT NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedBy]                BIGINT         NULL,
    [UpdatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_NotificationTypeMaster] PRIMARY KEY CLUSTERED ([NotificationTypeMasterId] ASC)
);

