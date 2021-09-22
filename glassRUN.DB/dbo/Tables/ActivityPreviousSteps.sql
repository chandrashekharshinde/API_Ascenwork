CREATE TABLE [dbo].[ActivityPreviousSteps] (
    [ActivityPreviousStepId] BIGINT IDENTITY (1, 1) NOT NULL,
    [CurrentStatusCode]      BIGINT NULL,
    [PreviousStatusCode]     BIGINT NULL,
    CONSTRAINT [PK_ActivityPreviousSteps] PRIMARY KEY CLUSTERED ([ActivityPreviousStepId] ASC)
);

