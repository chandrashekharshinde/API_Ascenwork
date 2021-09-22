CREATE TABLE [dbo].[Rules] (
    [RuleId]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [RuleType]           BIGINT         NULL,
    [RuleText]           NVARCHAR (MAX) NOT NULL,
    [RuleName]           NVARCHAR (MAX) NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [SequenceNumber]     BIGINT         NULL,
    [FromDate]           DATETIME       NULL,
    [ToDate]             DATETIME       NULL,
    [IsResponseRequired] BIT            NULL,
    [ResponseProperty]   NVARCHAR (MAX) NULL,
    [Enable]             BIT            NULL,
    [CreatedBy]          BIGINT         NOT NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [ModifiedBy]         BIGINT         NULL,
    [ModifiedDate]       DATETIME       NULL,
    [IsActive]           BIT            NOT NULL,
    [Field1]             NVARCHAR (500) NULL,
    [Field2]             NVARCHAR (500) NULL,
    [Field3]             NVARCHAR (500) NULL,
    [Field4]             NVARCHAR (500) NULL,
    [Field5]             NVARCHAR (500) NULL,
    CONSTRAINT [PK_Rules] PRIMARY KEY CLUSTERED ([RuleId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idx_Rules_RuleType]
    ON [dbo].[Rules]([RuleType] ASC, [IsActive] ASC)
    INCLUDE([RuleId], [RuleText], [RuleName], [Remarks], [SequenceNumber], [FromDate], [ToDate], [IsResponseRequired], [ResponseProperty], [Enable]);

