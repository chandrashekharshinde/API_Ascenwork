CREATE TABLE [dbo].[EmailDynamicColumn] (
    [EmailDynamicColumnId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [EmailDynamicTableId]  BIGINT         NULL,
    [ColumnName]           NVARCHAR (100) NULL,
    [IsActive]             BIT            CONSTRAINT [DF_EmailDynamicColumn_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    CONSTRAINT [PK_EmailDynamicColumn] PRIMARY KEY CLUSTERED ([EmailDynamicColumnId] ASC)
);

