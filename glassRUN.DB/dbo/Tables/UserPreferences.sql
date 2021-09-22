CREATE TABLE [dbo].[UserPreferences] (
    [UserPreferencesId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserPreferencesKey]   NVARCHAR (500) NULL,
    [CompanyId]            BIGINT         NULL,
    [UserPreferencesValue] NVARCHAR (500) NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_UserPreferences_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED ([UserPreferencesId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPreferences', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPreferences', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPreferences', @level2type = N'COLUMN', @level2name = N'CreatedBy';

