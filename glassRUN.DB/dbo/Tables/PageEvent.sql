CREATE TABLE [dbo].[PageEvent] (
    [PageEventId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [PageId]       BIGINT         NULL,
    [EventName]    NVARCHAR (150) NULL,
    [IsActive]     BIT            NOT NULL,
    [CreatedBy]    BIGINT         NOT NULL,
    [CreatedDate]  DATETIME       NOT NULL,
    [ModifiedBy]   BIGINT         NULL,
    [ModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_PageEvent] PRIMARY KEY CLUSTERED ([PageEventId] ASC)
);

