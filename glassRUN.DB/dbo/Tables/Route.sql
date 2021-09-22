CREATE TABLE [dbo].[Route] (
    [RouteId]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [CompanyId]            BIGINT         NULL,
    [RouteNumber]          NVARCHAR (50)  NULL,
    [OriginId]             BIGINT         NULL,
    [DestinationId]        BIGINT         NULL,
    [TruckSizeId]          BIGINT         NULL,
    [CarrierNumber]        NVARCHAR (50)  NULL,
    [PalletInclusionGroup] NVARCHAR (100) NULL,
    [IsActive]             BIT            NULL,
    [CreatedBy]            BIGINT         NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_Route_CreatedDate] DEFAULT (getdate()) NULL,
    [Updatedby]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED ([RouteId] ASC) WITH (FILLFACTOR = 80)
);

