CREATE TABLE [dbo].[OrderTripCost] (
    [OrderTripCostId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]         BIGINT          NULL,
    [OrderNumber]     NVARCHAR (200)  NULL,
    [TripCost]        DECIMAL (18, 4) NULL,
    [TripRevenue]     DECIMAL (18, 4) NULL,
    [IsActive]        BIT             NULL,
    [CreatedDate]     DATETIME        NULL,
    CONSTRAINT [PK_OrderTripCost] PRIMARY KEY CLUSTERED ([OrderTripCostId] ASC)
);

