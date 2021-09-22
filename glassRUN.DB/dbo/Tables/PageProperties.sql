CREATE TABLE [dbo].[PageProperties] (
    [PagePropertiesId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageId]           BIGINT         NULL,
    [PropertyName]     NVARCHAR (150) NULL,
    [IsActive]         BIT            NULL,
    [CreatedBy]        BIGINT         NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        BIGINT         NULL,
    [UpdatedDate]      DATETIME       NULL,
    CONSTRAINT [PK_PageProperties] PRIMARY KEY CLUSTERED ([PagePropertiesId] ASC)
);

