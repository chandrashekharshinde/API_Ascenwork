CREATE TABLE [dbo].[CustomerGroupForPricing] (
    [CustomerGroupID]    NUMERIC (8)    NULL,
    [CustomerPriceGroup] NVARCHAR (50)  NULL,
    [GroupCode]          NVARCHAR (250) NULL,
    [CompanyId]          BIGINT         NULL,
    [IsActive]           BIT            NULL,
    [CreatedBy]          BIGINT         NULL,
    [CreatedDate]        DATETIME       NULL
);

