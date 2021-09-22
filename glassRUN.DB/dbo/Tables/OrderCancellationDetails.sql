CREATE TABLE [dbo].[OrderCancellationDetails] (
    [OrderCancellationDetailsId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderNumber]                NVARCHAR (250) NULL,
    [OrderId]                    BIGINT         NULL,
    [UserId]                     BIGINT         NULL,
    [CancellationDatetime]       DATETIME       NULL,
    [CancellationReason]         NVARCHAR (50)  NULL,
    [Remarks]                    NVARCHAR (500) NULL,
    [IsActive]                   BIT            NULL,
    CONSTRAINT [PK_OrderCancellationDetails] PRIMARY KEY CLUSTERED ([OrderCancellationDetailsId] ASC)
);

