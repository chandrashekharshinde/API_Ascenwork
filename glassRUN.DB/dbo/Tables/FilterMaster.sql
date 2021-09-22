CREATE TABLE [dbo].[FilterMaster] (
    [FilterMasterId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentOrChild]     NVARCHAR (50)  NULL,
    [ResourceKey]       NVARCHAR (100) NULL,
    [PropertyName]      NVARCHAR (500) NULL,
    [FilterDescription] NVARCHAR (100) NULL,
    [ParentFilterId]    BIGINT         NULL,
    [Sequence]          INT            NULL,
    [PropertyType]      NVARCHAR (50)  NULL,
    [FromRange]         NVARCHAR (50)  NULL,
    [ToRange]           NVARCHAR (50)  NULL,
    [IsRange]           BIT            NULL,
    [IsActive]          BIT            NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [UpdatedBy]         BIGINT         NULL,
    [UpdatedDate]       DATETIME       NULL,
    CONSTRAINT [PK_FilterMaster] PRIMARY KEY CLUSTERED ([FilterMasterId] ASC)
);

