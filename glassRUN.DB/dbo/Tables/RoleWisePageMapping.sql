CREATE TABLE [dbo].[RoleWisePageMapping] (
    [RoleWisePageMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [PageId]                BIGINT   NULL,
    [RoleMasterId]          BIGINT   NULL,
    [LoginId]               BIGINT   NULL,
    [AccessId]              INT      NULL,
    [CreatedBy]             BIGINT   NOT NULL,
    [CreatedDate]           DATETIME NOT NULL,
    [ModifiedBy]            BIGINT   NULL,
    [ModifiedDate]          DATETIME NULL,
    [IsActive]              BIT      NOT NULL,
    CONSTRAINT [PK_RoleWisePageMapping] PRIMARY KEY CLUSTERED ([RoleWisePageMappingId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idx_rolewisepagemapping_roleid]
    ON [dbo].[RoleWisePageMapping]([RoleMasterId] ASC);

