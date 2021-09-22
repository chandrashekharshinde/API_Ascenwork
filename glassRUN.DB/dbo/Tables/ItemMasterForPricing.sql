CREATE TABLE [dbo].[ItemMasterForPricing] (
    [ItemShortCode]   NUMERIC (8)  NULL,
    [ItemLongCode]    VARCHAR (25) NULL,
    [ItemDescription] VARCHAR (30) NULL,
    [ItemPriceGroup]  VARCHAR (8)  NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20200112-110722]
    ON [dbo].[ItemMasterForPricing]([ItemLongCode] ASC, [ItemPriceGroup] ASC);

