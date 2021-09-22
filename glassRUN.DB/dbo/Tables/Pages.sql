﻿CREATE TABLE [dbo].[Pages] (
    [PageId]                 BIGINT         IDENTITY (1, 1) NOT NULL,
    [ModuleId]               BIGINT         NOT NULL,
    [PageName]               NVARCHAR (100) NULL,
    [ResourceKey]            NVARCHAR (50)  NULL,
    [ParentPageId]           BIGINT         NULL,
    [ControllerName]         NVARCHAR (100) NULL,
    [ActionName]             NVARCHAR (100) NULL,
    [IsReport]               BIT            NULL,
    [Description]            NVARCHAR (500) NULL,
    [PageIcon]               NVARCHAR (100) NULL,
    [SequenceNumber]         INT            NULL,
    [IsActive]               BIT            NOT NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedBy]              BIGINT         NULL,
    [UpdatedDate]            DATETIME       NULL,
    [IPAddress]              NVARCHAR (20)  NULL,
    [IsInnerPage]            BIT            NULL,
    [ConfigurationAvailable] INT            NULL,
    [PageType]               BIGINT         NULL,
    [IsCommingSoonIndicator] BIT            NULL,
    CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED ([PageId] ASC) WITH (FILLFACTOR = 80)
);

