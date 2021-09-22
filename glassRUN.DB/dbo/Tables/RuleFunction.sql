CREATE TABLE [dbo].[RuleFunction] (
    [RuleFunctionId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [FunctionText]   NVARCHAR (150) NULL,
    [FunctionType]   NVARCHAR (50)  NULL,
    [IsActive]       BIT            NOT NULL,
    [CreatedBy]      BIGINT         NOT NULL,
    [CreatedDate]    DATETIME       NOT NULL,
    [UpdatedBy]      BIGINT         NULL,
    [UpdatedDate]    DATETIME       NULL,
    [IPAddress]      NVARCHAR (20)  NULL,
    [Field1]         NVARCHAR (500) NULL,
    [Field2]         NVARCHAR (500) NULL,
    [Field3]         NVARCHAR (500) NULL,
    [Field4]         NVARCHAR (500) NULL,
    [Field5]         NVARCHAR (500) NULL,
    [Field6]         NVARCHAR (500) NULL,
    [Field7]         NVARCHAR (500) NULL,
    [Field8]         NVARCHAR (500) NULL,
    [Field9]         NVARCHAR (500) NULL,
    [Field10]        NVARCHAR (500) NULL,
    CONSTRAINT [PK_RuleFunction] PRIMARY KEY CLUSTERED ([RuleFunctionId] ASC) WITH (FILLFACTOR = 80)
);

