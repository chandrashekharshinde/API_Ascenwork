CREATE TABLE [dbo].[AllowedPropertiesChangesByStatusMapping] (
    [AllowedPropertiesChangesByStatusMappingId] BIGINT IDENTITY (1, 1) NOT NULL,
    [StatusCode]                                BIGINT NULL,
    [GridColumnId]                              BIGINT NULL,
    [IsActive]                                  BIT    NOT NULL,
    CONSTRAINT [PK_AllowedPropertiesChangesByStatusMapping] PRIMARY KEY CLUSTERED ([AllowedPropertiesChangesByStatusMappingId] ASC)
);

