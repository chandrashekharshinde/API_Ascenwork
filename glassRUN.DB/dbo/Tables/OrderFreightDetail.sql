CREATE TABLE [dbo].[OrderFreightDetail] (
    [OrderFreightDetailId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]              BIGINT          NOT NULL,
    [Particulars]          NVARCHAR (250)  NULL,
    [ChargedBasis]         NVARCHAR (250)  NULL,
    [ChargedWeight]        NVARCHAR (250)  NULL,
    [PerUnitCharge]        NVARCHAR (250)  NULL,
    [Amount]               DECIMAL (18, 2) NULL,
    [CreatedBy]            BIGINT          NULL,
    [CreatedDate]          DATETIME        NULL,
    [ModifiedBy]           BIGINT          NULL,
    [ModifiedDate]         DATETIME        NULL,
    [IsActive]             BIT             NULL,
    CONSTRAINT [PK_OrderFreightDetail] PRIMARY KEY CLUSTERED ([OrderFreightDetailId] ASC)
);

