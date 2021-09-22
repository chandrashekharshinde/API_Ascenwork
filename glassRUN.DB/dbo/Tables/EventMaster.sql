CREATE TABLE [dbo].[EventMaster] (
    [EventMasterId]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [EventCode]        NVARCHAR (250) NULL,
    [EventDescription] NVARCHAR (250) NULL,
    [IsActive]         BIT            NOT NULL,
    [CreatedBy]        BIGINT         NOT NULL,
    [CreatedDate]      DATETIME       NOT NULL,
    [UpdatedBy]        BIGINT         NULL,
    [UpdatedDate]      DATETIME       NULL,
    CONSTRAINT [PK_EventMaster] PRIMARY KEY CLUSTERED ([EventMasterId] ASC)
);

