CREATE TABLE [dbo].[ConfirmationConfiguration] (
    [ConfirmationConfigurationId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ConfirmationStepId]          BIGINT        NULL,
    [ConfirmationBy]              NVARCHAR (50) NULL,
    [Sequence]                    BIGINT        NULL,
    [ControlType]                 BIGINT        NULL,
    [IsDependent]                 BIT           NULL,
    [IsDependentOn]               BIGINT        NULL,
    [IsMandatory]                 BIT           NULL,
    [IsActive]                    BIT           NOT NULL,
    [CreatedBy]                   BIGINT        NOT NULL,
    [CreatedDate]                 DATETIME      NOT NULL,
    [ModifiedBy]                  BIGINT        NULL,
    [ModifiedDate]                DATETIME      NULL,
    CONSTRAINT [PK_ConfirmationConfiguration] PRIMARY KEY CLUSTERED ([ConfirmationConfigurationId] ASC)
);

