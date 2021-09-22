CREATE TABLE [dbo].[UserLatLong] (
    [UserLatLongId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [UserId]          BIGINT        NOT NULL,
    [Latitude]        NVARCHAR (20) NULL,
    [Longitude]       NVARCHAR (20) NULL,
    [DeviceToken]     NVARCHAR (50) NULL,
    [DeviceTime]      DATETIME      NULL,
    [BatteryStatus]   VARCHAR (50)  NULL,
    [ReferenceNumber] VARCHAR (20)  NULL,
    [Field1]          VARCHAR (50)  NULL,
    [Field2]          VARCHAR (50)  NULL,
    [CreatedBy]       BIGINT        NOT NULL,
    [CreatedDate]     DATETIME      NOT NULL,
    CONSTRAINT [PK_UserLatLong] PRIMARY KEY CLUSTERED ([UserLatLongId] ASC)
);

