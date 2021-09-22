CREATE PROCEDURE [dbo].[SSP_LoadPrinterBranchPlant_ByBranchPlantCode] --'<Json><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @BranchPlantCode bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @BranchPlantCode = tmp.[BranchPlantCode]
 
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [BranchPlantCode] bigint
   )tmp;

   WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array] ,
 [PrinterBranchPlantMappingId]
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
FROM [PrinterBranchPlantMapping]  WHERE  BranchPlantCode = @BranchPlantCode
 FOR XML path('PrinterBranchPlantList'),ELEMENTS,ROOT('PrinterBranchPlant')) AS XML)
END
