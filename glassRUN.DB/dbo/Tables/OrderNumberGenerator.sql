CREATE TABLE [dbo].[OrderNumberGenerator] (
    [OrderNumberGeneratorId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Value]                  NVARCHAR (50) NULL,
    CONSTRAINT [PK_OrderNumberGenerator] PRIMARY KEY CLUSTERED ([OrderNumberGeneratorId] ASC) WITH (FILLFACTOR = 80)
);

