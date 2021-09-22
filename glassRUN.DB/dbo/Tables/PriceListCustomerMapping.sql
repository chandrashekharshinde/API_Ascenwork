CREATE TABLE [dbo].[PriceListCustomerMapping] (
    [PriceListCustomerMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [CustomerId]                 BIGINT NOT NULL,
    [PriceListId]                INT    NOT NULL,
    [IsActive]                   BIT    NOT NULL,
    CONSTRAINT [PK_ObjectTypeSectionMapping] PRIMARY KEY CLUSTERED ([PriceListCustomerMappingId] ASC) WITH (FILLFACTOR = 80)
);

