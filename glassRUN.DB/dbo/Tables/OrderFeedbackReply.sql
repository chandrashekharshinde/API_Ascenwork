CREATE TABLE [dbo].[OrderFeedbackReply] (
    [OrderFeedbackReplyId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderFeedbackId]            BIGINT         NULL,
    [ParentOrderFeedbackReplyId] BIGINT         NULL,
    [Comment]                    NVARCHAR (MAX) NULL,
    [CommentBy]                  BIGINT         NULL,
    [IsRead]                     BIT            NULL,
    [CreatedBy]                  BIGINT         NOT NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [ModifiedBy]                 BIGINT         NULL,
    [ModifiedDate]               DATETIME       NULL,
    [IsActive]                   BIT            NOT NULL,
    [SequenceNo]                 BIGINT         NULL,
    CONSTRAINT [PK_OrderFeedbackReply] PRIMARY KEY CLUSTERED ([OrderFeedbackReplyId] ASC) WITH (FILLFACTOR = 80)
);

