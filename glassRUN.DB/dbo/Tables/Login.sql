CREATE TABLE [dbo].[Login] (
    [LoginId]                            BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProfileId]                          BIGINT         NULL,
    [RoleMasterId]                       NCHAR (10)     NULL,
    [Name]                               NVARCHAR (250) NULL,
    [UserName]                           NVARCHAR (50)  NOT NULL,
    [HashedPassword]                     NVARCHAR (50)  NOT NULL,
    [PasswordSalt]                       INT            NOT NULL,
    [ParentLoginId]                      BIGINT         NULL,
    [ReferenceId]                        BIGINT         NULL,
    [ReferenceType]                      BIGINT         NULL,
    [LoginAttempts]                      INT            NULL,
    [AccessKey]                          NVARCHAR (250) NULL,
    [LastLogin]                          DATETIME       NULL,
    [ExpiryDate]                         DATETIME       NULL,
    [LastPasswordChange]                 DATETIME       NULL,
    [ChangePasswordonFirstLoginRequired] BIT            NULL,
    [ParentId]                           BIGINT         NULL,
    [IsActive]                           BIT            NOT NULL,
    [CreatedDate]                        DATETIME       NOT NULL,
    [CreatedBy]                          BIGINT         NOT NULL,
    [CreatedFromIPAddress]               NVARCHAR (20)  NULL,
    [UpdatedDate]                        DATETIME       NULL,
    [UpdatedBy]                          BIGINT         NULL,
    [UpdatedFromIPAddress]               NVARCHAR (20)  NULL,
    [ActivationCode]                     NVARCHAR (MAX) NULL,
    [GUID]                               NVARCHAR (250) NULL,
    [LicenseType]                        BIGINT         NULL,
    [UserProfilePicture]                 NVARCHAR (MAX) NULL,
    [DefaultLanguage]                    BIGINT         NULL,
    [LicenseNumber]                      NVARCHAR (100) NULL,
    [CompletedSetupStep]                 INT            NULL,
    [IsStepCompleted]                    BIT            NULL,
    [IsAgree]                            BIT            NULL,
    [EULAgreement]                       NVARCHAR (MAX) NULL,
    [EULAAgreeDatetime]                  DATETIME       NULL,
    CONSTRAINT [PK_UserDetail] PRIMARY KEY CLUSTERED ([LoginId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used in Licensing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Login', @level2type = N'COLUMN', @level2name = N'ActivationCode';

