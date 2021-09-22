CREATE TABLE [dbo].[GridColumnConfiguration] (
    [GridColumnConfigurationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]                    BIGINT         NULL,
    [LoginId]                   BIGINT         NULL,
    [ResourceId]                BIGINT         NULL,
    [ObjectId]                  BIGINT         NULL,
    [GridColumnId]              BIGINT         NULL,
    [PageId]                    BIGINT         NULL,
    [IsPinned]                  BIT            NULL,
    [IsAvailable]               BIT            NULL,
    [IsDefault]                 BIT            NULL,
    [IsMandatory]               BIT            NULL,
    [IsSystemMandatory]         BIT            NULL,
    [SequenceNumber]            BIGINT         NULL,
    [Description]               NVARCHAR (500) NULL,
    [IsDetailsViewAvailable]    BIT            NULL,
    [IsExportAvailable]         BIT            NULL,
    [IsGrouped]                 BIT            NULL,
    [GroupSequence]             BIGINT         NULL,
    [IsActive]                  BIT            NULL,
    [CreatedBy]                 BIGINT         NULL,
    [CreatedDate]               DATETIME       NULL,
    [UpdatedBy]                 BIGINT         NULL,
    [UpdatedDate]               DATETIME       NULL,
    [IPAddress]                 NVARCHAR (20)  NULL,
    CONSTRAINT [PK_GridColumnConfiguration] PRIMARY KEY CLUSTERED ([GridColumnConfigurationId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IDX_GridColumnConfiguration_RoleId]
    ON [dbo].[GridColumnConfiguration]([RoleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_GridColumnConfiguration_LoginId]
    ON [dbo].[GridColumnConfiguration]([LoginId] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_GridColumnConfiguration_PageId]
    ON [dbo].[GridColumnConfiguration]([PageId] ASC);

