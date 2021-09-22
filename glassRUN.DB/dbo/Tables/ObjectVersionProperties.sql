CREATE TABLE [dbo].[ObjectVersionProperties] (
    [ObjectVersionPropertiesId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectVersionId]           BIGINT         NULL,
    [ObjectId]                  BIGINT         NULL,
    [ObjectPropertyId]          BIGINT         NULL,
    [Mandatory]                 BIT            NULL,
    [ValidationExpression]      NVARCHAR (250) NULL,
    [IsActive]                  BIT            NOT NULL,
    [CreatedBy]                 BIGINT         NOT NULL,
    [CreatedDate]               DATETIME       NOT NULL,
    [ModifiedBy]                BIGINT         NULL,
    [ModifiedDate]              DATETIME       NULL,
    CONSTRAINT [PK_ObjectVersionProperties] PRIMARY KEY CLUSTERED ([ObjectVersionPropertiesId] ASC) WITH (FILLFACTOR = 80)
);

