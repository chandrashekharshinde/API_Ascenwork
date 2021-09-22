CREATE TABLE [dbo].[OrderChecklist] (
    [OrderChecklistId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [ChecklistId]           BIGINT         NULL,
    [OrderId]               BIGINT         NULL,
    [OrderNumber]           NVARCHAR (500) NULL,
    [ProductId]             BIGINT         NULL,
    [ProductCode]           NVARCHAR (500) NULL,
    [CompartmentId]         NVARCHAR (500) NULL,
    [OrderMovementId]       BIGINT         NULL,
    [ChecklistDescription]  NVARCHAR (MAX) NULL,
    [StatusCode]            BIGINT         NULL,
    [ActivityFormMappingId] BIGINT         NULL,
    [OrderChecklistGuid]    NVARCHAR (MAX) NULL,
    [IsActive]              BIT            NULL,
    [CreatedDate]           DATETIME       NULL,
    CONSTRAINT [PK_OrderChecklist] PRIMARY KEY CLUSTERED ([OrderChecklistId] ASC)
);

