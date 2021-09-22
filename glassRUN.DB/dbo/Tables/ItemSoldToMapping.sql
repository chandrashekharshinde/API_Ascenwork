CREATE TABLE [dbo].[ItemSoldToMapping] (
    [ItemSoldToMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ItemId]              BIGINT         NULL,
    [SoldTo]              NVARCHAR (50)  NULL,
    [ShipTo]              BIGINT         NULL,
    [CreatedBy]           BIGINT         NOT NULL,
    [CreatedDate]         DATETIME       NOT NULL,
    [ModifiedBy]          BIGINT         NULL,
    [ModifiedDate]        DATETIME       NULL,
    [IsActive]            BIT            NOT NULL,
    [SequenceNo]          BIGINT         NULL,
    [Field1]              NVARCHAR (500) NULL,
    [Field2]              NVARCHAR (500) NULL,
    [Field3]              NVARCHAR (500) NULL,
    [Field4]              NVARCHAR (500) NULL,
    [Field5]              NVARCHAR (500) NULL,
    [Field6]              NVARCHAR (500) NULL,
    [Field7]              NVARCHAR (500) NULL,
    [Field8]              NVARCHAR (500) NULL,
    [Field9]              NVARCHAR (500) NULL,
    [Field10]             NVARCHAR (500) NULL,
    CONSTRAINT [PK_ItemSoldToMapping] PRIMARY KEY CLUSTERED ([ItemSoldToMappingId] ASC) WITH (FILLFACTOR = 80)
);

