CREATE TABLE [dbo].[PageRuleEvent] (
    [PageRuleEventId] BIGINT         NOT NULL,
    [PageId]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageName]        NVARCHAR (100) NULL,
    [PageEvent]       NVARCHAR (50)  NULL,
    [RuleType]        BIGINT         NULL,
    [IsActive]        BIT            NOT NULL,
    [CreatedBy]       BIGINT         NOT NULL,
    [CreatedDate]     DATETIME       NOT NULL,
    [ModifiedBy]      BIGINT         NULL,
    [ModifiedDate]    DATETIME       NULL,
    CONSTRAINT [PK_PageRuleEvent] PRIMARY KEY CLUSTERED ([PageRuleEventId] ASC)
);

