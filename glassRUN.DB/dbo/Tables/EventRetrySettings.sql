CREATE TABLE [dbo].[EventRetrySettings] (
    [EventRetrySettingsId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventMasterId]            BIGINT         NULL,
    [NotificationTypeMasterId] BIGINT         NULL,
    [NotificationType]         NVARCHAR (MAX) NULL,
    [RetryCount]               BIGINT         NULL,
    [RetryInterval]            BIGINT         NULL,
    [IsActive]                 BIT            NOT NULL,
    [Createdby]                BIGINT         NOT NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedBy]                BIGINT         NULL,
    [UpdatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_EventRetrySettings] PRIMARY KEY CLUSTERED ([EventRetrySettingsId] ASC)
);

