CREATE TABLE [dbo].[RuleTypeFunctionMapping] (
    [RuleTypeFunctionMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [RuleTypeId]                BIGINT NULL,
    [RuleFunctionId]            BIGINT NULL,
    [IsActive]                  BIT    NULL,
    CONSTRAINT [PK_RuleTypeFunctionMapping] PRIMARY KEY CLUSTERED ([RuleTypeFunctionMappingId] ASC)
);

