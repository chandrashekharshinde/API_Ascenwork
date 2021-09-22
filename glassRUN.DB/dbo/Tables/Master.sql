CREATE TABLE [dbo].[Master] (
    [MasterId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageId]      BIGINT         NOT NULL,
    [SettingName] NVARCHAR (300) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [IsActive]    BIT            NULL,
    [CreatedBy]   BIGINT         NOT NULL,
    [CreatedDate] DATETIME       NOT NULL,
    [UpdatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    CONSTRAINT [PK_Master1] PRIMARY KEY CLUSTERED ([MasterId] ASC)
);

