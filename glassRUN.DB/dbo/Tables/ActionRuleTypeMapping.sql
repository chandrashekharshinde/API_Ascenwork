CREATE TABLE [dbo].[ActionRuleTypeMapping] (
    [ActionRuleTypeMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ActionName]              NVARCHAR (100) NULL,
    [RuleType]                BIGINT         NULL,
    [IsActive]                BIT            NULL,
    CONSTRAINT [PK_ActionRuleTypeMapping] PRIMARY KEY CLUSTERED ([ActionRuleTypeMappingId] ASC)
);

