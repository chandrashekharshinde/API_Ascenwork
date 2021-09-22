CREATE TABLE [dbo].[TransportVehicleAccountDetail] (
    [TransportVehicleAccountDetailId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TransportVehicleId]              BIGINT         NULL,
    [BankName]                        NVARCHAR (100) NULL,
    [AccountNumber]                   NVARCHAR (30)  NULL,
    [AccountTypeId]                   BIGINT         NULL,
    [AccountType]                     NVARCHAR (100) NULL,
    [IsActive]                        BIT            CONSTRAINT [DF_TransportVehicleAccountDetail_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedBy]                       BIGINT         NOT NULL,
    [CreatedDate]                     DATETIME       NOT NULL,
    [UpdatedBy]                       BIGINT         NULL,
    [UpdatedDate]                     DATETIME       NULL,
    CONSTRAINT [PK_TransportVehicleAccountDetail] PRIMARY KEY CLUSTERED ([TransportVehicleAccountDetailId] ASC)
);

