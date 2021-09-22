CREATE TABLE [dbo].[GridConfiguration] (
    [GridConfigurationId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [CompanyId]           BIGINT        NULL,
    [RoleMasterId]        BIGINT        NULL,
    [UserId]              BIGINT        NULL,
    [PageId]              BIGINT        NULL,
    [ColumnName]          NVARCHAR (50) NULL,
    [IsDefault]           BIT           NULL,
    [IsRequired]          BIT           NULL,
    [IsActive]            BIT           NOT NULL,
    [CreatedBy]           BIGINT        NOT NULL,
    [CreatedDate]         DATETIME      NOT NULL,
    [ModifiedBy]          BIGINT        NULL,
    [ModifiedDate]        DATETIME      NULL,
    CONSTRAINT [PK_GridConfiguration] PRIMARY KEY CLUSTERED ([GridConfigurationId] ASC) WITH (FILLFACTOR = 80)
);

