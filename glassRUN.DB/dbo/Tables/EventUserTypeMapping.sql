CREATE TABLE [dbo].[EventUserTypeMapping] (
    [EventUserType]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventCode]              NVARCHAR (250) NOT NULL,
    [UserType]               NCHAR (200)    NOT NULL,
    [DescriptionResourceKey] NVARCHAR (500) NOT NULL,
    [DisplayIcon]            NVARCHAR (MAX) NULL,
    [SequenceNumber]         INT            NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       CONSTRAINT [DF_EventUserTypeMapping_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]             BIGINT         NULL,
    [ModifiedDate]           DATETIME       NULL,
    [IsActive]               BIT            CONSTRAINT [DF_EventUserTypeMapping_IsActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_EventUserTypeMapping] PRIMARY KEY CLUSTERED ([EventUserType] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'EventCode from event Master', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventUserTypeMapping', @level2type = N'COLUMN', @level2name = N'EventCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup category for companyType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventUserTypeMapping', @level2type = N'COLUMN', @level2name = N'UserType';

