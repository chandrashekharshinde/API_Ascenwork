CREATE TABLE [dbo].[Workflow] (
    [WorkFlowId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkFlowCode] NVARCHAR (50)  NULL,
    [WorkFlowName] NVARCHAR (100) NULL,
    [WorkFlowRule] NVARCHAR (500) NULL,
    [CompanyId]    BIGINT         NULL,
    [FromDate]     DATETIME       NULL,
    [ToDate]       DATETIME       NULL,
    [ProcessType]  BIGINT         NULL,
    [IsActive]     BIT            CONSTRAINT [DF_Workflow_IsActive] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_Workflow] PRIMARY KEY CLUSTERED ([WorkFlowId] ASC)
);

