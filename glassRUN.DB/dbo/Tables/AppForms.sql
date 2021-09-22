CREATE TABLE [dbo].[AppForms] (
    [AppFormId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [CompanyId]    BIGINT         NULL,
    [LOBId]        BIGINT         NULL,
    [FormType]     NVARCHAR (50)  NULL,
    [FormContent]  NVARCHAR (MAX) NULL,
    [ContentType]  NVARCHAR (50)  NULL,
    [Version]      NVARCHAR (50)  NULL,
    [RoleMasterId] BIGINT         NULL,
    [OrderType]    BIGINT         NULL,
    [IsCompulsory] BIT            NULL,
    [IsActive]     BIT            NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_AppForms_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]    NVARCHAR (50)  NULL,
    [UpdatedDate]  DATETIME       NULL,
    [UpdatedBy]    NVARCHAR (50)  NULL,
    [AppType]      BIGINT         NULL,
    CONSTRAINT [PK_AppForm] PRIMARY KEY CLUSTERED ([AppFormId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppForms', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppForms', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppForms', @level2type = N'COLUMN', @level2name = N'CreatedBy';

