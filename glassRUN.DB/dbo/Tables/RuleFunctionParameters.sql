CREATE TABLE [dbo].[RuleFunctionParameters] (
    [RuleFunctionParametersId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [RuleFunctionId]           BIGINT        NULL,
    [ParameterType]            NVARCHAR (50) NULL,
    [ParameterDataType]        NVARCHAR (50) NULL,
    [SequenceNumber]           BIGINT        NULL,
    [IsActive]                 BIT           NOT NULL,
    CONSTRAINT [PK_RuleFunctionParameters] PRIMARY KEY CLUSTERED ([RuleFunctionParametersId] ASC)
);

