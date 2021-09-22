CREATE TABLE [dbo].[SortingParameters] (
    [SortingParametersId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [PropertyName]        NVARCHAR (500) NULL,
    [ResourceKey]         NVARCHAR (500) NULL,
    [PropertyType]        NVARCHAR (500) NULL,
    [HeaderName]          NVARCHAR (500) NULL,
    [SortingDescription]  NVARCHAR (500) NULL,
    [Sequence]            BIGINT         NULL,
    [IsActive]            BIT            NULL,
    [CreatedBy]           BIGINT         NULL,
    [CreatedDate]         DATETIME       NULL,
    [UpdatedBy]           BIGINT         NULL,
    [UpdatedDate]         DATETIME       NULL,
    CONSTRAINT [PK_SortingParameters] PRIMARY KEY CLUSTERED ([SortingParametersId] ASC)
);

