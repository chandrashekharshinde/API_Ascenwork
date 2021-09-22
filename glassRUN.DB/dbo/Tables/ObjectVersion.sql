CREATE TABLE [dbo].[ObjectVersion] (
    [ObjectVersionId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ObjectId]        BIGINT        NULL,
    [ObjectName]      NVARCHAR (50) NULL,
    [VersionNumber]   NVARCHAR (50) NULL,
    [IsActive]        BIT           NOT NULL,
    [CreatedBy]       BIGINT        NOT NULL,
    [CreatedDate]     DATETIME      NOT NULL,
    [ModifiedBy]      BIGINT        NULL,
    [ModifiedDate]    DATETIME      NULL,
    CONSTRAINT [PK_ObjectVersion] PRIMARY KEY CLUSTERED ([ObjectVersionId] ASC) WITH (FILLFACTOR = 80)
);

