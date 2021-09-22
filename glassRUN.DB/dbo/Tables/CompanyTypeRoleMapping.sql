CREATE TABLE [dbo].[CompanyTypeRoleMapping] (
    [CompanyTypeRoleMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [CompanyType]              BIGINT   NULL,
    [RoleId]                   BIGINT   NULL,
    [IsActive]                 BIT      NOT NULL,
    [CreatedBy]                BIGINT   NOT NULL,
    [CreatedDate]              DATETIME NOT NULL,
    [UpdatedBy]                BIGINT   NULL,
    [UpdatedDate]              DATETIME NULL,
    CONSTRAINT [PK_RelatedRoleMapping] PRIMARY KEY CLUSTERED ([CompanyTypeRoleMappingId] ASC)
);

