CREATE TABLE [dbo].[FavouriteItem] (
    [FavouriteItemId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]       BIGINT        NULL,
    [ItemId]          BIGINT        NULL,
    [ItemCode]        NVARCHAR (50) NULL,
    [IsActive]        BIT           NOT NULL,
    [CreatedBy]       BIGINT        CONSTRAINT [DF_FavouriteItem_CreatedBy] DEFAULT ((1)) NOT NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF_FavouriteItem_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]       BIGINT        NULL,
    [UpdatedDate]     DATETIME      NULL,
    [Loginid]         BIGINT        NULL,
    CONSTRAINT [PK_FavouriteItem] PRIMARY KEY CLUSTERED ([FavouriteItemId] ASC)
);

