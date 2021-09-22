CREATE TABLE [dbo].[Shifts] (
    [ShiftId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ShiftCode]   NVARCHAR (50)  NULL,
    [ShiftName]   NVARCHAR (200) NOT NULL,
    [FromTime]    TIME (7)       NOT NULL,
    [ToTime]      TIME (7)       NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [CreatedBy]   BIGINT         NOT NULL,
    [CreatedDate] DATETIME       NOT NULL,
    [UpdatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    [IPAddress]   NVARCHAR (40)  NULL,
    CONSTRAINT [PK_ShiftMaster] PRIMARY KEY CLUSTERED ([ShiftId] ASC)
);

