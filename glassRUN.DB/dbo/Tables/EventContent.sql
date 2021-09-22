CREATE TABLE [dbo].[EventContent] (
    [EventContentId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventMasterId]            BIGINT         NULL,
    [EventCode]                NVARCHAR (250) NOT NULL,
    [NotificationTypeMasterId] BIGINT         NULL,
    [NotificationType]         NVARCHAR (250) NOT NULL,
    [Title]                    NVARCHAR (250) NULL,
    [BodyContent]              NVARCHAR (MAX) NULL,
    [PriorityTypeMasterId]     BIT            NULL,
    [PriorityTypeCode]         NVARCHAR (250) NULL,
    [IsActive]                 BIT            NOT NULL,
    [CreatedBy]                BIGINT         NOT NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedBy]                BIGINT         NULL,
    [UpdatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_EventContent] PRIMARY KEY CLUSTERED ([EventContentId] ASC)
);

