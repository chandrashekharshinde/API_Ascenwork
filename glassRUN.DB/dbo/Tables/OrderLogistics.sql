CREATE TABLE [dbo].[OrderLogistics] (
    [OrderLogisticsId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [TransportVehicleId]  BIGINT         NULL,
    [DeliveryPersonnelId] BIGINT         NULL,
    [OrderMovementId]     BIGINT         NULL,
    [TruckId]             BIGINT         NULL,
    [TruckPlateNumber]    NVARCHAR (50)  NULL,
    [TruckInTime]         DATETIME       NULL,
    [TruckOutTime]        DATETIME       NULL,
    [Sequence]            BIGINT         NULL,
    [IsActive]            BIT            CONSTRAINT [DF_OrderLogistics_IsActive] DEFAULT ((1)) NULL,
    [CreatedBy]           BIGINT         NOT NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_OrderLogistics_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdateBy]            BIGINT         NULL,
    [UpdatedDate]         DATETIME       NULL,
    [DeliveryPersonName]  NVARCHAR (250) NULL,
    CONSTRAINT [PK_OrderLogistics] PRIMARY KEY CLUSTERED ([OrderLogisticsId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_OrderLogistics_OrderMovement] FOREIGN KEY ([OrderMovementId]) REFERENCES [dbo].[OrderMovement] ([OrderMovementId])
);



