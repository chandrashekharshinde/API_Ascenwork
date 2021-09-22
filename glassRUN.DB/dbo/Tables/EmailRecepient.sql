CREATE TABLE [dbo].[EmailRecepient] (
    [EmailRecepientId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [RecipientType]        NVARCHAR (500) NULL,
    [EmailEventId]         BIGINT         NULL,
    [EmailContentId]       BIGINT         NOT NULL,
    [EmailAddress]         NVARCHAR (500) NULL,
    [ToCC]                 NVARCHAR (10)  NULL,
    [RoleId]               BIGINT         NULL,
    [UserName]             NVARCHAR (250) NULL,
    [EmailDynamicTableId]  BIGINT         NULL,
    [EmailDynamicColumnId] BIGINT         NULL,
    [IsSendMailToAll]      BIT            NULL,
    [IsActive]             BIT            NULL,
    CONSTRAINT [PK_EmailRecepient] PRIMARY KEY CLUSTERED ([EmailRecepientId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If ''T'' then add to TO list if ''C'' add to CC list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EmailRecepient', @level2type = N'COLUMN', @level2name = N'ToCC';

