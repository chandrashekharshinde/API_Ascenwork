CREATE TABLE [dbo].[BusinessUnit] (
    [BusinessUnitId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [BUcode]         NVARCHAR (200) NULL,
    [BUName]         NVARCHAR (500) NULL,
    [AddressLine1]   NVARCHAR (MAX) NULL,
    [AddressLine2]   NVARCHAR (MAX) NULL,
    [AddressLine3]   NVARCHAR (MAX) NULL,
    [City]           NVARCHAR (100) NULL,
    [State]          NVARCHAR (100) NULL,
    [CountryId]      BIGINT         NOT NULL,
    [Country]        NVARCHAR (50)  NULL,
    [Postcode]       NVARCHAR (20)  NULL,
    [CreatedBy]      BIGINT         NOT NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_BusinessUnit_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]     BIGINT         NULL,
    [ModifiedDate]   DATETIME       NULL,
    [IsActive]       BIT            CONSTRAINT [DF_BusinessUnit_IsActive] DEFAULT ((1)) NOT NULL
);

