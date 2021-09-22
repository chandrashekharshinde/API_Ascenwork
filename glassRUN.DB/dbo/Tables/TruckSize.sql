CREATE TABLE [dbo].[TruckSize] (
    [TruckSizeId]           BIGINT          IDENTITY (1, 1) NOT NULL,
    [VehicleType]           BIGINT          NULL,
    [TruckSize]             NVARCHAR (50)   NULL,
    [TruckCapacityPalettes] DECIMAL (18, 2) NULL,
    [TruckCapacityWeight]   DECIMAL (18, 2) NULL,
    [IsActive]              BIT             NULL,
    [Height]                DECIMAL (18, 2) NULL,
    [Width]                 DECIMAL (18, 2) NULL,
    [Length]                DECIMAL (18, 2) NULL,
    [CreatedBy]             BIGINT          NULL,
    [CreatedDate]           DATETIME        NULL,
    [UpdatedBy]             BIGINT          NULL,
    [UpdatedDate]           DATETIME        NULL,
    CONSTRAINT [PK_TruckSize] PRIMARY KEY CLUSTERED ([TruckSizeId] ASC) WITH (FILLFACTOR = 80)
);

