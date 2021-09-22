CREATE TABLE [dbo].[Activity] (
    [ActivityId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [StatusCode]           BIGINT         NULL,
    [Header]               NVARCHAR (50)  NULL,
    [ActivityName]         NVARCHAR (50)  NULL,
    [ActivityShortName]    NVARCHAR (50)  NULL,
    [Sequence]             BIGINT         NULL,
    [ServiceAction]        NVARCHAR (100) NULL,
    [IsResponseRequired]   BIT            NULL,
    [ResponsePropertyName] NVARCHAR (500) NULL,
    [RejectedStatus]       BIGINT         NULL,
    [IsApp]                BIT            NULL,
    [ParentId]             BIGINT         NULL,
    [IconName]             NVARCHAR (50)  NULL,
    [IsSystemDefined]      BIT            NULL,
    [DashboardDisplayName] NVARCHAR (100) NULL,
    [ObjectId]             BIGINT         NULL,
    [ProcessType]          BIGINT         NULL,
    CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED ([ActivityId] ASC)
);

