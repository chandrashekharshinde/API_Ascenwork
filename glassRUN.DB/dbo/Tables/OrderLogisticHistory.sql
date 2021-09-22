CREATE TABLE [dbo].[OrderLogisticHistory] (
    [OrderLogisticHistoryId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderId]                BIGINT         NULL,
    [UserId]                 BIGINT         NULL,
    [OrderLogisticId]        BIGINT         NULL,
    [TruckId]                BIGINT         NULL,
    [PlateNumber]            NVARCHAR (50)  NULL,
    [PlateNumberType]        NVARCHAR (50)  NULL,
    [PlateNumberBy]          NVARCHAR (50)  NULL,
    [TransportVehicleId]     BIGINT         NULL,
    [DeliveryPersonnelId]    BIGINT         NULL,
    [OrderMovementId]        BIGINT         NULL,
    [DeliveryPersonName]     NVARCHAR (250) NULL,
    [Remark]                 NVARCHAR (500) NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             BIGINT         NULL,
    [ModifiedDate]           DATETIME       NULL,
    [IsActive]               BIT            NOT NULL,
    CONSTRAINT [PK_OrderLogisticHistory] PRIMARY KEY CLUSTERED ([OrderLogisticHistoryId] ASC) WITH (FILLFACTOR = 80)
);

