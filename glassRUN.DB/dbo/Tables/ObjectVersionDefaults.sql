CREATE TABLE [dbo].[ObjectVersionDefaults] (
    [ObjectVersionDefaultsId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectVersionId]         BIGINT         NULL,
    [ObjectId]                BIGINT         NULL,
    [ObjectPropertyId]        BIGINT         NULL,
    [DefaultValue]            NVARCHAR (500) NULL,
    [IsActive]                BIT            NOT NULL,
    [CreatedBy]               BIGINT         NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [ModifiedBy]              BIGINT         NULL,
    [ModifiedDate]            DATETIME       NULL,
    CONSTRAINT [PK_ObjectVersionDefaults] PRIMARY KEY CLUSTERED ([ObjectVersionDefaultsId] ASC) WITH (FILLFACTOR = 80)
);

