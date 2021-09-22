Create PROCEDURE [dbo].[SSP_DeliveryLocation_ByDeliveryLocationId] --1
@DeliveryLocationId BIGINT
AS
BEGIN

	SELECT [DeliveryLocationId]
      ,[DeliveryLocationName]
      ,[DeliveryLocationCode]
      ,[CompanyID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[City]
      ,[State]
      ,[Pincode]
      ,[Country]
      ,[Email]
      ,[Parentid]
      ,[Capacity]
      ,[Safefill]
      ,[ProductCode]
      ,[Description]
      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
	FROM [dbo].[DeliveryLocation]
	 WHERE (DeliveryLocationId=@DeliveryLocationId OR @DeliveryLocationId=0) AND IsActive=1
	FOR XML RAW('DeliveryLocation'),ELEMENTS
	
	
	
END
