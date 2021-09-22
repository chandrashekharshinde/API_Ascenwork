CREATE TABLE [dbo].[RoleMaster] (
    [RoleMasterId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleName]             NVARCHAR (50)  NULL,
    [UserTypeCode]         NVARCHAR (50)  NULL,
    [Description]          NVARCHAR (MAX) NULL,
    [PolicyName]           NVARCHAR (150) NULL,
    [RoleParentId]         BIGINT         NULL,
    [PageUrl]              NVARCHAR (500) NULL,
    [PageName]             NVARCHAR (500) NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedFromIPAddress] NVARCHAR (20)  NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedFromIPAddress] NVARCHAR (20)  NULL,
    CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED ([RoleMasterId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used in Licensing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RoleMaster', @level2type = N'COLUMN', @level2name = N'UserTypeCode';

