CREATE TABLE [dbo].[EmailEvent] (
    [EmailEventId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SupplierId]   BIGINT         NULL,
    [EventName]    NVARCHAR (150) NULL,
    [EventCode]    NVARCHAR (150) NULL,
    [Description]  NVARCHAR (250) NULL,
    [IsActive]     BIT            NOT NULL,
    [CreatedBy]    BIGINT         NOT NULL,
    [CreatedDate]  DATETIME       NOT NULL,
    [UpdatedBy]    BIGINT         NULL,
    [UpdatedDate]  DATETIME       NULL,
    CONSTRAINT [PK_EmailEvent] PRIMARY KEY CLUSTERED ([EmailEventId] ASC) WITH (FILLFACTOR = 80)
);

