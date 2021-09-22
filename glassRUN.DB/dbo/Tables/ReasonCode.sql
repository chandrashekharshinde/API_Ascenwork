CREATE TABLE [dbo].[ReasonCode] (
    [ReasonCodeId] BIGINT         NOT NULL,
    [ReasonCode]   NVARCHAR (50)  NULL,
    [ReasonName]   NVARCHAR (250) NULL,
    [IsActive]     BIT            NOT NULL,
    [CreatedBy]    BIGINT         NOT NULL,
    [CreatedDate]  DATETIME       NOT NULL,
    [UpdatedBy]    BIGINT         NULL,
    [UpdatedDate]  DATETIME       NULL,
    CONSTRAINT [PK_ReasonCode] PRIMARY KEY CLUSTERED ([ReasonCodeId] ASC) WITH (FILLFACTOR = 80)
);

