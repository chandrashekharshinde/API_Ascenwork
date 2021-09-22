CREATE TABLE [dbo].[EmailConfiguration] (
    [EmailConfigurationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SupplierId]           BIGINT         NULL,
    [SmtpHost]             NVARCHAR (150) NULL,
    [FromEmail]            NVARCHAR (150) NULL,
    [UserName]             NVARCHAR (150) NULL,
    [Password]             NVARCHAR (150) NULL,
    [EmailBodyType]        NVARCHAR (150) NULL,
    [PortNumber]           INT            NULL,
    [EnableSsl]            BIT            NULL,
    [EmailSignature]       NVARCHAR (150) NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    CONSTRAINT [PK_EmailConfiguration] PRIMARY KEY CLUSTERED ([EmailConfigurationId] ASC) WITH (FILLFACTOR = 80)
);

