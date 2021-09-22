﻿CREATE TABLE [dbo].[LoseAssetsInRun] (
    [LoseAssetsInRunId]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [PlanNumber]              NVARCHAR (50)   NULL,
    [Location]                NVARCHAR (50)   NULL,
    [ProductCode]             NVARCHAR (200)  NULL,
    [ParentProductCode]       NVARCHAR (250)  NULL,
    [ProductType]             NVARCHAR (200)  NULL,
    [ProductQuantity]         DECIMAL (10, 2) NULL,
    [UnitPrice]               DECIMAL (18, 4) NULL,
    [EffectiveDate]           DATETIME        NULL,
    [DepositeAmount]          DECIMAL (10, 2) NULL,
    [TotalWeightMeasure]      DECIMAL (10, 2) NULL,
    [ShippableQuantity]       DECIMAL (10, 2) NULL,
    [BackOrderQuantity]       DECIMAL (10, 2) NULL,
    [CancelledQuantity]       DECIMAL (10, 2) NULL,
    [AssociatedOrder]         NVARCHAR (100)  NULL,
    [ItemType]                BIGINT          NULL,
    [Remarks]                 NVARCHAR (MAX)  NULL,
    [CreatedBy]               BIGINT          NOT NULL,
    [CreatedDate]             DATETIME        NOT NULL,
    [ModifiedBy]              BIGINT          NULL,
    [ModifiedDate]            DATETIME        NULL,
    [IsActive]                BIT             NOT NULL,
    [SequenceNo]              BIGINT          NULL,
    [InvoiceNumber]           NVARCHAR (150)  NULL,
    [Field1]                  NVARCHAR (500)  NULL,
    [Field2]                  NVARCHAR (500)  NULL,
    [Field3]                  NVARCHAR (500)  NULL,
    [Field4]                  NVARCHAR (500)  NULL,
    [Field5]                  NVARCHAR (500)  NULL,
    [Field6]                  NVARCHAR (500)  NULL,
    [Field7]                  NVARCHAR (500)  NULL,
    [Field8]                  NVARCHAR (500)  NULL,
    [Field9]                  NVARCHAR (500)  NULL,
    [Field10]                 NVARCHAR (500)  NULL,
    [DiscountPercent]         DECIMAL (18, 2) NULL,
    [DiscountAmount]          DECIMAL (18, 2) NULL,
    [IsProductShipConfirmed]  BIT             NULL,
    [ReferenceOrderId]        BIGINT          NULL,
    [ReferenceOrderProductId] BIGINT          NULL,
    [OrderProductGuid]        NVARCHAR (350)  NULL,
    CONSTRAINT [PK_LoseAssetsInRun] PRIMARY KEY CLUSTERED ([LoseAssetsInRunId] ASC)
);

