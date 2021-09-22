CREATE TABLE [dbo].[WorkflowActivityConfiguration] (
    [WorkflowActivityConfigurationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkFlowStepId]                  BIGINT         NULL,
    [WorkFlowCode]                    NVARCHAR (100) NULL,
    [StatusCode]                      NVARCHAR (100) NULL,
    [ActivityName]                    NVARCHAR (100) NULL,
    [IsAvailable]                     BIT            NULL,
    [IsNotificationLogAvailable]      BIT            NULL,
    [IsActivityLogAvailable]          BIT            NULL,
    [IsStartDateAvailable]            BIT            NULL,
    [IsEndDateAvailable]              BIT            NULL,
    [IsUserNameAvailable]             BIT            NULL,
    [RoleId]                          BIGINT         NULL,
    [LoginId]                         BIGINT         NULL,
    [IsActive]                        BIT            NULL,
    [CreatedBy]                       BIGINT         NULL,
    [CreatedDate]                     DATETIME       NULL,
    [UpdatedBy]                       BIGINT         NULL,
    [UpdatedDate]                     DATETIME       NULL,
    [IPAddress]                       NVARCHAR (20)  NULL,
    CONSTRAINT [PK_WorkflowActivityConfiguration] PRIMARY KEY CLUSTERED ([WorkflowActivityConfigurationId] ASC)
);

