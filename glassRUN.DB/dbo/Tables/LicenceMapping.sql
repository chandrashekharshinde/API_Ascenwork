CREATE TABLE [dbo].[LicenceMapping] (
    [LicenceMappingId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProfileId]            BIGINT         NULL,
    [LicenceKey]           NVARCHAR (250) NULL,
    [LicenceIssueDate]     DATETIME       NULL,
    [LicenceExpiryDate]    DATETIME       NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedFromIPAddress] NVARCHAR (20)  NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedFromIPAddress] NVARCHAR (20)  NULL,
    CONSTRAINT [PK_LicenceMapping] PRIMARY KEY CLUSTERED ([LicenceMappingId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_LicenceMapping_UserProfile] FOREIGN KEY ([ProfileId]) REFERENCES [dbo].[Profile] ([ProfileId])
);

