CREATE TABLE [dbo].[Order] (
    [OrderId]                           BIGINT          IDENTITY (1, 1) NOT NULL,
    [CompanyId]                         BIGINT          CONSTRAINT [DF_Order_CompanyId] DEFAULT ((0)) NULL,
    [CompanyCode]                       NVARCHAR (250)  NULL,
    [CompanyName]                       NVARCHAR (250)  NULL,
    [OrderNumber]                       NVARCHAR (100)  NULL,
    [EnquiryId]                         BIGINT          CONSTRAINT [DF_Order_EnquiryId] DEFAULT ((0)) NULL,
    [PickDateTime]                      DATETIME        NULL,
    [ExpectedTimeOfDelivery]            DATETIME        NULL,
    [CarrierETA]                        DATETIME        NULL,
    [CarrierETD]                        DATETIME        NULL,
    [OrderDate]                         DATETIME        NULL,
    [TruckSizeId]                       BIGINT          CONSTRAINT [DF_Order_TruckSizeId] DEFAULT ((0)) NULL,
    [SoldTo]                            BIGINT          CONSTRAINT [DF_Order_SoldTo] DEFAULT ((0)) NULL,
    [SoldToCode]                        NVARCHAR (250)  NULL,
    [SoldToName]                        NVARCHAR (250)  NULL,
    [ShipTo]                            BIGINT          CONSTRAINT [DF_Order_ShipTo] DEFAULT ((0)) NULL,
    [ShipToCode]                        NVARCHAR (250)  NULL,
    [ShipToName]                        NVARCHAR (250)  NULL,
    [PrimaryAddressId]                  BIGINT          CONSTRAINT [DF_Order_PrimaryAddressId] DEFAULT ((0)) NULL,
    [SecondaryAddressId]                BIGINT          CONSTRAINT [DF_Order_SecondaryAddressId] DEFAULT ((0)) NULL,
    [PrimaryAddress]                    NVARCHAR (500)  NULL,
    [SecondaryAddress]                  NVARCHAR (500)  NULL,
    [ModeOfDelivery]                    NVARCHAR (200)  NULL,
    [OrderType]                         NVARCHAR (200)  NULL,
    [PurchaseOrderNumber]               NVARCHAR (200)  NULL,
    [SalesOrderNumber]                  NVARCHAR (200)  NULL,
    [PickNumber]                        NVARCHAR (200)  NULL,
    [Remarks]                           NVARCHAR (MAX)  NULL,
    [PreviousState]                     BIGINT          CONSTRAINT [DF_Order_PreviousState] DEFAULT ((0)) NULL,
    [CurrentState]                      BIGINT          CONSTRAINT [DF_Order_CurrentState] DEFAULT ((0)) NULL,
    [NextState]                         BIGINT          CONSTRAINT [DF_Order_NextState] DEFAULT ((0)) NULL,
    [IsRecievingLocationCapacityExceed] BIT             NULL,
    [IsPickConfirmed]                   BIT             NULL,
    [IsPrintPickSlip]                   BIT             NULL,
    [IsSTOTUpdated]                     BIT             NULL,
    [StockLocationId]                   NVARCHAR (50)   NULL,
    [CreatedBy]                         BIGINT          NOT NULL,
    [CreatedDate]                       DATETIME        NOT NULL,
    [ModifiedBy]                        BIGINT          NULL,
    [ModifiedDate]                      DATETIME        NULL,
    [IsActive]                          BIT             NOT NULL,
    [SequenceNo]                        BIGINT          CONSTRAINT [DF_Order_SequenceNo] DEFAULT ((0)) NULL,
    [CarrierNumber]                     NVARCHAR (50)   NULL,
    [CarrierCode]                       NVARCHAR (250)  NULL,
    [CarrierName]                       NVARCHAR (250)  NULL,
    [PalletSpace]                       DECIMAL (18, 2) NULL,
    [NumberOfPalettes]                  DECIMAL (18, 2) NULL,
    [TruckWeight]                       DECIMAL (18, 2) NULL,
    [Description1]                      NVARCHAR (500)  NULL,
    [Description2]                      NVARCHAR (500)  NULL,
    [OrderedBy]                         NVARCHAR (50)   NULL,
    [GratisCode]                        NVARCHAR (50)   NULL,
    [Province]                          NVARCHAR (50)   NULL,
    [InvoiceNumber]                     NVARCHAR (150)  NULL,
    [Field1]                            NVARCHAR (500)  NULL,
    [Field2]                            NVARCHAR (500)  NULL,
    [Field3]                            NVARCHAR (500)  NULL,
    [Field4]                            NVARCHAR (500)  NULL,
    [Field5]                            NVARCHAR (500)  NULL,
    [Field6]                            NVARCHAR (500)  NULL,
    [Field7]                            NVARCHAR (500)  NULL,
    [Field8]                            NVARCHAR (500)  NULL,
    [Field9]                            NVARCHAR (500)  NULL,
    [Field10]                           NVARCHAR (500)  NULL,
    [LoadNumber]                        NVARCHAR (500)  NULL,
    [ReferenceNumber]                   NVARCHAR (100)  NULL,
    [HoldStatus]                        NVARCHAR (150)  NULL,
    [RedInvoiceNumber]                  NVARCHAR (200)  NULL,
    [SI]                                NVARCHAR (250)  NULL,
    [OI]                                NVARCHAR (250)  NULL,
    [ReferenceForSIOI]                  NVARCHAR (250)  NULL,
    [IsSIOI]                            BIGINT          CONSTRAINT [DF_Order_IsSIOI] DEFAULT ((0)) NULL,
    [IsSendToWMS]                       BIT             NULL,
    [ParentOrderId]                     BIGINT          CONSTRAINT [DF_Order_ParentOrderId] DEFAULT ((0)) NULL,
    [IsInventoryTransfer]               BIT             NULL,
    [DiscountPercent]                   DECIMAL (18, 2) NULL,
    [DiscountAmount]                    DECIMAL (18, 2) NULL,
    [TotalDiscountAmount]               DECIMAL (18, 2) NULL,
    [TruckBranchPlantLocationId]        BIGINT          CONSTRAINT [DF_Order_TruckBranchPlantLocationId] DEFAULT ((0)) NULL,
    [TotalAmount]                       DECIMAL (18, 2) NULL,
    [PresellerCode]                     NVARCHAR (100)  NULL,
    [PresellerName]                     NVARCHAR (500)  NULL,
    [IsLockFromWMS]                     BIGINT          CONSTRAINT [DF_Order_IsLockFromWMS] DEFAULT ((0)) NULL,
    [IsVatIntegrationProcessed]         BIT             NULL,
    [TotalDepositeAmount]               DECIMAL (18, 2) NULL,
    [TotalTaxAmount]                    DECIMAL (18, 2) NULL,
    [TotalQuantity]                     DECIMAL (18, 2) NULL,
    [TotalPrice]                        DECIMAL (18, 2) NULL,
    [TotalVolume]                       DECIMAL (18, 2) NULL,
    [TotalWeight]                       DECIMAL (18, 2) NULL,
    [NumberOfCrate]                     BIGINT          CONSTRAINT [DF_Order_NumberOfCrate] DEFAULT ((0)) NULL,
    [PaymentTerm]                       BIGINT          CONSTRAINT [DF_Order_PaymentTerm] DEFAULT ((0)) NULL,
    [IsSelfCollect]                     BIT             NULL,
    [BillTo]                            BIGINT          CONSTRAINT [DF_Order_BillTo] DEFAULT ((0)) NULL,
    [BillToCode]                        NVARCHAR (200)  NULL,
    [BillToName]                        NVARCHAR (200)  NULL,
    [CollectionLocationId]              BIGINT          NULL,
    [CollectionLocationCode]            NVARCHAR (200)  NULL,
    [CollectionLocationName]            NVARCHAR (200)  NULL,
    [TruckSize]                         NVARCHAR (50)   NULL,
    [RejectionReasonCode]               NVARCHAR (50)   NULL,
    [RejectionComment]                  NVARCHAR (500)  NULL,
    [EnquiryAutoNumber]                 NVARCHAR (100)  NULL,
    [EnquiryDate]                       DATETIME        NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([OrderId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [uniqueOrderNumber] UNIQUE NONCLUSTERED ([OrderNumber] ASC, [OrderType] ASC, [CompanyId] ASC)
);




GO
CREATE NONCLUSTERED INDEX [Index_OrderScheduled_Order]
    ON [dbo].[Order]([SoldTo] ASC, [ShipTo] ASC, [ExpectedTimeOfDelivery] ASC);


GO
CREATE NONCLUSTERED INDEX [Index_Order_OrderScheduled]
    ON [dbo].[Order]([OrderType] ASC)
    INCLUDE([OrderNumber]);


GO
CREATE NONCLUSTERED INDEX [IDX_Order_EnquiryId_EnquiryGrid]
    ON [dbo].[Order]([EnquiryId] ASC);


GO
CREATE NONCLUSTERED INDEX [Ix_Order_CurrentStateIsActive_DBA]
    ON [dbo].[Order]([OrderId] ASC, [SalesOrderNumber] ASC, [CurrentState] ASC)
    INCLUDE([CompanyId], [CompanyCode], [OrderNumber], [IsSelfCollect], [IsActive], [OrderedBy], [GratisCode], [Province], [InvoiceNumber], [LoadNumber], [HoldStatus], [CreatedDate], [ModifiedDate], [CarrierNumber], [CarrierCode], [Description1], [Description2], [OrderType], [PurchaseOrderNumber], [Remarks], [PreviousState], [StockLocationId], [CreatedBy], [ShipTo], [ShipToCode], [PrimaryAddressId], [SecondaryAddressId], [PrimaryAddress], [SecondaryAddress], [EnquiryId], [PickDateTime], [ExpectedTimeOfDelivery], [OrderDate], [TruckSizeId], [SoldTo]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'vat_number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Order', @level2type = N'COLUMN', @level2name = N'Field4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'vat_lottery', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Order', @level2type = N'COLUMN', @level2name = N'Field5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'vat_put', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Order', @level2type = N'COLUMN', @level2name = N'Field6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'vat_error', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Order', @level2type = N'COLUMN', @level2name = N'Field7';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'vat_qrdata', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Order', @level2type = N'COLUMN', @level2name = N'Field8';

