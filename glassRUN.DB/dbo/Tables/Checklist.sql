CREATE TABLE [dbo].[Checklist] (
    [ChecklistId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [ChecklistDescription]  NVARCHAR (MAX) NULL,
    [StatusCode]            BIGINT         NULL,
    [ActivityFormMappingId] BIGINT         NULL,
    [IsActive]              BIT            NULL,
    [CreatedBy]             BIGINT         NOT NULL,
    [CreatedDate]           DATETIME       NOT NULL,
    [UpdatedBy]             BIGINT         NULL,
    [UpdatedDate]           DATETIME       NULL,
    CONSTRAINT [PK_Checklist] PRIMARY KEY CLUSTERED ([ChecklistId] ASC)
);

