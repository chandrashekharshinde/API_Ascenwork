CREATE TABLE [dbo].[State] (
    [StateId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [StateName]   NVARCHAR (50)  NULL,
    [StateCode]   NVARCHAR (50)  NULL,
    [GstNo]       NVARCHAR (250) NULL,
    [IsActive]    BIT            NULL,
    [CreatedBy]   BIGINT         NOT NULL,
    [CreatedDate] DATETIME       NOT NULL,
    [UpdatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED ([StateId] ASC)
);

