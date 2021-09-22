CREATE TABLE [dbo].[ItemSupplier] (
    [ItemSupplierId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [ItemId]          BIGINT         NOT NULL,
    [ItemCode]        NVARCHAR (200) NOT NULL,
    [ItemShortCode]   NVARCHAR (200) NULL,
    [CompanyId]       BIGINT         NOT NULL,
    [CompanyMnemonic] NVARCHAR (200) NULL,
    [IsActive]        BIT            NOT NULL,
    [CreatedBy]       BIGINT         NOT NULL,
    [CreatedDate]     DATETIME       NOT NULL,
    [ModifiedBy]      BIGINT         NULL,
    [ModifiedDate]    DATETIME       NULL,
    CONSTRAINT [PK_ItemSupplier] PRIMARY KEY CLUSTERED ([ItemSupplierId] ASC)
);

