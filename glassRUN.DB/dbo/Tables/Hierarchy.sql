CREATE TABLE [dbo].[Hierarchy] (
    [HierarchyId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [HierarchyType]     BIGINT         NULL,
    [ParentCompanyId]   BIGINT         NULL,
    [ParentCompanyCode] NVARCHAR (100) NULL,
    [CompanyId]         BIGINT         NULL,
    [CompanyCode]       NVARCHAR (100) NULL,
    [SequenceNumber]    BIGINT         NULL,
    [EffetiveFromDate]  DATETIME       NULL,
    [EffectiveToDate]   DATETIME       NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [IsActive]          BIT            NOT NULL,
    [IsDefault]         BIT            NULL,
    [Rating]            BIGINT         NULL,
    CONSTRAINT [PK_Hierarchy] PRIMARY KEY CLUSTERED ([HierarchyId] ASC)
);

