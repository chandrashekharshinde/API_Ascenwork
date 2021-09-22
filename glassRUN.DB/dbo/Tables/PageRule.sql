CREATE TABLE [dbo].[PageRule] (
    [PageRuleId] BIGINT NOT NULL,
    [RuleType]   BIGINT NULL,
    [PageId]     BIGINT NULL,
    CONSTRAINT [PK_PageRule] PRIMARY KEY CLUSTERED ([PageRuleId] ASC)
);

