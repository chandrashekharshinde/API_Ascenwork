CREATE TABLE [dbo].[FilterParameters] (
    [FilterParametersId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PropertyName]       NVARCHAR (500) NULL,
    [ResourceKey]        NVARCHAR (500) NULL,
    [PropertyType]       NVARCHAR (500) NULL,
    [PageId]             BIGINT         NULL,
    [HeaderName]         NVARCHAR (500) NULL,
    [IsActive]           BIT            NULL,
    CONSTRAINT [PK_Filter] PRIMARY KEY CLUSTERED ([FilterParametersId] ASC)
);

