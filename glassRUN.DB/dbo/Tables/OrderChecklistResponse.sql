CREATE TABLE [dbo].[OrderChecklistResponse] (
    [OrderChecklistResponseId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ChecklistResponseId]      BIGINT         NULL,
    [OrderChecklistId]         BIGINT         NULL,
    [ResponseDetails]          NVARCHAR (MAX) NULL,
    [ResponseDataType]         NVARCHAR (100) NULL,
    [Latitude]                 NVARCHAR (100) NULL,
    [Longitude]                NVARCHAR (100) NULL,
    [OrderChecklistGuid]       NVARCHAR (MAX) NULL,
    [IsActive]                 BIGINT         NULL,
    [CreatedDate]              DATETIME       NULL,
    CONSTRAINT [PK_OrderChecklistResponse] PRIMARY KEY CLUSTERED ([OrderChecklistResponseId] ASC)
);

