CREATE TABLE [dbo].[ItemBasePrice] (
    [ItemShortCode]   NUMERIC (8)     NULL,
    [ItemLongCode]    VARCHAR (25)    NULL,
    [AddressNumber]   NUMERIC (8)     NULL,
    [CurrencyCode]    VARCHAR (3)     NULL,
    [UOM]             VARCHAR (2)     NULL,
    [EffectiveDate]   INT             NULL,
    [ExpiryDate]      INT             NULL,
    [Price]           NUMERIC (18, 4) NULL,
    [CustomerGroupID] NUMERIC (8)     NULL,
    [ItemGroupId]     NUMERIC (8)     NULL
);


GO
CREATE NONCLUSTERED INDEX [IDX_ItemBasePrice_ItemLongCode]
    ON [dbo].[ItemBasePrice]([ItemLongCode] ASC);

