CREATE TABLE [dbo].[TableColumnUsedFor] (
    [TableColumnUsedForId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [TableName]            NVARCHAR (50) NULL,
    [ColumnName]           NVARCHAR (50) NULL,
    [UsedFor]              NVARCHAR (50) NULL,
    [IsActive]             BIGINT        CONSTRAINT [DF_TableColumnUsedFor_IsActive] DEFAULT ((1)) NULL,
    [CreatedBy]            BIGINT        CONSTRAINT [DF_TableColumnUsedFor_CreatedBy] DEFAULT ((1)) NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_TableColumnUsedFor_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            BIGINT        NULL,
    [UpdatedDate]          DATETIME      NULL,
    CONSTRAINT [PK_TableColumnUsedFor] PRIMARY KEY CLUSTERED ([TableColumnUsedForId] ASC) WITH (FILLFACTOR = 80)
);

