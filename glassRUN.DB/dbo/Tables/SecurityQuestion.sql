CREATE TABLE [dbo].[SecurityQuestion] (
    [SecurityQuestionId]                 BIGINT         IDENTITY (1, 1) NOT NULL,
    [Question]                           NVARCHAR (250) NULL,
    [IsUpperCaseAllowed]                 BIT            NULL,
    [IsLowerCaseAllowed]                 BIT            NULL,
    [IsNumberAllowed]                    BIT            NULL,
    [IsSpecialCharacterAllowed]          BIT            NULL,
    [SpecialCharactersToBeExcluded]      NVARCHAR (50)  NULL,
    [MinimumUppercaseCharactersRequired] INT            NULL,
    [MinimumLowercaseCharactersRequired] INT            NULL,
    [MinimumSpecialCharactersRequired]   INT            NULL,
    [MinimumNumericsRequired]            INT            NULL,
    [IsActive]                           BIT            NOT NULL,
    [CreatedDate]                        DATETIME       NOT NULL,
    [CreatedBy]                          BIGINT         NOT NULL,
    [CreatedFromIPAddress]               NVARCHAR (20)  NULL,
    [UpdatedDate]                        DATETIME       NULL,
    [UpdatedBy]                          BIGINT         NULL,
    [UpdatedFromIPAddress]               NVARCHAR (20)  NULL,
    CONSTRAINT [PK_SecurityQuestion] PRIMARY KEY CLUSTERED ([SecurityQuestionId] ASC) WITH (FILLFACTOR = 80)
);

