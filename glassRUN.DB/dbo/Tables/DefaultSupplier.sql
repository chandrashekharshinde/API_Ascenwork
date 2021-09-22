CREATE TABLE [dbo].[DefaultSupplier] (
    [DefaultSupplierID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentCompanyId]   BIGINT         NOT NULL,
    [ParentCompanyCode] NVARCHAR (100) NULL,
    [CompanyId]         BIGINT         NULL,
    [CompanyCode]       NVARCHAR (100) NULL,
    [LocationId]        BIGINT         NULL,
    [LocationCode]      NVARCHAR (200) NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_DefaultSupplier_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [IsActive]          BIT            CONSTRAINT [DF_DefaultSupplier_IsActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_DefaultSupplier] PRIMARY KEY CLUSTERED ([DefaultSupplierID] ASC)
);

