CREATE TABLE [dbo].[ActivityPrerequisiteSteps] (
    [ActivityPrerequisiteStepId] BIGINT IDENTITY (1, 1) NOT NULL,
    [CurrentStatusCode]          BIGINT NULL,
    [PrerequisiteStatusCode]     BIGINT NULL,
    CONSTRAINT [PK_WorkflowMandatoryStages] PRIMARY KEY CLUSTERED ([ActivityPrerequisiteStepId] ASC)
);

