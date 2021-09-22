CREATE TABLE [dbo].[RoleWiseStatus] (
    [RoleWiseStatusId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]           BIGINT         NULL,
    [StatusId]         BIGINT         NULL,
    [ResourceKey]      NVARCHAR (100) NULL,
    [Class]            NVARCHAR (50)  NULL,
    [IsActive]         BIT            NULL,
    CONSTRAINT [PK_RoleWiseStatus] PRIMARY KEY CLUSTERED ([RoleWiseStatusId] ASC) WITH (FILLFACTOR = 80)
);

