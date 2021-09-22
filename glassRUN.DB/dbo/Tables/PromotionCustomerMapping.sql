CREATE TABLE [dbo].[PromotionCustomerMapping] (
    [PromotionCustomerMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [CustomerId]                 BIGINT         NULL,
    [CustomerCode]               NVARCHAR (150) NULL,
    [SystemPromotionIdentifier]  NVARCHAR (250) NULL,
    [CompanyId]                  BIGINT         NULL,
    [IsActive]                   BIT            NULL,
    [CreatedBy]                  BIGINT         NULL,
    [CreatedDate]                DATETIME       NULL,
    [ModifiedBy]                 BIGINT         NULL,
    [ModifiedDate]               DATETIME       NULL,
    CONSTRAINT [PK_PromotionCustomerMapping] PRIMARY KEY CLUSTERED ([PromotionCustomerMappingId] ASC)
);

