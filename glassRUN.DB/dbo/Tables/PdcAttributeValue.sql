CREATE TABLE [dbo].[PdcAttributeValue] (
    [PdcAttributeValueId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [PdcInformationId]          BIGINT         NULL,
    [PdcInformationGuid]        NVARCHAR (250) NULL,
    [QuestionVariableMappingId] BIGINT         NULL,
    [QuestionMasterId]          BIGINT         NULL,
    [Variable]                  NVARCHAR (250) NULL,
    [Value]                     NVARCHAR (250) NULL,
    [SectionId]                 BIGINT         NULL,
    CONSTRAINT [PK_PdcAttributeValue] PRIMARY KEY CLUSTERED ([PdcAttributeValueId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_PdcAttributeValue_PdcInformation] FOREIGN KEY ([PdcInformationId]) REFERENCES [dbo].[PdcInformation] ([PdcInformationId]),
    CONSTRAINT [FK_PdcAttributeValue_PdcInformation1] FOREIGN KEY ([PdcInformationId]) REFERENCES [dbo].[PdcInformation] ([PdcInformationId])
);

