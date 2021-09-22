CREATE TABLE [dbo].[ControlTowerSnapshotWorkflowStepRoleMapping] (
    [ControlTowerSnapshotWorkflowStepRoleMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkFlowId]                                    BIGINT         NULL,
    [WorkFlowCode]                                  NVARCHAR (50)  NULL,
    [StatusCode]                                    NVARCHAR (50)  NULL,
    [SequenceNo]                                    BIGINT         NULL,
    [RoleId]                                        BIGINT         NULL,
    [UserId]                                        BIGINT         NULL,
    [IsShowGlobalCount]                             BIT            NULL,
    [DisplayNameResourceKey]                        NVARCHAR (500) NULL,
    [IsActive]                                      BIT            NOT NULL,
    [CreatedBy]                                     BIGINT         NOT NULL,
    [CreatedDate]                                   DATETIME       NOT NULL,
    [UpdatedBy]                                     BIGINT         NULL,
    [UpdatedDate]                                   DATETIME       NULL,
    CONSTRAINT [PK_ControlTowerSnapshotWorkflowStepRoleMapping] PRIMARY KEY CLUSTERED ([ControlTowerSnapshotWorkflowStepRoleMappingId] ASC)
);

