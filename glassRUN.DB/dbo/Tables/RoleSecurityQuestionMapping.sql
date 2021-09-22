CREATE TABLE [dbo].[RoleSecurityQuestionMapping] (
    [RoleSecurityQuestionMappingId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [RoleMasterId]                  BIGINT        NULL,
    [SecurityQuestionId]            BIGINT        NOT NULL,
    [IsActive]                      BIT           NOT NULL,
    [CreatedDate]                   DATETIME      NOT NULL,
    [CreatedBy]                     BIGINT        NOT NULL,
    [CreatedFromIPAddress]          NVARCHAR (20) NULL,
    [UpdatedDate]                   DATETIME      NULL,
    [UpdatedBy]                     BIGINT        NULL,
    [UpdatedFromIPAddress]          NVARCHAR (20) NULL,
    CONSTRAINT [PK_RoleSecurityQuestionMapping] PRIMARY KEY CLUSTERED ([RoleSecurityQuestionMappingId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_RoleSecurityQuestionMapping_RoleMaster] FOREIGN KEY ([RoleMasterId]) REFERENCES [dbo].[RoleMaster] ([RoleMasterId]),
    CONSTRAINT [FK_RoleSecurityQuestionMapping_RoleSecurityQuestionMapping] FOREIGN KEY ([SecurityQuestionId]) REFERENCES [dbo].[SecurityQuestion] ([SecurityQuestionId])
);

