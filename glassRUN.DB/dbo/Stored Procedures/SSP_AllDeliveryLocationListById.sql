Create PROCEDURE [dbo].[SSP_AllDeliveryLocationListById] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @deliveryLocationId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @deliveryLocationId = tmp.[DeliveryLocationId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[DeliveryLocationId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , [DeliveryLocationId]
      ,[DeliveryLocationName] +ISNULL(' ('+[DeliveryLocationCode]+')','') as [DeliveryLocationName]
      ,[DeliveryLocationCode]
      ,[CompanyID]
	  ,[Area]
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
  FROM [DeliveryLocation] WHERE IsActive = 1 and [DeliveryLocationId]=@deliveryLocationId
	FOR XML path('DeliveryLocationList'),ELEMENTS,ROOT('DeliveryLocation')) AS XML)
END
