CREATE TABLE [dbo].[LicenseInfo] (
    [LicenseId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [CustomerCode]   NVARCHAR (100) NOT NULL,
    [ProductCode]    NVARCHAR (100) NOT NULL,
    [ActivationCode] NVARCHAR (500) NOT NULL,
    [FromDate]       DATETIME       NULL,
    [ToDate]         DATETIME       NULL,
    [UserTypeCode]   NVARCHAR (100) NULL,
    [NoOfUsers]      NVARCHAR (100) NULL,
    [LicenseType]    NVARCHAR (100) NULL,
    [IPAddress]      NVARCHAR (100) NULL,
    [Type]           BIGINT         NULL,
    [IsActive]       BIT            NULL,
    CONSTRAINT [PK_LicenseInfo] PRIMARY KEY CLUSTERED ([LicenseId] ASC) WITH (FILLFACTOR = 80)
);

