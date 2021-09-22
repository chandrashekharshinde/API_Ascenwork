CREATE TABLE [dbo].[EventForm] (
    [EventFormId]                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [ProductTypeId]                  INT             NULL,
    [ModeOfDelivery]                 INT             NULL,
    [SupplierLOBID]                  BIGINT          NULL,
    [EventConfigurationID]           BIGINT          NULL,
    [ParentAttributeConfigurationId] INT             NULL,
    [AttributeName]                  NVARCHAR (100)  NULL,
    [ResourceKey]                    NVARCHAR (100)  NULL,
    [AttributeType]                  INT             NULL,
    [AttributeMinOccurence]          INT             NULL,
    [AttributeMaxOccurence]          INT             NULL,
    [ProcessName]                    NVARCHAR (50)   NULL,
    [ListValues]                     NVARCHAR (4000) NULL,
    [Version]                        NVARCHAR (50)   NULL,
    [IsActive]                       BIT             NULL,
    [CreatedDate]                    DATETIME        CONSTRAINT [DF_EventForm_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                      NVARCHAR (50)   NOT NULL,
    [UpdatedDate]                    DATETIME        NULL,
    [UpdatedBy]                      NVARCHAR (50)   NULL,
    CONSTRAINT [PK_EventForm] PRIMARY KEY CLUSTERED ([EventFormId] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Process in which these attributes will be captured', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventForm', @level2type = N'COLUMN', @level2name = N'ProcessName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'In case the field is of drop down. The comma seperated list will be stored in this field ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventForm', @level2type = N'COLUMN', @level2name = N'ListValues';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventForm', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventForm', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventForm', @level2type = N'COLUMN', @level2name = N'CreatedBy';

