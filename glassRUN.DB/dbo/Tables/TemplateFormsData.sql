CREATE TABLE [dbo].[TemplateFormsData] (
    [TemplateFormDataId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TemplateFormId]     BIGINT         NULL,
    [OrderId]            BIGINT         NULL,
    [ItemId]             BIGINT         NULL,
    [LabelName]          NVARCHAR (MAX) NULL,
    [ControlName]        NVARCHAR (250) NULL,
    [ControlType]        NVARCHAR (100) NULL,
    [ControlValue]       NVARCHAR (150) NULL,
    [IsActive]           BIT            NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_TemplateFormsData_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]          NVARCHAR (50)  NULL,
    [UpdatedDate]        DATETIME       NULL,
    [UpdatedBy]          NVARCHAR (50)  NULL,
    [IsGeneration]       BIT            NULL,
    CONSTRAINT [PK_TemplateFormsData] PRIMARY KEY CLUSTERED ([TemplateFormDataId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TemplateFormsData', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TemplateFormsData', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TemplateFormsData', @level2type = N'COLUMN', @level2name = N'CreatedBy';

