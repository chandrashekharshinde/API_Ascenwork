CREATE TABLE [dbo].[VehicleCompartment] (
    [VehicleCompartmentId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [TransportVehicleId]   BIGINT          NULL,
    [CompartmentName]      NVARCHAR (100)  NULL,
    [Capacity]             DECIMAL (18, 2) NULL,
    [UnitOfMeasureId]      BIGINT          NULL,
    [UnitOfMeasure]        NVARCHAR (100)  NULL,
    [IsActive]             BIT             CONSTRAINT [DF_VehicleCompartment_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]            BIGINT          NOT NULL,
    [CreatedDate]          DATETIME        NOT NULL,
    [UpdatedBy]            BIGINT          NULL,
    [UpdatedDate]          DATETIME        NULL,
    CONSTRAINT [PK_VehicleCompartment] PRIMARY KEY CLUSTERED ([VehicleCompartmentId] ASC)
);

