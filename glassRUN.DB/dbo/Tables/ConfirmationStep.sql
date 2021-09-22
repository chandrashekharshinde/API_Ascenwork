CREATE TABLE [dbo].[ConfirmationStep] (
    [ConfirmationStepId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [StepName]             NVARCHAR (50) NULL,
    [NumberOfConfirmation] BIGINT        NULL,
    [IsActive]             BIT           NOT NULL,
    [CreatedBy]            BIGINT        NOT NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [ModifiedBy]           BIGINT        NULL,
    [ModifiedDate]         DATETIME      NULL,
    CONSTRAINT [PK_ConfirmationStep] PRIMARY KEY CLUSTERED ([ConfirmationStepId] ASC)
);

