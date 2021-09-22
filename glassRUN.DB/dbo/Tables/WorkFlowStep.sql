CREATE TABLE [dbo].[WorkFlowStep] (
    [WorkFlowStepId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkFlowCode]          NVARCHAR (100) NULL,
    [ActivityName]          NVARCHAR (100) NULL,
    [StatusCode]            BIGINT         NULL,
    [ActivityFormMappingId] BIGINT         NULL,
    [FormName]              NVARCHAR (50)  NULL,
    [SequenceNo]            BIGINT         NULL,
    [IsAutomated]           BIT            NULL,
    [IsActive]              BIT            CONSTRAINT [DF_WorkFlowStep_IsActive] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_WorkFlowStepProcess] PRIMARY KEY CLUSTERED ([WorkFlowStepId] ASC)
);

