CREATE TABLE [dbo].[OrderStateMapping] (
    [OrderStateMappingId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [LocalOrderState]     BIGINT   NULL,
    [ThirdPartyOrderSate] BIGINT   NULL,
    [CreatedBy]           BIGINT   NOT NULL,
    [CreatedDate]         DATETIME NOT NULL,
    [ModifiedBy]          BIGINT   NULL,
    [ModifiedDate]        DATETIME NULL,
    [IsActive]            BIT      NOT NULL,
    CONSTRAINT [PK_OrderStateMapping] PRIMARY KEY CLUSTERED ([OrderStateMappingId] ASC) WITH (FILLFACTOR = 80)
);

