CREATE TABLE [dbo].[Log] (
    [LogId]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]         BIGINT         NULL,
    [ObjectId]       NVARCHAR (200) NULL,
    [ObjectType]     NVARCHAR (200) NULL,
    [PageName]       NVARCHAR (100) NULL,
    [LogDescription] NVARCHAR (MAX) NOT NULL,
    [FunctionCall]   NVARCHAR (MAX) NULL,
    [LogDate]        DATETIME       NOT NULL,
    [LoggingTypeId]  BIGINT         NULL,
    [Source]         NVARCHAR (200) NULL,
    [LogGuid]        NVARCHAR (200) NULL,
    [CreatedDate]    DATETIME       NULL,
    CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED ([LogId] ASC) WITH (FILLFACTOR = 80)
);

