CREATE TABLE [dbo].[EventObjectPropertiesMapping] (
    [EventObjectPropertiesMappingId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventMasterId]                  BIGINT         NULL,
    [ObjectId]                       BIGINT         NULL,
    [ObjectPropertyIds]              NVARCHAR (MAX) NULL,
    [IsActive]                       BIGINT         NOT NULL,
    [CreatedBy]                      BIGINT         NOT NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedBy]                      BIGINT         NULL,
    [UpdatedDate]                    DATETIME       NULL,
    CONSTRAINT [PK_EventPropertiesMaping] PRIMARY KEY CLUSTERED ([EventObjectPropertiesMappingId] ASC)
);

