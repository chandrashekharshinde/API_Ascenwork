CREATE TABLE [dbo].[PromotionFocItemDetail] (
    [PromotionFocItemDetailId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ItemCode]                  NVARCHAR (150) NULL,
    [ItemQuanity]               BIGINT         NULL,
    [ItemUnitOfMeasure]         NVARCHAR (100) NULL,
    [FocItemCode]               NVARCHAR (150) NULL,
    [FocItemQuantity]           BIGINT         NULL,
    [FocItemUnitOfMeasure]      NVARCHAR (100) NULL,
    [Region]                    NVARCHAR (250) NULL,
    [FromDate]                  DATE           NULL,
    [ToDate]                    DATE           NULL,
    [PromotionIdentifier]       NVARCHAR (250) NULL,
    [SystemPromotionIdentifier] NVARCHAR (250) NULL,
    [IsShowCarousel]            BIT            NULL,
    [CompanyId]                 BIGINT         NULL,
    [IsActive]                  BIT            NOT NULL,
    [CreatedBy]                 BIGINT         NOT NULL,
    [CreatedDate]               DATETIME       NOT NULL,
    [UpdatedBy]                 BIGINT         NULL,
    [UpdatedDate]               DATETIME       NULL,
    CONSTRAINT [PK_PromotionFocItemDetail] PRIMARY KEY CLUSTERED ([PromotionFocItemDetailId] ASC) WITH (FILLFACTOR = 80)
);

