CREATE TABLE [dbo].[EntityRelationship] (
    [EntityRelationshipId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [PrimaryEntity]          BIGINT         NOT NULL,
    [RelatedEntity]          BIGINT         NULL,
    [RelationshipPurpose]    BIGINT         NOT NULL,
    [RuleId]                 BIGINT         NULL,
    [CompanyTypeId]          BIGINT         NULL,
    [FromDate]               DATETIME       NULL,
    [ToDate]                 DATETIME       NULL,
    [EntityRelationshipGUID] NVARCHAR (100) NULL,
    [IsActive]               BIT            NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [CreatedBy]              BIGINT         NULL,
    CONSTRAINT [PK_EntityRelationship] PRIMARY KEY CLUSTERED ([EntityRelationshipId] ASC)
);

