CREATE TABLE [dbo].[WorkFlowStepRules] (
    [WorkFlowStepRulesId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [RuleDescription]     NVARCHAR (100) NULL,
    [WorkFlowCode]        NVARCHAR (100) NULL,
    [StatusCode]          BIGINT         NULL,
    [WorkFlowRulesId]     BIGINT         NULL,
    [IsForNextStep]       BIT            NULL,
    [IsActive]            BIT            NULL,
    CONSTRAINT [PK_WorkFlowStepProcessRule] PRIMARY KEY CLUSTERED ([WorkFlowStepRulesId] ASC)
);

