﻿CREATE TABLE [dbo].[OrderHistory] (
    [OrderHistoryId]                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]                           BIGINT          NULL,
    [CompanyId]                         BIGINT          NULL,
    [CompanyCode]                       NVARCHAR (250)  NULL,
    [OrderNumber]                       NVARCHAR (100)  NULL,
    [EnquiryId]                         BIGINT          NULL,
    [PickDateTime]                      DATETIME        NULL,
    [ExpectedTimeOfDelivery]            DATETIME        NULL,
    [CarrierETA]                        DATETIME        NULL,
    [CarrierETD]                        DATETIME        NULL,
    [OrderDate]                         DATETIME        NULL,
    [TruckSizeId]                       BIGINT          NULL,
    [SoldTo]                            BIGINT          NULL,
    [SoldToCode]                        NVARCHAR (250)  NULL,
    [SoldToName]                        NVARCHAR (250)  NULL,
    [ShipTo]                            BIGINT          NULL,
    [ShipToCode]                        NVARCHAR (250)  NULL,
    [ShipToName]                        NVARCHAR (250)  NULL,
    [PrimaryAddressId]                  BIGINT          NULL,
    [SecondaryAddressId]                BIGINT          NULL,
    [PrimaryAddress]                    NVARCHAR (500)  NULL,
    [SecondaryAddress]                  NVARCHAR (500)  NULL,
    [ModeOfDelivery]                    NVARCHAR (200)  NULL,
    [OrderType]                         NVARCHAR (200)  NULL,
    [PurchaseOrderNumber]               NVARCHAR (200)  NULL,
    [SalesOrderNumber]                  NVARCHAR (200)  NULL,
    [PickNumber]                        NVARCHAR (200)  NULL,
    [Remarks]                           NVARCHAR (MAX)  NULL,
    [PreviousState]                     BIGINT          NULL,
    [CurrentState]                      BIGINT          NULL,
    [NextState]                         BIGINT          NULL,
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
    [SequenceNo]                        BIGINT          NULL,
    [CarrierNumber]                     NVARCHAR (50)   NULL,
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
    [IsSIOI]                            BIGINT          NULL,
    [IsSendToWMS]                       BIT             NULL,
    [ParentOrderId]                     BIGINT          NULL,
    [IsInventoryTransfer]               BIT             NULL,
    [DiscountPercent]                   DECIMAL (18, 2) NULL,
    [DiscountAmount]                    DECIMAL (18, 2) NULL,
    [TotalDiscountAmount]               DECIMAL (18, 2) NULL,
    [TruckBranchPlantLocationId]        BIGINT          NULL,
    [TotalAmount]                       DECIMAL (18, 2) NULL,
    [PresellerCode]                     NVARCHAR (100)  NULL,
    [PresellerName]                     NVARCHAR (500)  NULL,
    [IsLockFromWMS]                     BIGINT          NULL,
    [IsVatIntegrationProcessed]         BIT             NULL,
    [TotalTaxAmount]                    DECIMAL (18, 2) NULL,
    [TotalQuantity]                     DECIMAL (18, 2) NULL,
    [TotalPrice]                        DECIMAL (18, 2) NULL,
    [TotalVolume]                       DECIMAL (18, 2) NULL,
    [TotalWeight]                       DECIMAL (18, 2) NULL,
    [NumberOfCrate]                     BIGINT          NULL,
    [PaymentTerm]                       BIGINT          NULL,
    CONSTRAINT [PK_OrderHistory] PRIMARY KEY CLUSTERED ([OrderHistoryId] ASC) WITH (FILLFACTOR = 80)
);
