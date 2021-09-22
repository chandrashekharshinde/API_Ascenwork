CREATE TABLE [dbo].[CultureMaster] (
    [CultureMasterId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [CultureName]     NVARCHAR (250) NOT NULL,
    [CultureCode]     NVARCHAR (50)  NOT NULL,
    [Description]     NVARCHAR (500) NULL,
    [NumberFormat]    VARCHAR (20)   NULL,
    [DateFormat]      VARCHAR (20)   NULL,
    [Active]          BIT            NOT NULL,
    [CreatedBy]       BIGINT         NOT NULL,
    [CreatedDate]     DATETIME       NOT NULL,
    [UpdatedBy]       BIGINT         NULL,
    [UpdatedDate]     DATETIME       NULL,
    [CompanyId]       BIGINT         NULL,
    CONSTRAINT [PK_CultureMaster] PRIMARY KEY CLUSTERED ([CultureMasterId] ASC) WITH (FILLFACTOR = 80)
);

