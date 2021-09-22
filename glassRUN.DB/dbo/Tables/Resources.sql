CREATE TABLE [dbo].[Resources] (
    [ResourceId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [CultureId]     INT            NOT NULL,
    [PageName]      NVARCHAR (MAX) NULL,
    [ResourceType]  NVARCHAR (MAX) NOT NULL,
    [ResourceKey]   NVARCHAR (MAX) NOT NULL,
    [ResourceValue] NVARCHAR (MAX) NOT NULL,
    [IsApp]         BIT            NULL,
    [VersionNo]     NVARCHAR (MAX) NULL,
    [IsActive]      BIT            NOT NULL,
    CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED ([ResourceId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idx_resources_cultureid]
    ON [dbo].[Resources]([CultureId] ASC);

