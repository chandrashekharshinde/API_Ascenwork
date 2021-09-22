CREATE TABLE [dbo].[EventConfiguration] (
    [EventConfigurationID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [SupplierLOBId]        BIGINT        NULL,
    [Process]              NVARCHAR (50) NOT NULL,
    [EventCode]            NVARCHAR (50) NOT NULL,
    [IsRequired]           BIT           CONSTRAINT [DF_EventConfiguration_IsRequired] DEFAULT ((1)) NULL,
    [SequenceNumber]       INT           NULL,
    [StockLocationID]      BIGINT        NULL,
    [TransportOperatorID]  BIGINT        NULL,
    [PlaceOfExecution]     INT           NULL,
    CONSTRAINT [PK_EventConfiguration] PRIMARY KEY CLUSTERED ([EventConfigurationID] ASC) WITH (FILLFACTOR = 80)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1 = Portal, 2=IPAD', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventConfiguration', @level2type = N'COLUMN', @level2name = N'PlaceOfExecution';

