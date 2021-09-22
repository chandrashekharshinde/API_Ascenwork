CREATE TABLE [dbo].[EnquiryIdGenerated] (
    [EnquiryIdGeneratedId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Value]                NVARCHAR (50) NULL,
    CONSTRAINT [PK_EnquiryIdGenerated] PRIMARY KEY CLUSTERED ([EnquiryIdGeneratedId] ASC) WITH (FILLFACTOR = 80)
);

