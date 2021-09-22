CREATE TABLE [dbo].[Notes] (
    [NotesId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleId]       BIGINT         NULL,
    [ObjectId]     BIGINT         NULL,
    [ObjectType]   BIGINT         NULL,
    [Note]         NVARCHAR (MAX) NULL,
    [IsActive]     BIT            NULL,
    [CreatedBy]    BIGINT         NOT NULL,
    [CreatedDate]  DATETIME       NOT NULL,
    [ModifiedBy]   BIGINT         NULL,
    [ModifiedDate] DATETIME       NULL,
    [Field1]       NVARCHAR (500) NULL,
    [Field2]       NVARCHAR (500) NULL,
    [Field3]       NVARCHAR (500) NULL,
    [Field4]       NVARCHAR (500) NULL,
    [Field5]       NVARCHAR (500) NULL,
    CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED ([NotesId] ASC) WITH (FILLFACTOR = 80)
);

