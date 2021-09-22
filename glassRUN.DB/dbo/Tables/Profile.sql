CREATE TABLE [dbo].[Profile] (
    [ProfileId]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]                 NVARCHAR (50)  NULL,
    [EmailId]              NVARCHAR (100) NULL,
    [ContactNumber]        NVARCHAR (50)  NULL,
    [UserProfilePicture]   NVARCHAR (MAX) NULL,
    [ParentUser]           BIGINT         NULL,
    [ReferenceId]          BIGINT         NULL,
    [ReferenceType]        BIGINT         NULL,
    [IsActive]             BIT            NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [CreatedBy]            BIGINT         NOT NULL,
    [CreatedFromIPAddress] NVARCHAR (20)  NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    [UpdatedFromIPAddress] NVARCHAR (20)  NULL,
    [LicenseNumber]        NVARCHAR (50)  NULL,
    [DriverId]             NVARCHAR (50)  NULL,
    CONSTRAINT [PK_UserDetail_1] PRIMARY KEY CLUSTERED ([ProfileId] ASC) WITH (FILLFACTOR = 80)
);

