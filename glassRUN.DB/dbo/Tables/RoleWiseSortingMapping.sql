CREATE TABLE [dbo].[RoleWiseSortingMapping] (
    [RoleWiseSortingMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [SortingParametersId]      BIGINT   NULL,
    [RoleMasterId]             BIGINT   NULL,
    [LoginId]                  BIGINT   NULL,
    [AccessId]                 INT      NULL,
    [CreatedBy]                BIGINT   NOT NULL,
    [CreatedDate]              DATETIME NOT NULL,
    [UpdatedBy]                BIGINT   NULL,
    [UpdatedDate]              DATETIME NULL,
    [IsActive]                 BIT      NOT NULL,
    CONSTRAINT [PK_RoleWiseSortingMappingId] PRIMARY KEY CLUSTERED ([RoleWiseSortingMappingId] ASC) WITH (FILLFACTOR = 80)
);

