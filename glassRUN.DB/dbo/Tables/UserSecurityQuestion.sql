CREATE TABLE [dbo].[UserSecurityQuestion] (
    [UserSecurityQuestionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SecurityQuestionId]     BIGINT         NOT NULL,
    [ProfileId]              BIGINT         NOT NULL,
    [Answer]                 NVARCHAR (150) NOT NULL,
    [IsActive]               BIT            NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedFromIPAddress]   NVARCHAR (20)  NULL,
    [UpdatedDate]            DATETIME       NULL,
    [UpdatedBy]              BIGINT         NULL,
    [UpdatedFromIPAddress]   NVARCHAR (20)  NULL,
    CONSTRAINT [PK_UserSecurityQuestion] PRIMARY KEY CLUSTERED ([UserSecurityQuestionId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_UserSecurityQuestion_UserProfile] FOREIGN KEY ([ProfileId]) REFERENCES [dbo].[Profile] ([ProfileId]),
    CONSTRAINT [FK_UserSecurityQuestion_UserSecurityQuestion] FOREIGN KEY ([SecurityQuestionId]) REFERENCES [dbo].[SecurityQuestion] ([SecurityQuestionId])
);

