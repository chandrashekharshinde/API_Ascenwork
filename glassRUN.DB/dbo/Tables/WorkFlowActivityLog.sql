CREATE TABLE [dbo].[WorkFlowActivityLog] (
    [WorkFlowActivityLogId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [LoginId]                      BIGINT         NOT NULL,
    [RoleId]                       BIGINT         NULL,
    [EnquiryId]                    BIGINT         NULL,
    [EnquiryNumber]                NVARCHAR (200) NULL,
    [OrderId]                      BIGINT         NULL,
    [OrderNumber]                  NVARCHAR (200) NULL,
    [WorkFlowCode]                 NVARCHAR (200) NOT NULL,
    [WorkFlowCurrentStatusCode]    BIGINT         NOT NULL,
    [WorkFlowCurrentActivityName]  NVARCHAR (200) NULL,
    [WorkFlowPreviousStatusCode]   BIGINT         NULL,
    [WorkFlowPreviousActivityName] NVARCHAR (200) NULL,
    [RawData]                      NVARCHAR (MAX) NULL,
    [IsIsAutomated]                BIT            NULL,
    [ProcessOutputResponse]        NVARCHAR (MAX) NULL,
    [Username]                     NVARCHAR (MAX) NULL,
    [CreatedBy]                    BIGINT         NOT NULL,
    [CreatedDate]                  DATETIME       NOT NULL,
    [ActivityStartTime]            DATETIME       NULL,
    [ActivityEndTime]              DATETIME       NULL,
    CONSTRAINT [PK_WorkFlowActitvityLog] PRIMARY KEY CLUSTERED ([WorkFlowActivityLogId] ASC)
);




GO
CREATE NONCLUSTERED INDEX [idx_WorkflowActivityLog_EnquiryID]
    ON [dbo].[WorkFlowActivityLog]([EnquiryId] ASC, [WorkFlowCurrentStatusCode] ASC);




GO
CREATE NONCLUSTERED INDEX [idx_WorkflowActivityLog_OrderID]
    ON [dbo].[WorkFlowActivityLog]([OrderId] ASC);

