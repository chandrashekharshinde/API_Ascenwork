CREATE TABLE [dbo].[EmailContent] (
    [EmailContentId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [SupplierId]         BIGINT         NULL,
    [CompanyId]          BIGINT         NULL,
    [EmailEventId]       BIGINT         NULL,
    [Subject]            NVARCHAR (MAX) NULL,
    [EmailHeader]        NVARCHAR (MAX) NULL,
    [EmailBody]          NVARCHAR (MAX) NULL,
    [EmailFooter]        NVARCHAR (MAX) NULL,
    [CcEmailAddress]     NVARCHAR (MAX) NULL,
    [UserProfileId]      NVARCHAR (MAX) NULL,
    [OtherEmailAdresses] NVARCHAR (MAX) NULL,
    [IsActive]           BIT            NOT NULL,
    [CreatedBy]          BIGINT         NOT NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [UpdatedBy]          BIGINT         NULL,
    [UpdatedDate]        DATETIME       NULL,
    CONSTRAINT [PK_EmailContent] PRIMARY KEY CLUSTERED ([EmailContentId] ASC) WITH (FILLFACTOR = 80)
);

