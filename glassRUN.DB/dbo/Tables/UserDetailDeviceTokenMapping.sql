CREATE TABLE [dbo].[UserDetailDeviceTokenMapping] (
    [UserDetailDeviceTokenMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]                         BIGINT         NOT NULL,
    [DeviceType]                     NVARCHAR (150) NOT NULL,
    [DeviceToken]                    NVARCHAR (550) NOT NULL,
    [IsExpired]                      BIT            NULL,
    [IsActive]                       BIT            NULL,
    [VendorId]                       NVARCHAR (250) NULL,
    [PushNotificationType]           NVARCHAR (250) NULL,
    [CreatedDate]                    DATETIME       CONSTRAINT [DF_UserDetailDeviceTokenMapping_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]                      BIGINT         NULL,
    [UpdatedDate]                    DATETIME       NULL,
    [UpdatedBy]                      BIGINT         NULL,
    CONSTRAINT [PK_UserDetailDeviceTokenMapping] PRIMARY KEY CLUSTERED ([UserDetailDeviceTokenMappingId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserDetailDeviceTokenMapping', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserDetailDeviceTokenMapping', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserDetailDeviceTokenMapping', @level2type = N'COLUMN', @level2name = N'CreatedBy';

