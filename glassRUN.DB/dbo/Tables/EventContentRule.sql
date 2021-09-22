CREATE TABLE [dbo].[EventContentRule] (
    [EventContentRuleId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [EventContentId]     BIGINT   NOT NULL,
    [RuleId]             BIGINT   NOT NULL,
    [IsActive]           BIT      NOT NULL,
    [CreatedBy]          BIGINT   NOT NULL,
    [CreatedDate]        DATETIME NOT NULL,
    [UpdatedBy]          BIGINT   NULL,
    [UpdatedDate]        DATETIME NULL,
    CONSTRAINT [PK_EventContentRule] PRIMARY KEY CLUSTERED ([EventContentRuleId] ASC)
);

