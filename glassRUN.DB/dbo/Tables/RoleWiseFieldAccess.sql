CREATE TABLE [dbo].[RoleWiseFieldAccess] (
    [RoleWiseFieldAccessId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]                BIGINT         NOT NULL,
    [LoginId]               BIGINT         NULL,
    [ResourceId]            BIGINT         NULL,
    [PageId]                BIGINT         NOT NULL,
    [ObjectPropertiesId]    BIGINT         NULL,
    [PageControlId]         BIGINT         NULL,
    [IsMandatory]           BIT            NULL,
    [IsVisible]             BIT            NULL,
    [ValidationExpression]  NVARCHAR (50)  NULL,
    [Description]           NVARCHAR (500) NULL,
    [AccessId]              INT            NULL,
    [IsActive]              BIT            NULL,
    [CreatedBy]             BIGINT         NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             BIGINT         NULL,
    [UpdatedDate]           DATETIME       NULL,
    [IPAddress]             NVARCHAR (20)  NULL,
    CONSTRAINT [PK_RoleWiseFieldAccess] PRIMARY KEY CLUSTERED ([RoleWiseFieldAccessId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [ID_PageConfiguration_RoleID]
    ON [dbo].[RoleWiseFieldAccess]([RoleId] ASC, [LoginId] ASC);


GO
CREATE NONCLUSTERED INDEX [ID_RoleWiseFieldAccess_PageId]
    ON [dbo].[RoleWiseFieldAccess]([PageId] ASC);


GO
CREATE NONCLUSTERED INDEX [ID_RoleWiseFieldAccess_PageControlD]
    ON [dbo].[RoleWiseFieldAccess]([PageControlId] ASC);

