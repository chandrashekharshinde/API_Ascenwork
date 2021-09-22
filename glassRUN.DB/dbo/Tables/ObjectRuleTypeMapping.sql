CREATE TABLE [dbo].[ObjectRuleTypeMapping] (
    [ObjectRuleTypeMappingId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [RuleType]                BIGINT        NULL,
    [ObjectName]              NVARCHAR (50) NULL,
    [CreatedBy]               BIGINT        NOT NULL,
    [CreatedDate]             DATETIME      NOT NULL,
    [ModifiedBy]              BIGINT        NULL,
    [ModifiedDate]            DATETIME      NULL,
    [IsActive]                BIT           NOT NULL,
    [SequenceNo]              BIGINT        NULL,
    CONSTRAINT [PK_ObjectRuleTypeMapping] PRIMARY KEY CLUSTERED ([ObjectRuleTypeMappingId] ASC) WITH (FILLFACTOR = 80)
);

