CREATE TABLE [dbo].[NotificationRequestDetail] (
    [NotificationRequestDetailId] BIGINT         NOT NULL,
    [NotificationRequestId]       BIGINT         NULL,
    [CustomKey]                   NVARCHAR (250) NULL,
    [CustomValue]                 NVARCHAR (250) NULL
);

