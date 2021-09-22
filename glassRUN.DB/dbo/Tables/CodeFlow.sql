CREATE TABLE [dbo].[CodeFlow] (
    [CodeFlowId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkFlowStepId]       BIGINT         NULL,
    [CodeFlowName]         NVARCHAR (100) NULL,
    [ServiceAction]        NVARCHAR (200) NULL,
    [StatusCode]           BIGINT         NULL,
    [SequenceNo]           BIGINT         NULL,
    [IsAutomated]          BIT            NULL,
    [IsResponseRequired]   BIT            NULL,
    [ResponsePropertyName] NVARCHAR (500) NULL,
    [IsActive]             BIT            NULL,
    CONSTRAINT [PK_WorkFlowSubStepProcess] PRIMARY KEY CLUSTERED ([CodeFlowId] ASC)
);

