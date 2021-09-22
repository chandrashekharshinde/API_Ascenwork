CREATE TABLE [dbo].[ControlTowerSnapshotGlobal] (
    [ControlTowerSnapshotGlobalId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [WorkFlowId]                   BIGINT        NULL,
    [WorkFlowCode]                 NVARCHAR (50) NULL,
    [StatusCode]                   NVARCHAR (50) NULL,
    [SequenceNo]                   BIGINT        NULL,
    [GlobalTotal]                  BIGINT        NULL,
    [GlobalCount]                  BIGINT        NULL,
    [IsActive]                     BIT           NOT NULL,
    [CreatedBy]                    BIGINT        NOT NULL,
    [CreatedDate]                  DATETIME      NOT NULL,
    [UpdatedBy]                    BIGINT        NULL,
    [UpdatedDate]                  DATETIME      NULL,
    CONSTRAINT [PK_ControlTowerSnapshotGlobal] PRIMARY KEY CLUSTERED ([ControlTowerSnapshotGlobalId] ASC)
);

