CREATE TABLE [dbo].[CustomerPriority] (
    [CustomerPriorityID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentCompanyId]    BIGINT         NOT NULL,
    [ParentCompanyCode]  NVARCHAR (100) NULL,
    [CompanyId]          BIGINT         NULL,
    [CompanyCode]        NVARCHAR (100) NULL,
    [LocationId]         BIGINT         NULL,
    [LocationCode]       NVARCHAR (200) NULL,
    [PriorityRating]     INT            NULL,
    [CreatedBy]          BIGINT         NOT NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_CustomerPriority_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]         BIGINT         NULL,
    [ModifiedDate]       DATETIME       NULL,
    [IsActive]           BIT            CONSTRAINT [DF_CustomerPriority_IsActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_CustomerPriority] PRIMARY KEY CLUSTERED ([CustomerPriorityID] ASC)
);




GO
CREATE NONCLUSTERED INDEX [idx_CustomerPriority_ParentCompanyId]
    ON [dbo].[CustomerPriority]([ParentCompanyId] ASC, [ParentCompanyCode] ASC, [CompanyId] ASC);

