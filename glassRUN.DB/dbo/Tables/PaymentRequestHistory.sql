﻿CREATE TABLE [dbo].[PaymentRequestHistory] (
    [PaymentRequestHistoryId]    BIGINT          IDENTITY (1, 1) NOT NULL,
    [PaymentRequestId]           BIGINT          NOT NULL,
    [OrderId]                    BIGINT          NULL,
    [OrderNumber]                NVARCHAR (50)   NULL,
    [SlabId]                     BIGINT          NULL,
    [SlabName]                   NVARCHAR (100)  NULL,
    [SlabReason]                 NVARCHAR (250)  NULL,
    [TransporterAccountDetailId] BIGINT          NULL,
    [AmountUnit]                 BIGINT          NULL,
    [Amount]                     DECIMAL (18, 4) NULL,
    [Percentage]                 NVARCHAR (50)   NULL,
    [ReasonCodeId]               BIGINT          NULL,
    [Remark]                     NVARCHAR (MAX)  NULL,
    [Status]                     BIGINT          NULL,
    [RequestDate]                DATETIME        NULL,
    [ApprovalDate]               DATETIME        NULL,
    [ApproveBy]                  BIGINT          NULL,
    [IsActive]                   BIT             NULL,
    [CreatedBy]                  BIGINT          NULL,
    [CreatedDate]                DATETIME        NULL,
    [UpdatedBy]                  BIGINT          NULL,
    [UpdatedDate]                DATETIME        NULL,
    [PaidAmount]                 DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_PaymentRequestHistory] PRIMARY KEY CLUSTERED ([PaymentRequestHistoryId] ASC)
);

