CREATE TABLE [dbo].[VehicleProductType] (
    [VehicleProductTypeId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TransportVehicleId]   BIGINT         NULL,
    [ProductTypeId]        BIGINT         NULL,
    [ProductType]          NVARCHAR (100) NULL,
    [IsActive]             BIT            CONSTRAINT [DF_VehicleProductType_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    CONSTRAINT [PK_VehicleProductType] PRIMARY KEY CLUSTERED ([VehicleProductTypeId] ASC)
);

