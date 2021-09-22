CREATE TABLE [dbo].[Location] (
    [LocationId]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [LocationName]       NVARCHAR (200)  NULL,
    [DisplayName]        NVARCHAR (500)  NULL,
    [LocationCode]       NVARCHAR (200)  NULL,
    [CompanyID]          BIGINT          NULL,
    [LocationType]       BIGINT          NULL,
    [LocationIdentifier] BIGINT          NULL,
    [Area]               NVARCHAR (500)  NULL,
    [AddressLine1]       NVARCHAR (500)  NULL,
    [AddressLine2]       NVARCHAR (500)  NULL,
    [AddressLine3]       NVARCHAR (500)  NULL,
    [AddressLine4]       NVARCHAR (500)  NULL,
    [City]               NVARCHAR (50)   NULL,
    [State]              NVARCHAR (50)   NULL,
    [Pincode]            NVARCHAR (50)   NULL,
    [Country]            BIGINT          NULL,
    [Email]              NVARCHAR (200)  NULL,
    [Parentid]           BIGINT          NULL,
    [Capacity]           DECIMAL (10, 2) NULL,
    [Safefill]           DECIMAL (10, 2) NULL,
    [ProductCode]        NVARCHAR (100)  NULL,
    [Description]        NVARCHAR (MAX)  NULL,
    [Remarks]            NVARCHAR (MAX)  NULL,
    [CreatedBy]          BIGINT          NOT NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_Location_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]         BIGINT          NULL,
    [ModifiedDate]       DATETIME        NULL,
    [IsActive]           BIT             CONSTRAINT [DF_Location_IsActive] DEFAULT ((1)) NOT NULL,
    [SequenceNo]         BIGINT          NULL,
    [Field1]             NVARCHAR (500)  NULL,
    [Field2]             NVARCHAR (500)  NULL,
    [Field3]             NVARCHAR (500)  NULL,
    [Field4]             NVARCHAR (500)  NULL,
    [Field5]             NVARCHAR (500)  NULL,
    [Field6]             NVARCHAR (500)  NULL,
    [Field7]             NVARCHAR (500)  NULL,
    [Field8]             NVARCHAR (500)  NULL,
    [Field9]             NVARCHAR (500)  NULL,
    [Field10]            NVARCHAR (500)  NULL,
    [AddressNumber]      NVARCHAR (500)  NULL,
    [IsAutomatedWMS]     BIT             NULL,
    [WMSBranchPlantCode] NCHAR (500)     NULL,
    [WareHouseType]      BIGINT          NULL,
    [BillType]           NVARCHAR (50)   NULL,
    [BusinessUnitCode]   NVARCHAR (200)  NULL,
    [ShipTo]             BIT             NULL,
    [BillTo]             BIT             NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_DeliveryLocation_CompanyID]
    ON [dbo].[Location]([CompanyID] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_DeliveryLocation_DeliveryLocationCode]
    ON [dbo].[Location]([LocationCode] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Port Berth Vessel or Tank', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Location', @level2type = N'COLUMN', @level2name = N'LocationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Or Secondary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Location', @level2type = N'COLUMN', @level2name = N'LocationIdentifier';

