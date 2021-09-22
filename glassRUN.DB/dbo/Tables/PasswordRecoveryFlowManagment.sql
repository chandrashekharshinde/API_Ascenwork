CREATE TABLE [dbo].[PasswordRecoveryFlowManagment] (
    [PasswordRecoveryFlowManagmentId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [IsOTPRequired]                   BIT           NULL,
    [IsSecurityQuestionMandatory]     BIT           NULL,
    [RecoveryThroughPrimaryEmail]     BIT           NULL,
    [RecoveryThroughAlternateEmail]   BIT           NULL,
    [RecoveryThroughRegisteredMobile] BIT           NULL,
    [RecoveryThroughSecurityQuestion] BIT           NULL,
    [CanAdminResetPassword]           BIT           NULL,
    [IsActive]                        BIT           NOT NULL,
    [CreatedDate]                     DATETIME      NOT NULL,
    [CreatedBy]                       BIGINT        NOT NULL,
    [CreatedFromIPAddress]            NVARCHAR (20) NULL,
    [UpdatedDate]                     DATETIME      NULL,
    [UpdatedBy]                       BIGINT        NULL,
    [UpdatedFromIPAddress]            NVARCHAR (20) NULL,
    CONSTRAINT [PK_PasswordRecoveryFlowManagment] PRIMARY KEY CLUSTERED ([PasswordRecoveryFlowManagmentId] ASC) WITH (FILLFACTOR = 80)
);

