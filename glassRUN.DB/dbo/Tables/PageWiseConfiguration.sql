CREATE TABLE [dbo].[PageWiseConfiguration] (
    [PageWiseConfigurationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageId]                  BIGINT         NULL,
    [RoleId]                  BIGINT         NULL,
    [UserId]                  BIGINT         NULL,
    [CompanyId]               BIGINT         NULL,
    [SettingName]             NVARCHAR (150) NULL,
    [SettingValue]            NVARCHAR (150) NULL,
    [IsActive]                BIT            NOT NULL,
    [CreatedBy]               BIGINT         NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [ModifiedBy]              BIGINT         NULL,
    [ModifiedDate]            DATETIME       NULL,
    CONSTRAINT [PK_PageWiseConfiguration] PRIMARY KEY CLUSTERED ([PageWiseConfigurationId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_PageWiseConfiguration_Pageid]
    ON [dbo].[PageWiseConfiguration]([PageId] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_PageWiseConfiguration_Roleid]
    ON [dbo].[PageWiseConfiguration]([RoleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_PageWiseConfiguration_Userid]
    ON [dbo].[PageWiseConfiguration]([UserId] ASC);

