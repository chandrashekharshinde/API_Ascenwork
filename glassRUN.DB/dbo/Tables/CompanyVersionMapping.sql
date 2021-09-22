CREATE TABLE [dbo].[CompanyVersionMapping] (
    [CompanyVersionMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [CompanyId]               BIGINT         NULL,
    [ObjectId]                BIGINT         NULL,
    [ObjectName]              NVARCHAR (150) NULL,
    [VersionNumber]           NVARCHAR (50)  NULL,
    [IsActive]                BIT            NOT NULL,
    [CreatedBy]               BIGINT         NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [ModifiedBy]              BIGINT         NULL,
    [ModifiedDate]            DATETIME       NULL,
    CONSTRAINT [PK_CompanyVersionMapping] PRIMARY KEY CLUSTERED ([CompanyVersionMappingId] ASC) WITH (FILLFACTOR = 80)
);

