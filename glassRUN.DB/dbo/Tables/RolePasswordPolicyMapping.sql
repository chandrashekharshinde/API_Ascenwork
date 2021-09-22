CREATE TABLE [dbo].[RolePasswordPolicyMapping] (
    [RolePasswordPolicyMappingId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [RoleMasterId]                BIGINT        NOT NULL,
    [PasswordPolicyId]            BIGINT        NULL,
    [IsActive]                    BIT           NOT NULL,
    [CreatedDate]                 DATETIME      NOT NULL,
    [CreatedBy]                   BIGINT        NOT NULL,
    [CreatedFromIPAddress]        NVARCHAR (20) NULL,
    [UpdatedDate]                 DATETIME      NULL,
    [UpdatedBy]                   BIGINT        NULL,
    [UpdatedFromIPAddress]        NVARCHAR (20) NULL,
    CONSTRAINT [PK_RolePasswordPolicyMapping] PRIMARY KEY CLUSTERED ([RolePasswordPolicyMappingId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_RolePasswordPolicyMapping_PasswordPolicy] FOREIGN KEY ([PasswordPolicyId]) REFERENCES [dbo].[PasswordPolicy] ([PasswordPolicyId]),
    CONSTRAINT [FK_RolePasswordPolicyMapping_RoleMaster] FOREIGN KEY ([RoleMasterId]) REFERENCES [dbo].[RoleMaster] ([RoleMasterId])
);

