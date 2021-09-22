CREATE TABLE [dbo].[EventRule] (
    [EventRuleId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [ProductTypeId]        INT             NULL,
    [ModeOfDelivery]       INT             NULL,
    [SupplierLOBID]        BIGINT          NULL,
    [EventConfigurationID] BIGINT          NULL,
    [RuleFormula]          NVARCHAR (1000) NULL,
    [RuleDescription]      NVARCHAR (1000) NULL,
    [RuleType]             BIGINT          NULL,
    [Version]              NVARCHAR (50)   NULL,
    [IsActive]             BIT             NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_EventRule_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            NVARCHAR (50)   NOT NULL,
    [UpdatedDate]          DATETIME        NULL,
    [UpdatedBy]            NVARCHAR (50)   NULL,
    CONSTRAINT [PK_EventRule] PRIMARY KEY CLUSTERED ([EventRuleId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Rule types are
IsMandatory Rules
Comparisn Validation
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventRule', @level2type = N'COLUMN', @level2name = N'RuleType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventRule', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventRule', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventRule', @level2type = N'COLUMN', @level2name = N'CreatedBy';

