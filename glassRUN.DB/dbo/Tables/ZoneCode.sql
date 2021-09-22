CREATE TABLE [dbo].[ZoneCode] (
    [ZoneCodeId]  BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]   BIGINT        NULL,
    [ZoneCode]    NVARCHAR (50) NULL,
    [ZoneName]    NVARCHAR (50) NULL,
    [IsActive]    BIT           NOT NULL,
    [CreatedBy]   BIGINT        NOT NULL,
    [CreatedDate] DATETIME      NOT NULL,
    [UpdatedBy]   BIGINT        NULL,
    [UpdatedDate] DATETIME      NULL,
    CONSTRAINT [PK_ZoneCode] PRIMARY KEY CLUSTERED ([ZoneCodeId] ASC)
);

