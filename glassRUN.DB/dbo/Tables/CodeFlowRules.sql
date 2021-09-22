CREATE TABLE [dbo].[CodeFlowRules] (
    [CodeFlowRulesId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RuleDescription] NVARCHAR (100) NULL,
    [WorkFlowRulesId] BIGINT         NULL,
    [CodeFlowId]      BIGINT         NULL,
    [IsForNextStep]   BIT            NULL,
    [IsActive]        BIT            NULL,
    CONSTRAINT [PK_WorkFlowSubStepProcessRules] PRIMARY KEY CLUSTERED ([CodeFlowRulesId] ASC)
);

