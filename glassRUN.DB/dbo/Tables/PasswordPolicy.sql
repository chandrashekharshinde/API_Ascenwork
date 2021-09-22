﻿CREATE TABLE [dbo].[PasswordPolicy] (
    [PasswordPolicyId]                          BIGINT         IDENTITY (1, 1) NOT NULL,
    [PasswordPolicyName]                        NVARCHAR (150) NULL,
    [IsUpperCaseAllowed]                        BIT            NULL,
    [IsLowerCaseAllowed]                        BIT            NULL,
    [IsNumberAllowed]                           BIT            NULL,
    [IsSpecialCharacterAllowed]                 BIT            NULL,
    [SpecialCharactersToBeExcluded]             NVARCHAR (50)  NULL,
    [MinimumUppercaseCharactersRequired]        INT            NULL,
    [MinimumLowercaseCharactersRequired]        INT            NULL,
    [MinimumSpecialCharactersRequired]          INT            NULL,
    [MinimumNumericsRequired]                   INT            NULL,
    [PasswordExpiryPeriod]                      INT            NULL,
    [NewPasswordShouldNotMatchNoOfLastPassword] BIT            NULL,
    [MinimumPasswordLength]                     INT            NULL,
    [MaximumPasswordLength]                     INT            NULL,
    [CanPasswordBeSameAsUserName]               BIT            NULL,
    [NumberOfSecurityQuestionsForRegistration]  INT            NULL,
    [NumberOfSecurityQuestionsForRecovery]      INT            NULL,
    [OneTimePasswordExpireTime]                 INT            NULL,
    [IsActive]                                  BIT            NOT NULL,
    [CreatedDate]                               DATETIME       NOT NULL,
    [CreatedBy]                                 BIGINT         NOT NULL,
    [CreatedFromIPAddress]                      NVARCHAR (20)  NULL,
    [UpdatedDate]                               DATETIME       NULL,
    [UpdatedBy]                                 BIGINT         NULL,
    [UpdatedFromIPAddress]                      NVARCHAR (20)  NULL,
    [PasswordWarningDays]                       INT            NULL,
    CONSTRAINT [PK_PasswordPolicy] PRIMARY KEY CLUSTERED ([PasswordPolicyId] ASC) WITH (FILLFACTOR = 80)
);
