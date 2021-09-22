CREATE TABLE [dbo].[AddressBookMasterForPricing] (
    [CustomerNumber] NVARCHAR (250) NULL,
    [CustomerName]   VARCHAR (40)   NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20200112-111436]
    ON [dbo].[AddressBookMasterForPricing]([CustomerNumber] ASC);

