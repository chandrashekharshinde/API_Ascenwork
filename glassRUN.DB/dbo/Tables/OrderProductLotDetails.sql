CREATE TABLE [dbo].[OrderProductLotDetails] (
    [OrderProductLotDetailsId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderProductId]                    BIGINT          NULL,
    [OrderId]                           BIGINT          NULL,
    [ProductCode]                       NVARCHAR (250)  NULL,
    [LotNumber]                         NVARCHAR (500)  NULL,
    [ExpiryDate]                        DATETIME        NULL,
    [BBDate]                            DATETIME        NULL,
    [Quantity]                          DECIMAL (18, 2) NULL,
    [CollectedQuantity]                 DECIMAL (18, 2) NULL,
    [DeliveredQuantity]                 DECIMAL (18, 2) NULL,
    [IsDelivered]                       BIT             NULL,
    [OrderProductLotGuId]               NVARCHAR (350)  NULL,
    [LineNumber]                        BIGINT          NULL,
    [IsPartialShip]                     BIT             NULL,
    [ReferenceOrderProductLotDetailsId] BIGINT          NULL,
    [IsGRN]                             BIT             NULL,
    [Status]                            NVARCHAR (50)   NULL
);

