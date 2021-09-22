CREATE TABLE [dbo].[OrderInsuranceDetail] (
    [OrderInsuranceDetailId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderId]                BIGINT          NOT NULL,
    [GoodsInsured]           BIT             NULL,
    [PolicyNo]               NVARCHAR (250)  NULL,
    [PolicyAmount]           DECIMAL (18, 2) NULL,
    [Remarks]                NVARCHAR (250)  NULL,
    [InsuranceTakenBy]       NVARCHAR (250)  NULL,
    [CreatedBy]              BIGINT          NULL,
    [CreatedDate]            DATETIME        NULL,
    [ModifiedBy]             BIGINT          NULL,
    [ModifiedDate]           DATETIME        NULL,
    [IsActive]               BIT             NULL,
    CONSTRAINT [PK_OrderInsuranceDetailI] PRIMARY KEY CLUSTERED ([OrderInsuranceDetailId] ASC)
);

