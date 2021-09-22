CREATE TABLE [dbo].[TransporterAccountDetail] (
    [TransporterAccountDetailId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectId]                   BIGINT         NULL,
    [ObjectType]                 NVARCHAR (100) NULL,
    [AccountName]                NVARCHAR (50)  NULL,
    [BankName]                   NVARCHAR (100) NULL,
    [AccountNumber]              NVARCHAR (30)  NULL,
    [AccountTypeId]              BIGINT         NULL,
    [AccountType]                NVARCHAR (100) NULL,
    [IsActive]                   BIT            NOT NULL,
    [CreatedBy]                  BIGINT         NOT NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [UpdatedBy]                  BIGINT         NULL,
    [UpdatedDate]                DATETIME       NULL,
    CONSTRAINT [PK_TransporterAccountDetail] PRIMARY KEY CLUSTERED ([TransporterAccountDetailId] ASC)
);

