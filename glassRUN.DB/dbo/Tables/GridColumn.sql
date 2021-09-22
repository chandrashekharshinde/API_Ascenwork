﻿CREATE TABLE [dbo].[GridColumn] (
    [GridColumnId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [ObjectId]               BIGINT         NULL,
    [PropertyName]           NVARCHAR (500) NULL,
    [PropertyType]           NVARCHAR (500) NULL,
    [IsControlField]         BIT            NULL,
    [ResourceKey]            NVARCHAR (500) NULL,
    [OnScreenDisplay]        BIT            NULL,
    [IsDetailsViewAvailable] BIT            NULL,
    [IsSystemMandatory]      BIT            NULL,
    [Data1]                  NVARCHAR (500) NULL,
    [Data2]                  NVARCHAR (500) NULL,
    [Data3]                  NVARCHAR (500) NULL,
    [Format]                 NVARCHAR (50)  NULL,
    [FilterOperations]       NVARCHAR (200) NULL,
    [Alignment]              NVARCHAR (200) NULL,
    [CssClass]               NVARCHAR (200) NULL,
    [CellTemplate]           NVARCHAR (200) NULL,
    [HeaderCellTemplate]     NVARCHAR (200) NULL,
    [IsReasonCode]           BIT            NULL,
    [IsEditable]             BIT            NULL,
    [DataBindingSource]      NVARCHAR (500) NULL,
    [DataUpdateSource]       NVARCHAR (500) NULL,
    [ReasonCodeCategory]     NVARCHAR (500) NULL,
    [ReasonCodeEventName]    NVARCHAR (500) NULL,
    [FunctionName]           NVARCHAR (500) NULL,
    [IsActive]               BIT            NOT NULL,
    [CreatedBy]              BIGINT         NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             BIGINT         NULL,
    [ModifiedDate]           DATETIME       NULL,
    CONSTRAINT [PK_GridColumn] PRIMARY KEY CLUSTERED ([GridColumnId] ASC) WITH (FILLFACTOR = 80)
);
