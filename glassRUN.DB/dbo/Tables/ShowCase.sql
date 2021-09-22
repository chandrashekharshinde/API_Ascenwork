CREATE TABLE [dbo].[ShowCase] (
    [ShowCaseId]                BIGINT         IDENTITY (1, 1) NOT NULL,
    [SystemPromotionIdentifier] BIGINT         NULL,
    [CultureId]                 BIGINT         NULL,
    [Type]                      BIGINT         NULL,
    [CompanyId]                 BIGINT         NULL,
    [CompanyType]               BIGINT         NULL,
    [CompanyCode]               NVARCHAR (200) NULL,
    [ProductCode]               NVARCHAR (250) NULL,
    [ProductName]               NVARCHAR (500) NULL,
    [FromDate]                  DATETIME       NULL,
    [ToDate]                    DATETIME       NULL,
    [SmallImage]                NVARCHAR (MAX) NULL,
    [BigImage]                  NVARCHAR (MAX) NULL,
    [Description]               NVARCHAR (MAX) NULL,
    [Title]                     NVARCHAR (500) NULL,
    [IsActive]                  BIT            NOT NULL,
    [CreatedBy]                 BIGINT         NOT NULL,
    [CreatedDate]               DATETIME       NOT NULL,
    [UpdatedBy]                 BIGINT         NULL,
    [UpdatedDate]               DATETIME       NULL,
    CONSTRAINT [PK_ShowCase] PRIMARY KEY CLUSTERED ([ShowCaseId] ASC)
);

