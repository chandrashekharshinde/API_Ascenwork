CREATE TABLE [dbo].[TruckInDeatils] (
    [TruckInDeatilsId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [PlateNumber]       NVARCHAR (100) NULL,
    [TruckId]           BIGINT         NULL,
    [DriverName]        NVARCHAR (500) NULL,
    [DriverId]          BIGINT         NULL,
    [TruckInDataTime]   DATETIME       NULL,
    [TruckOutDataTime]  DATETIME       NULL,
    [StockLocationCode] NVARCHAR (MAX) NULL,
    [CarrierId]         BIGINT         NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [IsActive]          BIT            NOT NULL,
    CONSTRAINT [PK_TruckInDeatils] PRIMARY KEY CLUSTERED ([TruckInDeatilsId] ASC)
);

