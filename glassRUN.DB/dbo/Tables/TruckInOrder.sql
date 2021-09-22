CREATE TABLE [dbo].[TruckInOrder] (
    [TruckInOrderId]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [PlateNumber]      NVARCHAR (100) NULL,
    [TruckInDeatilsId] BIGINT         NULL,
    [OrderNumber]      NVARCHAR (100) NULL,
    [TruckInDataTime]  DATETIME       NULL,
    [TruckOutDataTime] DATETIME       NULL,
    [IsLoadedInTruck]  BIT            NULL,
    [CreatedDate]      DATETIME       NULL,
    CONSTRAINT [PK_TruckInOrder] PRIMARY KEY CLUSTERED ([TruckInOrderId] ASC)
);

