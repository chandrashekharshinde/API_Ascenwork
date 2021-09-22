CREATE TABLE [dbo].[PlateNumberDriverMapping] (
    [PlateNumberDriverMappingId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PlateNumber]                NVARCHAR (50) NULL,
    [DriverId]                   BIGINT        NULL,
    [Active]                     BIT           NOT NULL,
    [CreatedBy]                  BIGINT        NOT NULL,
    [CreatedDate]                DATETIME      NOT NULL,
    [UpdatedBy]                  BIGINT        NULL,
    [UpdatedDate]                DATETIME      NULL,
    CONSTRAINT [PK_PlateNumberDriverMapping] PRIMARY KEY CLUSTERED ([PlateNumberDriverMappingId] ASC)
);

