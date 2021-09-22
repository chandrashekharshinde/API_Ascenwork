CREATE TABLE [dbo].[SettingMaster] (
    [SettingMasterId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [SettingParameter] NVARCHAR (MAX) NULL,
    [SettingValue]     NVARCHAR (MAX) NULL,
    [CompanyId]        BIGINT         NULL,
    [DeliveryType]     BIGINT         NULL,
    [ProductType]      BIGINT         NULL,
    [Description]      NVARCHAR (500) NULL,
    [Version]          NVARCHAR (50)  NULL,
    [IsActive]         BIT            NOT NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_SettingMaster_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]        BIGINT         NOT NULL,
    [UpdatedDate]      DATETIME       NULL,
    [UpdatedBy]        BIGINT         NULL,
    [PageName]         NVARCHAR (250) NULL,
    [ControlType]      NVARCHAR (250) NULL,
    [PossibleValues]   NVARCHAR (250) NULL,
    [CompanyType]      BIGINT         NULL,
    CONSTRAINT [PK_SettingMaster] PRIMARY KEY CLUSTERED ([SettingMasterId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SettingMaster', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SettingMaster', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SettingMaster', @level2type = N'COLUMN', @level2name = N'CreatedBy';

