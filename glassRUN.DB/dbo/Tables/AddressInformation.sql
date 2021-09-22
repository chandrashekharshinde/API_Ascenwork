CREATE TABLE [dbo].[AddressInformation] (
    [AddressInformationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectId]             BIGINT         NULL,
    [ObjectType]           NVARCHAR (250) NULL,
    [AddressLine1]         NVARCHAR (500) NULL,
    [AddressLine2]         NVARCHAR (500) NULL,
    [AddressLine3]         NVARCHAR (500) NULL,
    [AddressLine4]         NVARCHAR (500) NULL,
    [CityId]               BIGINT         NULL,
    [CityName]             NVARCHAR (250) NULL,
    [StateId]              BIGINT         NULL,
    [StateName]            NVARCHAR (250) NULL,
    [CountryId]            BIGINT         NULL,
    [CountryName]          NVARCHAR (250) NULL,
    [Pincode]              NVARCHAR (250) NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [ModifiedBy]           BIGINT         NULL,
    [ModifiedDate]         DATETIME       NULL,
    [IsActive]             BIT            NOT NULL,
    CONSTRAINT [PK_AddressInformation] PRIMARY KEY CLUSTERED ([AddressInformationId] ASC)
);

