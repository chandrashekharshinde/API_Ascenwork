CREATE TABLE [dbo].[Enquiry] (
    [EnquiryId]                         BIGINT          IDENTITY (1, 1) NOT NULL,
    [CompanyId]                         BIGINT          CONSTRAINT [DF_Enquiry_CompanyId] DEFAULT ((0)) NULL,
    [CompanyCode]                       NVARCHAR (250)  NULL,
    [CompanyName]                       NVARCHAR (250)  NULL,
    [EnquiryGroupNumber]                NVARCHAR (250)  NULL,
    [EnquiryAutoNumber]                 NVARCHAR (100)  NULL,
    [EnquiryType]                       NVARCHAR (50)   NULL,
    [SoldTo]                            BIGINT          CONSTRAINT [DF_Enquiry_SoldTo] DEFAULT ((0)) NULL,
    [SoldToCode]                        NVARCHAR (250)  NULL,
    [SoldToName]                        NVARCHAR (250)  NULL,
    [ShipTo]                            BIGINT          NOT NULL,
    [ShipToCode]                        NVARCHAR (250)  NULL,
    [ShipToName]                        NVARCHAR (250)  NULL,
    [PickDateTime]                      DATETIME        NULL,
    [EnquiryDate]                       DATETIME        NULL,
    [RequestDate]                       DATETIME        NULL,
    [PrimaryAddressId]                  BIGINT          CONSTRAINT [DF_Enquiry_PrimaryAddressId] DEFAULT ((0)) NULL,
    [SecondaryAddressId]                BIGINT          CONSTRAINT [DF_Enquiry_SecondaryAddressId] DEFAULT ((0)) NULL,
    [PrimaryAddress]                    NVARCHAR (500)  NULL,
    [SecondaryAddress]                  NVARCHAR (500)  NULL,
    [OrderProposedETD]                  DATETIME        NULL,
    [Remarks]                           NVARCHAR (MAX)  NULL,
    [PreviousState]                     BIGINT          CONSTRAINT [DF_Enquiry_PreviousState] DEFAULT ((0)) NULL,
    [CurrentState]                      BIGINT          CONSTRAINT [DF_Enquiry_CurrentState] DEFAULT ((0)) NULL,
    [PreviousProcess]                   BIGINT          CONSTRAINT [DF_Enquiry_PreviousProcess] DEFAULT ((0)) NULL,
    [CurrentProcess]                    BIGINT          CONSTRAINT [DF_Enquiry_CurrentProcess] DEFAULT ((0)) NULL,
    [TruckSizeId]                       BIGINT          CONSTRAINT [DF_Enquiry_TruckSizeId] DEFAULT ((0)) NULL,
    [PalletSpace]                       DECIMAL (18, 2) NULL,
    [NumberOfPalettes]                  DECIMAL (18, 2) NULL,
    [TruckWeight]                       DECIMAL (18, 2) NULL,
    [OrderedBy]                         BIGINT          CONSTRAINT [DF_Enquiry_OrderedBy] DEFAULT ((0)) NULL,
    [GratisCode]                        NVARCHAR (250)  NULL,
    [Province]                          NVARCHAR (250)  NULL,
    [Description1]                      NVARCHAR (250)  NULL,
    [Description2]                      NVARCHAR (250)  NULL,
    [IsRecievingLocationCapacityExceed] BIT             NULL,
    [StockLocationId]                   BIGINT          CONSTRAINT [DF_Enquiry_StockLocationId] DEFAULT ((0)) NULL,
    [CreatedBy]                         BIGINT          NOT NULL,
    [CreatedDate]                       DATETIME        NOT NULL,
    [ModifiedBy]                        BIGINT          CONSTRAINT [DF_Enquiry_ModifiedBy] DEFAULT ((0)) NULL,
    [ModifiedDate]                      DATETIME        NULL,
    [IsActive]                          BIT             NOT NULL,
    [SequenceNo]                        BIGINT          CONSTRAINT [DF_Enquiry_SequenceNo] DEFAULT ((0)) NULL,
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
    [ReturnableItemCheck]               INT             CONSTRAINT [DF_Enquiry_ReturnableItemCheck] DEFAULT ((0)) NULL,
    [ReceivingLocationCapacityCheck]    INT             CONSTRAINT [DF_Enquiry_ReceivingLocationCapacityCheck] DEFAULT ((0)) NULL,
    [StockCheck]                        INT             CONSTRAINT [DF_Enquiry_StockCheck] DEFAULT ((0)) NULL,
    [IsProcess]                         BIT             NULL,
    [PromisedDate]                      DATETIME        NULL,
    [PONumber]                          NVARCHAR (50)   NULL,
    [PaymentType]                       BIGINT          CONSTRAINT [DF_Enquiry_PaymentType] DEFAULT ((0)) NULL,
    [DiscountPercent]                   DECIMAL (18, 2) NULL,
    [DiscountAmount]                    DECIMAL (18, 2) NULL,
    [PaymentDiscountPercent]            DECIMAL (18, 2) NULL,
    [TotalDepositeAmount]               DECIMAL (18, 2) NULL,
    [TotalDiscountAmount]               DECIMAL (18, 2) NULL,
    [TotalAmount]                       DECIMAL (18, 2) NULL,
    [PresellerCode]                     NVARCHAR (100)  NULL,
    [PresellerName]                     NVARCHAR (500)  NULL,
    [TotalTaxAmount]                    DECIMAL (18, 2) NULL,
    [TotalQuantity]                     DECIMAL (18, 2) NULL,
    [TotalPrice]                        DECIMAL (18, 2) NULL,
    [TotalVolume]                       DECIMAL (18, 2) NULL,
    [TotalWeight]                       DECIMAL (18, 2) NULL,
    [NumberOfCrate]                     BIGINT          CONSTRAINT [DF_Enquiry_NumberOfCrate] DEFAULT ((0)) NULL,
    [CollectionLocationCode]            NVARCHAR (50)   NULL,
    [SONumber]                          NVARCHAR (50)   NULL,
    [EnquiryGuid]                       NVARCHAR (200)  NULL,
    [IsSelfCollect]                     BIT             NULL,
    [CarrierId]                         BIGINT          CONSTRAINT [DF_Enquiry_CarrierId] DEFAULT ((0)) NULL,
    [CarrierCode]                       NVARCHAR (250)  NULL,
    [CarrierName]                       NVARCHAR (250)  NULL,
    [OriginalCollectionDate]            DATETIME        NULL,
    [BillToId]                          BIGINT          CONSTRAINT [DF_Enquiry_BillToId] DEFAULT ((0)) NULL,
    [BillToCode]                        NVARCHAR (250)  NULL,
    [CollectionLocationId]              BIGINT          NULL,
    [CollectionLocationName]            NVARCHAR (200)  NULL,
    [TruckSize]                         NVARCHAR (50)   NULL,
    CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED ([EnquiryId] ASC),
    CONSTRAINT [uniqueEnquriyAutoNumber] UNIQUE NONCLUSTERED ([EnquiryAutoNumber] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IDX_Enquiry_CreatedDate]
    ON [dbo].[Enquiry]([CreatedDate] ASC, [ModifiedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_Enquiry_SoldTo]
    ON [dbo].[Enquiry]([SoldTo] ASC, [ShipTo] ASC);


GO
CREATE NONCLUSTERED INDEX [ModifiedPagingIndex_RequestDate]
    ON [dbo].[Enquiry]([SoldTo] ASC, [ShipTo] ASC, [CurrentState] ASC)
    INCLUDE([RequestDate], [OrderProposedETD], [NumberOfPalettes]);

