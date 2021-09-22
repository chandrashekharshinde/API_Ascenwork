CREATE TABLE [dbo].[ServiceConfiguration] (
    [ServiceConfigurationId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [ServicesAction]         NVARCHAR (500)  NOT NULL,
    [ServicesURL]            NVARCHAR (1000) NOT NULL,
    [IsActive]               BIT             CONSTRAINT [DF_ServiceConfiguration_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedDate]            DATETIME        CONSTRAINT [DF_ServiceConfiguration_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              BIGINT          NOT NULL,
    [CreatedFromIPAddress]   NVARCHAR (20)   NULL,
    [UpdatedDate]            DATETIME        NULL,
    [UpdatedBy]              BIGINT          NULL,
    [UpdatedFromIPAddress]   NVARCHAR (20)   NULL,
    [RequestFormat]          NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_ServiceConfiguration] PRIMARY KEY CLUSTERED ([ServiceConfigurationId] ASC) WITH (FILLFACTOR = 80)
);

