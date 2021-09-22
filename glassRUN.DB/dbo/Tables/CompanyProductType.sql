CREATE TABLE [dbo].[CompanyProductType] (
    [CompanyProductTypeId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]            BIGINT        NULL,
    [ProductTypeName]      NVARCHAR (50) NULL,
    [ProductTypecode]      NVARCHAR (50) NULL,
    [IsActive]             BIT           NOT NULL,
    [CreatedBy]            BIGINT        NOT NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [UpdatedBy]            BIGINT        NULL,
    [UpdatedDate]          DATETIME      NULL,
    CONSTRAINT [PK_CompentProductType] PRIMARY KEY CLUSTERED ([CompanyProductTypeId] ASC)
);

