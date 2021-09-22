CREATE TABLE [dbo].[RoleWiseFilterMapping] (
    [RoleWiseFilterMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [FilterMasterId]          BIGINT   NULL,
    [RoleMasterId]            BIGINT   NULL,
    [LoginId]                 BIGINT   NULL,
    [AccessId]                INT      NULL,
    [CreatedBy]               BIGINT   NOT NULL,
    [CreatedDate]             DATETIME NOT NULL,
    [UpdatedBy]               BIGINT   NULL,
    [UpdatedDate]             DATETIME NULL,
    [IsActive]                BIT      NOT NULL,
    CONSTRAINT [PK_RoleWiseFilterMapping] PRIMARY KEY CLUSTERED ([RoleWiseFilterMappingId] ASC) WITH (FILLFACTOR = 80)
);

