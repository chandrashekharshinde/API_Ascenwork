CREATE TABLE [dbo].[ContactInformation] (
    [ContactInformationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectId]             BIGINT         NULL,
    [ObjectType]           NVARCHAR (50)  NULL,
    [ContactType]          NVARCHAR (50)  NULL,
    [ContactPerson]        NVARCHAR (150) NULL,
    [Contacts]             NVARCHAR (MAX) NULL,
    [Purpose]              NVARCHAR (50)  NULL,
    [CreatedBy]            BIGINT         NULL,
    [CreatedDate]          DATETIME       NULL,
    [ModifiedBy]           BIGINT         NULL,
    [ModifiedDate]         DATETIME       NULL,
    [IsActive]             BIT            NULL,
    CONSTRAINT [PK_ContactInformation] PRIMARY KEY CLUSTERED ([ContactInformationId] ASC) WITH (FILLFACTOR = 80)
);

