CREATE TABLE [dbo].[LocationAndProductCategoryMapping] (
    [LocationAndProductCategoryMappingId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ObjectId]                            BIGINT        NULL,
    [ObjectType]                          NVARCHAR (50) NULL,
    [ProductCategoryId]                   BIGINT        NULL,
    [CreatedBy]                           BIGINT        NOT NULL,
    [CreatedDate]                         DATETIME      NOT NULL,
    [ModifiedBy]                          BIGINT        NULL,
    [ModifiedDate]                        DATETIME      NULL,
    [IsActive]                            BIT           NOT NULL,
    CONSTRAINT [PK_LocationAndProductCategoryMapping] PRIMARY KEY CLUSTERED ([LocationAndProductCategoryMappingId] ASC)
);

