CREATE TABLE [dbo].[PriceListDetails] (
    [PriceListDetailsId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [ItemId]             BIGINT          NOT NULL,
    [Amount]             DECIMAL (18, 2) NULL,
    [IsTaxInclusive]     BIT             NULL,
    [PriceListId]        BIGINT          NULL,
    [IsActive]           BIT             NOT NULL,
    [CreatedBy]          BIGINT          NOT NULL,
    [CreatedDate]        DATETIME        NOT NULL,
    [UpdateBy]           BIGINT          NULL,
    [UpdatedDate]        DATETIME        NULL,
    [IPAddress]          NVARCHAR (20)   NULL,
    CONSTRAINT [PK_PriceListDetails] PRIMARY KEY CLUSTERED ([PriceListDetailsId] ASC) WITH (FILLFACTOR = 80)
);

