CREATE TABLE [dbo].[WorkFlowRules] (
    [WorkFlowRulesId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RuleDescription] NVARCHAR (100) NULL,
    [WorkFlowCode]    NVARCHAR (100) NULL,
    [RulesId]         BIGINT         NULL,
    [IsForNextStep]   BIT            NULL,
    [IsActive]        BIT            NULL,
    CONSTRAINT [PK_WorkFlowProcessRule] PRIMARY KEY CLUSTERED ([WorkFlowRulesId] ASC)
);

