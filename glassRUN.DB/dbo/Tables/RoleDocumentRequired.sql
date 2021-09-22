CREATE TABLE [dbo].[RoleDocumentRequired] (
    [RoleDocumentRequiredId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [DocumentTypeId]         BIGINT   NULL,
    [RoleId]                 BIGINT   NULL,
    [IsActive]               BIT      CONSTRAINT [DF_RoleDocumentRequired_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedDate]            DATETIME CONSTRAINT [DF_RoleDocumentRequired_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              BIGINT   NOT NULL,
    [UpdatedDate]            DATETIME NULL,
    [UpdatedBy]              BIGINT   NULL,
    CONSTRAINT [PK_RoleDocumentRequired] PRIMARY KEY CLUSTERED ([RoleDocumentRequiredId] ASC)
);

