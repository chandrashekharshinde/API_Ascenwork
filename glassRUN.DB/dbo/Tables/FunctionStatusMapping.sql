CREATE TABLE [dbo].[FunctionStatusMapping] (
    [FunctionStatusMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]                  BIGINT         NOT NULL,
    [UserId]                  BIGINT         NULL,
    [SettingName]             NVARCHAR (150) NOT NULL,
    [StatusCode]              BIGINT         NOT NULL,
    [IsActive]                BIT            NOT NULL,
    [CreatedBy]               BIGINT         NOT NULL,
    [CreatedDate]             DATETIME       CONSTRAINT [DF_FunctionStatusMapping_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]              BIGINT         NULL,
    [ModifiedDate]            DATETIME       NULL,
    CONSTRAINT [PK_FunctionStatusMapping_1] PRIMARY KEY CLUSTERED ([FunctionStatusMappingId] ASC)
);

