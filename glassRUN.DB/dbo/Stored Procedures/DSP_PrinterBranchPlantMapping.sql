Create PROCEDURE [dbo].[DSP_PrinterBranchPlantMapping] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @printerBranchPlantMappingId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @printerBranchPlantMappingId = tmp.PrinterBranchPlantMappingId
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			PrinterBranchPlantMappingId bigint
           
			)tmp ;


			
Update PrinterBranchPlantMapping SET IsActive=0 where PrinterBranchPlantMappingId=@printerBranchPlantMappingId
 SELECT @printerBranchPlantMappingId as PrinterBranchPlantMapping FOR XML RAW('Json'),ELEMENTS
END
