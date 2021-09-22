CREATE TABLE [dbo].[TemplateForms] (
    [TemplateFormId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TemplateBody]   NVARCHAR (MAX) NULL,
    [TemplateJson]   NVARCHAR (MAX) NULL,
    [TemplateName]   NVARCHAR (50)  NULL,
    [IsAppTemplate]  BIT            NULL,
    [Version]        NVARCHAR (50)  NULL,
    [IsActive]       BIT            NOT NULL,
    [CreatedBy]      BIGINT         NOT NULL,
    [CreatedDate]    DATETIME       NOT NULL,
    [UpdatedBy]      BIGINT         NULL,
    [UpdatedDate]    DATETIME       NULL,
    CONSTRAINT [PK_TemplateForms] PRIMARY KEY CLUSTERED ([TemplateFormId] ASC)
);

