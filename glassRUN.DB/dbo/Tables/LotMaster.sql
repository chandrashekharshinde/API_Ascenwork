CREATE TABLE [dbo].[LotMaster] (
    [LotId]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [LotNumber]        NVARCHAR (50)  NOT NULL,
    [BusinessUnitCode] NVARCHAR (100) NOT NULL,
    [ItemId]           BIGINT         NULL,
    [ItemCode]         NVARCHAR (400) NULL,
    [ItemShortCode]    NVARCHAR (400) NULL,
    [CompanyCode]      NVARCHAR (100) NOT NULL,
    [LotCreationDate]  DATETIME       NOT NULL,
    [LotExpiryDate]    DATETIME       NOT NULL,
    [SellByDate]       DATETIME       NULL,
    [LotReusable]      CHAR (1)       NULL,
    [IsActive]         BIT            CONSTRAINT [DF_LotMaster_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]        BIGINT         CONSTRAINT [DF_LotMaster_CreatedBy] DEFAULT ((1)) NOT NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_LotMaster_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]       BIGINT         NULL,
    [ModifiedDate]     DATETIME       NULL,
    CONSTRAINT [PK_LotMaster] PRIMARY KEY CLUSTERED ([LotId] ASC)
);

