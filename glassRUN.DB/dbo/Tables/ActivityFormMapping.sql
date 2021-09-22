CREATE TABLE [dbo].[ActivityFormMapping] (
    [ActivityFormMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [StatusCode]            BIGINT         NOT NULL,
    [FormName]              NVARCHAR (100) NULL,
    [FormURL]               NVARCHAR (100) NULL,
    [FormType]              NVARCHAR (50)  NULL,
    [DataSource]            NVARCHAR (50)  NULL,
    CONSTRAINT [PK_ActivityFormMapping] PRIMARY KEY CLUSTERED ([ActivityFormMappingId] ASC)
);

