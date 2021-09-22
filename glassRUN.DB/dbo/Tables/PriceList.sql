CREATE TABLE [dbo].[PriceList] (
    [PriceListId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]               NVARCHAR (200) NOT NULL,
    [IsDefaultPriceType] BIT            NULL,
    [IsActive]           BIT            NOT NULL,
    [CreatedBy]          BIGINT         NOT NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_PriceType_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          BIGINT         NULL,
    [UpdatedDate]        DATETIME       NULL,
    [IPAddress]          NVARCHAR (20)  NULL,
    CONSTRAINT [PK_PriceType] PRIMARY KEY CLUSTERED ([PriceListId] ASC) WITH (FILLFACTOR = 80)
);

