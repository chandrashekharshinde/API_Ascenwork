CREATE TABLE [dbo].[InventoryTransaction] (
    [InventoryTransactionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [InventoryType]          BIGINT         NOT NULL,
    [TransmissionDate]       DATETIME       NULL,
    [CompanyCode]            NVARCHAR (250) NULL,
    [BranchPlantCode]        NVARCHAR (250) NULL,
    [ReferenceNumber]        NVARCHAR (250) NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             BIGINT         NULL,
    [ModifiedDate]           DATETIME       NULL,
    [DocumentNumber]         NVARCHAR (250) NULL,
    [OrderId]                BIGINT         NULL,
    [TruckBranchPlantCode]   NVARCHAR (250) NULL,
    CONSTRAINT [PK_InventoryTransaction] PRIMARY KEY CLUSTERED ([InventoryTransactionId] ASC)
);

