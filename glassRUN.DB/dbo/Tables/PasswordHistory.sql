CREATE TABLE [dbo].[PasswordHistory] (
    [PasswordHistoryId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProfileId]            BIGINT         NULL,
    [LoginId]              BIGINT         NULL,
    [HashedPassword]       NVARCHAR (200) NULL,
    [PasswordSalt]         NVARCHAR (100) NULL,
    [PasswordChangedDate]  DATETIME       NULL,
    [PasswordResetBy]      NVARCHAR (50)  NULL,
    [EmailAddress]         NVARCHAR (150) NULL,
    [PhoneNo]              NVARCHAR (50)  NULL,
    [OneTimePassword]      NVARCHAR (50)  NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedFromIPAddress] NVARCHAR (20)  NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedFromIPAddress] NVARCHAR (20)  NULL,
    [ResetPasswordCode]    NVARCHAR (500) NULL,
    [GUID]                 NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED ([PasswordHistoryId] ASC) WITH (FILLFACTOR = 80)
);

