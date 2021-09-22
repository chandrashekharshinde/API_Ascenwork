CREATE TABLE [dbo].[UserDimensionMapping] (
    [UserDimensionMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]                 BIGINT         NULL,
    [RoleMasterId]           BIGINT         NULL,
    [DimensionName]          NVARCHAR (50)  NULL,
    [PageName]               NVARCHAR (250) NULL,
    [OperatorType]           NVARCHAR (10)  NULL,
    [ControlId]              BIGINT         NULL,
    [DimensionValue]         NVARCHAR (100) NULL,
    [IsActive]               BIT            NOT NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedBy]              BIGINT         NULL,
    [UpdatedDate]            DATETIME       NULL,
    CONSTRAINT [PK_UserDimensionMapping] PRIMARY KEY CLUSTERED ([UserDimensionMappingId] ASC) WITH (FILLFACTOR = 80)
);

