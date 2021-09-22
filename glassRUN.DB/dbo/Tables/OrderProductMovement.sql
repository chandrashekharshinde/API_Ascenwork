CREATE TABLE [dbo].[OrderProductMovement] (
    [OrderProductMovementId]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]                  BIGINT          NULL,
    [OrderProductId]           BIGINT          NULL,
    [LineNumber]               BIGINT          NULL,
    [OrderMovementId]          BIGINT          NULL,
    [PlannedQuantity]          DECIMAL (18, 6) NULL,
    [ActualQuantity]           DECIMAL (18, 6) NULL,
    [DeliveryStartTime]        DATETIME        NULL,
    [DeliveryEndTime]          DATETIME        NULL,
    [IsPumped]                 BIT             NULL,
    [IsDeliveredAll]           BIT             NULL,
    [OMLotNumber]              NVARCHAR (250)  NULL,
    [IsActive]                 BIT             NULL,
    [CreatedBy]                BIGINT          NULL,
    [CreatedDate]              DATETIME        CONSTRAINT [DF_OrderProductMovement_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdateBy]                 BIGINT          NULL,
    [UpdatedDate]              DATETIME        NULL,
    [OrderProductMovementGuid] NVARCHAR (350)  NULL,
    CONSTRAINT [PK_OrderProductMovement] PRIMARY KEY CLUSTERED ([OrderProductMovementId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_OrderProductMovement_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId]),
    CONSTRAINT [FK_OrderProductMovement_OrderMovement] FOREIGN KEY ([OrderMovementId]) REFERENCES [dbo].[OrderMovement] ([OrderMovementId])
);




GO
CREATE NONCLUSTERED INDEX [OrderProductMovementIndex_EnquieryGrid]
    ON [dbo].[OrderProductMovement]([IsActive] ASC)
    INCLUDE([OrderProductId], [OrderMovementId], [ActualQuantity]);

