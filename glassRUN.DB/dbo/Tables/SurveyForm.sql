CREATE TABLE [dbo].[SurveyForm] (
    [SurveyFormId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderId]      BIGINT         NULL,
    [Survey]       BIGINT         NULL,
    [Comments]     NVARCHAR (MAX) NULL,
    [IsActive]     BIT            NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_SurveyForm_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    BIGINT         NULL,
    [UpdatedDate]  DATETIME       NULL,
    [UpdatedBy]    BIGINT         NULL,
    CONSTRAINT [PK_SurveyForm] PRIMARY KEY CLUSTERED ([SurveyFormId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SurveyForm', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SurveyForm', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SurveyForm', @level2type = N'COLUMN', @level2name = N'CreatedBy';

