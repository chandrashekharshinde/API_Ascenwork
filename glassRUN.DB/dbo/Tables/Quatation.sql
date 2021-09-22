CREATE TABLE [dbo].[Quatation] (
    [QuatationtId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [QuatationtAutoNumber] NVARCHAR (100) NOT NULL,
    [EnquiryId]            BIGINT         NOT NULL,
    [Remarks]              NVARCHAR (MAX) NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [ModifiedBy]           BIGINT         NULL,
    [ModifiedDate]         DATETIME       NULL,
    [IsActive]             BIT            NOT NULL,
    [SequenceNo]           BIGINT         NULL,
    [Field1]               NVARCHAR (500) NULL,
    [Field2]               NVARCHAR (500) NULL,
    [Field3]               NVARCHAR (500) NULL,
    [Field4]               NVARCHAR (500) NULL,
    [Field5]               NVARCHAR (500) NULL,
    [Field6]               NVARCHAR (500) NULL,
    [Field7]               NVARCHAR (500) NULL,
    [Field8]               NVARCHAR (500) NULL,
    [Field9]               NVARCHAR (500) NULL,
    [Field10]              NVARCHAR (500) NULL,
    CONSTRAINT [PK_Quatation] PRIMARY KEY CLUSTERED ([QuatationtId] ASC) WITH (FILLFACTOR = 80)
);

