CREATE TABLE [dbo].[ItemLedger] (
    [ItemLedgerId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ItemCode]         NVARCHAR (200) NULL,
    [BusinessUnitCode] NVARCHAR (200) NULL,
    [ItemQuantity]     FLOAT (53)     NULL,
    [LocationCode]     NVARCHAR (200) NULL,
    [SubLocationCode]  NCHAR (200)    NULL,
    [LotNumber]        NVARCHAR (250) NULL,
    [TransactionType]  BIGINT         NULL,
    [TransactionDate]  DATETIME       NULL,
    [ReferenceNumber]  NVARCHAR (250) NULL,
    [LineOrder]        NVARCHAR (50)  NULL,
    [CompanyID]        BIGINT         NULL,
    [CreatedBy]        BIGINT         NOT NULL,
    [CreatedDate]      DATETIME       NOT NULL,
    [ModifiedBy]       BIGINT         NULL,
    [ModifiedDate]     DATETIME       NULL,
    [IsActive]         BIT            NOT NULL,
    CONSTRAINT [PK_ItemLedger] PRIMARY KEY CLUSTERED ([ItemLedgerId] ASC)
);

