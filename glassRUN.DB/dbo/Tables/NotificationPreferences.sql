CREATE TABLE [dbo].[NotificationPreferences] (
    [NotificationPreferencesId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]                 BIGINT        NULL,
    [UserName]                  NVARCHAR (50) NULL,
    [EventMasterId]             BIGINT        NULL,
    [Notification]              BIT           NULL,
    [IsActive]                  BIT           NULL,
    [CreatedDate]               DATETIME      NULL,
    [CreatedBy]                 BIGINT        NULL,
    [ModifiedDate]              DATETIME      NULL,
    [ModifiedBy]                BIGINT        NULL,
    CONSTRAINT [PK_NotificationPreferences] PRIMARY KEY CLUSTERED ([NotificationPreferencesId] ASC)
);

