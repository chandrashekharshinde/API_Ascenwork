CREATE TABLE [dbo].[ObjectProperties] (
    [ObjectPropertiesId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ObjectId]           BIGINT        NULL,
    [PropertyName]       NVARCHAR (50) NULL,
    [ResourceKey]        BIGINT        NULL,
    [OnScreenDisplay]    BIT           NULL,
    [IsActive]           BIT           NOT NULL,
    [CreatedBy]          BIGINT        NOT NULL,
    [CreatedDate]        DATETIME      NOT NULL,
    [ModifiedBy]         BIGINT        NULL,
    [ModifiedDate]       DATETIME      NULL,
    CONSTRAINT [PK_ObjectProperties] PRIMARY KEY CLUSTERED ([ObjectPropertiesId] ASC) WITH (FILLFACTOR = 80)
);

