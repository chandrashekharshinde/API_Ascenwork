CREATE TABLE [dbo].[OrderProductMovementAttribute] (
    [OrderProductMovementAttributeId]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrderProductMovementId]                       BIGINT         NULL,
    [OrderCompartmentId]                           BIGINT         NULL,
    [OrderID]                                      BIGINT         NULL,
    [OrderProductID]                               BIGINT         NULL,
    [OrderProductMovementAttributeConfigurationId] BIGINT         NULL,
    [CompartmentName]                              NVARCHAR (150) NULL,
    [AttributeName]                                NVARCHAR (100) NULL,
    [AttributeValue]                               NVARCHAR (500) NULL,
    [SequenceNumber]                               INT            NULL,
    [IsActive]                                     BIT            NULL,
    [CreatedDate]                                  DATETIME       CONSTRAINT [DF_OrderProductMovementAttribute_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                                    NVARCHAR (50)  NOT NULL,
    [UpdatedDate]                                  DATETIME       NULL,
    [UpdatedBy]                                    NVARCHAR (50)  NULL,
    CONSTRAINT [PK_OrderProductMovementAttribute] PRIMARY KEY CLUSTERED ([OrderProductMovementAttributeId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_OrderProductMovementAttribute_OrderProductMovement] FOREIGN KEY ([OrderProductMovementId]) REFERENCES [dbo].[OrderProductMovement] ([OrderProductMovementId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Order ID - Redundancy  Added to avoid joins', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrderProductMovementAttribute', @level2type = N'COLUMN', @level2name = N'OrderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This indicates which caegories are allowed for this client login.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrderProductMovementAttribute', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date and time this record was created.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrderProductMovementAttribute', @level2type = N'COLUMN', @level2name = N'CreatedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the user that created this record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrderProductMovementAttribute', @level2type = N'COLUMN', @level2name = N'CreatedBy';

