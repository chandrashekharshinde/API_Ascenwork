CREATE TABLE [dbo].[EventNotification] (
    [EventNotificationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventMasterId]       BIGINT         NULL,
    [EventCode]           NVARCHAR (250) NULL,
    [ObjectId]            BIGINT         NULL,
    [ObjectType]          NVARCHAR (250) NULL,
    [IsCreated]           BIT            NULL,
    [IsActive]            BIT            NULL,
    [CreatedBy]           BIGINT         NULL,
    [CreatedDate]         DATETIME       NULL,
    [UpdatedDate]         DATETIME       NULL,
    [UpdatedBy]           BIGINT         NULL,
    CONSTRAINT [PK_EventDetail_1] PRIMARY KEY CLUSTERED ([EventNotificationId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventNotification', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventNotification', @level2type = N'COLUMN', @level2name = N'CreatedBy';

