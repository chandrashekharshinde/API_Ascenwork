CREATE PROCEDURE [dbo].[SSP_GetPrinterBranchPlantDetailsByPrinterBranchPlantId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @printerBranchPlantMappingId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @printerBranchPlantMappingId = tmp.[PrinterBranchPlantMappingId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PrinterBranchPlantMappingId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[PrinterBranchPlantMappingId]
,(Select DeliveryLocationId from DeliveryLocation where DeliveryLocationCode=PrinterBranchPlantMapping.[BranchPlantCode]) as DeliveryLocationId
      ,[BranchPlantCode]
      ,[DocumentType]
      ,[PrinterName]
      ,[PrinterPath]
      ,[NumberOfCopies]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	   FROM PrinterBranchPlantMapping  
	  WHERE IsActive = 1 and [PrinterBranchPlantMappingId]=@printerBranchPlantMappingId
	FOR XML path('PrinterBranchPlantMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END
