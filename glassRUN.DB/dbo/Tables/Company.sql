﻿CREATE TABLE [dbo].[Company] (
    [CompanyId]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [CompanyName]          NVARCHAR (500) NOT NULL,
    [CompanyMnemonic]      NVARCHAR (200) NULL,
    [CompanyType]          NVARCHAR (50)  NULL,
    [ParentCompany]        BIGINT         NULL,
    [AddressLine1]         NVARCHAR (MAX) NULL,
    [AddressLine2]         NVARCHAR (MAX) NULL,
    [AddressLine3]         NVARCHAR (MAX) NULL,
    [City]                 NVARCHAR (100) NULL,
    [State]                NVARCHAR (100) NULL,
    [CountryId]            BIGINT         NOT NULL,
    [Country]              NVARCHAR (50)  NULL,
    [Postcode]             NVARCHAR (20)  NULL,
    [Region]               NVARCHAR (20)  NULL,
    [RouteCode]            NVARCHAR (20)  NULL,
    [ZoneCode]             NVARCHAR (20)  NULL,
    [CategoryCode]         NVARCHAR (20)  NULL,
    [BranchPlant]          NVARCHAR (200) NULL,
    [Email]                NVARCHAR (MAX) NULL,
    [TaxId]                NVARCHAR (200) NULL,
    [SoldTo]               NVARCHAR (200) NULL,
    [ShipTo]               NVARCHAR (200) NULL,
    [BillTo]               NVARCHAR (200) NULL,
    [SiteURL]              NVARCHAR (200) NULL,
    [ContactPersonNumber]  NVARCHAR (20)  NULL,
    [ContactPersonName]    NVARCHAR (500) NULL,
    [logo]                 NVARCHAR (MAX) NULL,
    [header]               NVARCHAR (MAX) NULL,
    [footer]               NVARCHAR (MAX) NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [ModifiedBy]           BIGINT         NULL,
    [ModifiedDate]         DATETIME       NULL,
    [IsActive]             BIT            NOT NULL,
    [SequenceNo]           BIGINT         NULL,
    [SubChannel]           NVARCHAR (50)  NULL,
    [Field1]               NVARCHAR (500) NULL,
    [Field2]               NVARCHAR (500) NULL,
    [Field3]               NVARCHAR (500) NULL,
    [Field4]               NVARCHAR (500) NULL,
    [Field5]               NVARCHAR (500) NULL,
    [Field6]               NVARCHAR (500) NULL,
    [Field7]               NVARCHAR (500) NULL,
    [Field8]               NVARCHAR (500) NULL,
    [Field9]               NVARCHAR (500) NULL,
    [Field10]              NVARCHAR (500) NULL,
    [CreditLimit]          BIGINT         NULL,
    [AvailableCreditLimit] BIGINT         NULL,
    [EmptiesLimit]         BIGINT         NULL,
    [ActualEmpties]        BIGINT         NULL,
    [PaymentTermCode]      BIGINT         NULL,
    [CategoryType]         BIGINT         NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-company_companyMnemonic]
    ON [dbo].[Company]([CompanyMnemonic] ASC);
