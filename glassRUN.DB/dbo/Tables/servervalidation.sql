CREATE TABLE [dbo].[servervalidation] (
    [ServerValidateId]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ServicesAction]       NVARCHAR (500) NOT NULL,
    [Object]               NVARCHAR (500) NOT NULL,
    [PropertyName]         NVARCHAR (500) NOT NULL,
    [FiledDatatype]        VARCHAR (500)  NOT NULL,
    [ValidationExpression] NVARCHAR (500) NOT NULL,
    [IsActive]             BIT            NULL,
    [ResourceKey]          NCHAR (500)    NULL
);

