CREATE TABLE [dbo].[NotesRoleWiseConfiguration] (
    [NotesRoleWiseConfigurationId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectType]                   BIGINT         NULL,
    [RoleId]                       BIGINT         NULL,
    [ViewNotesByRoleId]            BIGINT         NULL,
    [IsActive]                     BIT            NULL,
    [CreatedBy]                    BIGINT         NOT NULL,
    [CreatedDate]                  DATETIME       NOT NULL,
    [ModifiedBy]                   BIGINT         NULL,
    [ModifiedDate]                 DATETIME       NULL,
    [Field1]                       NVARCHAR (500) NULL,
    [Field2]                       NVARCHAR (500) NULL,
    [Field3]                       NVARCHAR (500) NULL,
    [Field4]                       NVARCHAR (500) NULL,
    [Field5]                       NVARCHAR (500) NULL,
    CONSTRAINT [PK_NotesRoleWiseConfiguration] PRIMARY KEY CLUSTERED ([NotesRoleWiseConfigurationId] ASC) WITH (FILLFACTOR = 80)
);

