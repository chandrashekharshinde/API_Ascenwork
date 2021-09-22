CREATE TABLE [dbo].[ChecklistResponse] (
    [ChecklistResponseId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [ChecklistId]         BIGINT          NULL,
    [ControlType]         NVARCHAR (500)  NULL,
    [Validation]          NVARCHAR (1000) NULL,
    [ResponseDataType]    NVARCHAR (100)  NULL,
    [IsActive]            BIT             NULL,
    [CreatedBy]           BIGINT          NOT NULL,
    [CreatedDate]         DATETIME        NOT NULL,
    [UpdatedBy]           BIGINT          NULL,
    [UpdatedDate]         DATETIME        NULL,
    CONSTRAINT [PK_ChecklistResponse] PRIMARY KEY CLUSTERED ([ChecklistResponseId] ASC)
);

