CREATE TABLE [dbo].[EmailDynamicTable] (
    [EmailDynamicTableId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TableName]           NVARCHAR (100) NULL,
    [IsActive]            BIT            CONSTRAINT [DF_EmailDynamicTable_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]           BIGINT         NOT NULL,
    [CreatedDate]         DATETIME       NOT NULL,
    [UpdatedBy]           BIGINT         NULL,
    [UpdatedDate]         DATETIME       NULL,
    CONSTRAINT [PK_EmailDynamicTable] PRIMARY KEY CLUSTERED ([EmailDynamicTableId] ASC)
);

