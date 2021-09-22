CREATE TABLE [dbo].[Object] (
    [ObjectId]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectName]        NVARCHAR (250) NULL,
    [IsActive]          BIT            NOT NULL,
    [CreatedBy]         BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        BIGINT         NULL,
    [ModifiedDate]      DATETIME       NULL,
    [GridConfiguration] BIT            NULL,
    [DisplayName]       NVARCHAR (250) NULL,
    CONSTRAINT [PK_Object] PRIMARY KEY CLUSTERED ([ObjectId] ASC) WITH (FILLFACTOR = 80)
);

