CREATE TABLE [dbo].[NotificationRequest] (
    [NotificationRequestId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [EventNotificationId]     BIGINT          NOT NULL,
    [NotifcationType]         NVARCHAR (250)  NULL,
    [Title]                   NVARCHAR (2000) NULL,
    [BodyContent]             NVARCHAR (MAX)  NULL,
    [RecipientTo]             NVARCHAR (250)  NULL,
    [RecipientCC]             NVARCHAR (250)  NULL,
    [RecipientBCC]            NVARCHAR (250)  NULL,
    [MobileNumber]            NVARCHAR (250)  NULL,
    [DeviceToken]             NVARCHAR (250)  NULL,
    [DeviceType]              NVARCHAR (250)  NULL,
    [PushNotificationType]    NVARCHAR (250)  NULL,
    [Sound]                   NVARCHAR (250)  NULL,
    [Badge]                   NVARCHAR (250)  NULL,
    [LoginId]                 BIGINT          NULL,
    [IsValid]                 BIT             NULL,
    [IsSent]                  BIT             NULL,
    [IsSentDatetime]          DATETIME        NULL,
    [IsSentReason]            NVARCHAR (250)  NULL,
    [IsDelivered]             BIT             NULL,
    [IsDeliveredDatetime]     DATETIME        NULL,
    [IsDeliveredReason]       NVARCHAR (250)  NULL,
    [IsAck]                   BIT             NULL,
    [IsAckDatetime]           DATETIME        NULL,
    [RetryCount]              BIGINT          NULL,
    [PriorityType]            NVARCHAR (250)  NULL,
    [MessageId]               NVARCHAR (250)  NULL,
    [NotificationRequestGuid] NVARCHAR (250)  NULL,
    [IsActive]                BIT             NULL,
    [CreatedBy]               BIGINT          NULL,
    [CreatedDate]             DATETIME        NULL,
    [UpdatedDate]             DATETIME        NULL,
    [UpdatedBy]               BIGINT          NULL,
    CONSTRAINT [PK_NotificationRequest] PRIMARY KEY CLUSTERED ([NotificationRequestId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationRequest', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationRequest', @level2type = N'COLUMN', @level2name = N'CreatedBy';

