CREATE TABLE [dbo].[Scheduling] (
    [SchedulingId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [FunctionName]       NVARCHAR (500) NULL,
    [IsContinuous]       BIT            NULL,
    [SchedulingDate]     DATETIME       NULL,
    [SchedulingTime]     DATETIME       NULL,
    [Freq]               NVARCHAR (50)  NULL,
    [FreqInterval]       NVARCHAR (50)  NULL,
    [IsSpecificTime]     BIT            NULL,
    [SpecificTime]       DATETIME       NULL,
    [IsSpecificDay]      BIT            NULL,
    [SpecificDay]        BIGINT         NULL,
    [NextSchedulingTime] DATETIME       NULL,
    [Type]               NVARCHAR (150) NULL,
    [IsActive]           BIT            NOT NULL,
    [CreatedBy]          BIGINT         NOT NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [UpdatedBy]          BIGINT         NULL,
    [UpdatedDate]        DATETIME       NULL,
    CONSTRAINT [PK_Scheduling] PRIMARY KEY CLUSTERED ([SchedulingId] ASC) WITH (FILLFACTOR = 80)
);

