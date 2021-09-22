CREATE TABLE [dbo].[PdcInformation] (
    [PdcInformationId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [PdcInformationGuid]      NVARCHAR (250) NULL,
    [SupplierLOBId]           BIGINT         NULL,
    [SupplierId]              BIGINT         NULL,
    [LOBId]                   BIGINT         NULL,
    [ModeOfPdcDocumentTypeId] BIGINT         NULL,
    [OrderId]                 BIGINT         NULL,
    [OrderProductId]          BIGINT         NULL,
    [LocationId]              BIGINT         NULL,
    [SubLocationId]           BIGINT         NULL,
    [IsGenerated]             BIT            NULL,
    [IsCompleted]             BIT            NULL,
    CONSTRAINT [PK_PdcInformation] PRIMARY KEY CLUSTERED ([PdcInformationId] ASC) WITH (FILLFACTOR = 80)
);

