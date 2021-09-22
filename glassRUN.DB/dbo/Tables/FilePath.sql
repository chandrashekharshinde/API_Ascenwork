CREATE TABLE [dbo].[FilePath] (
    [FilePathId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [FilePathName] NVARCHAR (500) NULL,
    [FileType]     NVARCHAR (50)  NULL,
    [IsActive]     BIT            NULL,
    CONSTRAINT [PK_FilePath] PRIMARY KEY CLUSTERED ([FilePathId] ASC) WITH (FILLFACTOR = 80)
);

