CREATE FULLTEXT INDEX ON [dbo].[Rules]
    ([RuleText] LANGUAGE 1033, [RuleName] LANGUAGE 1033)
    KEY INDEX [PK_Rules]
    ON [FullItemNameSearch];


GO
CREATE FULLTEXT INDEX ON [dbo].[NotificationRequest]
    ([Title] LANGUAGE 1033)
    KEY INDEX [PK_NotificationRequest]
    ON [FullItemNameSearch];


GO
CREATE FULLTEXT INDEX ON [dbo].[Item]
    ([ItemName] LANGUAGE 1033, [ItemNameEnglishLanguage] LANGUAGE 1033, [ItemCode] LANGUAGE 1033)
    KEY INDEX [PK_Item]
    ON [FullItemNameSearch];

