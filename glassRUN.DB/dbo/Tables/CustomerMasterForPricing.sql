CREATE TABLE [dbo].[CustomerMasterForPricing] (
    [CustomerNumber]     NVARCHAR (250) NULL,
    [CustomerPriceGroup] NVARCHAR (50)  NULL,
    [IsActive]           BIT            NULL,
    [CreatedDate]        DATETIME       NULL,
    [CreatedBy]          BIGINT         NULL,
    [ModifiedDate]       DATETIME       NULL,
    [ModifiedBy]         BIGINT         NULL,
    [CompanyId]          BIGINT         NULL
);

