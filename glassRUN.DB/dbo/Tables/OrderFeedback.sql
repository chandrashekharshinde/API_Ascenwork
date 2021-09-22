﻿CREATE TABLE [dbo].[OrderFeedback] (
    [OrderFeedbackId]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderId]                    BIGINT         NULL,
    [OrderProductId]             BIGINT         NULL,
    [FeedbackType]               NVARCHAR (500) NULL,
    [feedbackId]                 BIGINT         NULL,
    [Attachment]                 NVARCHAR (MAX) NULL,
    [Comment]                    NVARCHAR (500) NULL,
    [HVBLComment]                NVARCHAR (500) NULL,
    [Quantity]                   BIGINT         NULL,
    [ActualReceiveDate]          DATETIME       NULL,
    [ParentOrderFeedbackReplyId] BIGINT         NULL,
    [CreatedBy]                  BIGINT         NOT NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [ModifiedBy]                 BIGINT         NULL,
    [ModifiedDate]               DATETIME       NULL,
    [IsActive]                   BIT            NOT NULL,
    [SequenceNo]                 BIGINT         NULL,
    [IsRead]                     BIT            NULL,
    [Field1]                     NVARCHAR (500) NULL,
    [Field2]                     NVARCHAR (500) NULL,
    [Field3]                     NVARCHAR (500) NULL,
    [Field4]                     NVARCHAR (500) NULL,
    [Field5]                     NVARCHAR (500) NULL,
    [Field6]                     NVARCHAR (500) NULL,
    [Field7]                     NVARCHAR (500) NULL,
    [Field8]                     NVARCHAR (500) NULL,
    [Field9]                     NVARCHAR (500) NULL,
    [Field10]                    NVARCHAR (500) NULL,
    CONSTRAINT [PK_OrderFeedback] PRIMARY KEY CLUSTERED ([OrderFeedbackId] ASC) WITH (FILLFACTOR = 80)
);

