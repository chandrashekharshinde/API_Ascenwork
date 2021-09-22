CREATE TABLE [dbo].[ReasonCodeObjectMapping] (
    [ReasonCodeObjectMapping] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ReasonCodeId]            BIGINT         NULL,
    [ReasonDescription]       NVARCHAR (MAX) NULL,
    [ObjectId]                BIGINT         NULL,
    [ObjectType]              NVARCHAR (100) NULL,
    [EventName]               NVARCHAR (200) NULL,
    [IsActive]                BIT            NOT NULL,
    [CreatedBy]               BIGINT         NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [UpdatedBy]               BIGINT         NULL,
    [UpdatedDate]             DATETIME       NULL,
    CONSTRAINT [PK_ReasonCodeObjectMapping] PRIMARY KEY CLUSTERED ([ReasonCodeObjectMapping] ASC) WITH (FILLFACTOR = 80)
);

