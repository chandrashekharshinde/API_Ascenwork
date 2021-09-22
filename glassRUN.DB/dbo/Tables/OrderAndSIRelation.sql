CREATE TABLE [dbo].[OrderAndSIRelation] (
    [OrderAndSIRelationId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [OrderId]              BIGINT   NOT NULL,
    [SIOrderId]            BIGINT   NULL,
    [CreatedBy]            BIGINT   NOT NULL,
    [CreatedDate]          DATETIME NOT NULL,
    [ModifiedBy]           BIGINT   NULL,
    [ModifiedDate]         DATETIME NULL,
    [IsActive]             BIT      NOT NULL,
    CONSTRAINT [PK_OrderAndSIRelation] PRIMARY KEY CLUSTERED ([OrderAndSIRelationId] ASC)
);

