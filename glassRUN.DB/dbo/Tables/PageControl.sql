CREATE TABLE [dbo].[PageControl] (
    [PageControlId]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageId]               BIGINT         NOT NULL,
    [ResourceKey]          NVARCHAR (MAX) NOT NULL,
    [ControlType]          INT            NULL,
    [ControlName]          NVARCHAR (MAX) NULL,
    [DataSource]           NVARCHAR (MAX) NULL,
    [DataType]             NVARCHAR (MAX) NULL,
    [DisplayName]          NVARCHAR (250) NULL,
    [IsActive]             BIT            NULL,
    [IsMandatory]          BIT            NULL,
    [ValidationExpression] NVARCHAR (500) NULL,
    CONSTRAINT [PK_PageControlMapping] PRIMARY KEY CLUSTERED ([PageControlId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ID_PageControl_PageId]
    ON [dbo].[PageControl]([PageId] ASC);

