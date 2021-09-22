CREATE TABLE [dbo].[ActivityPossibleSteps] (
    [ActivityPossibleStepId] BIGINT IDENTITY (1, 1) NOT NULL,
    [CurrentStatusCode]      BIGINT NULL,
    [PossibleStatusCode]     BIGINT NULL,
    CONSTRAINT [PK_WorkflowProposedStages] PRIMARY KEY CLUSTERED ([ActivityPossibleStepId] ASC)
);

