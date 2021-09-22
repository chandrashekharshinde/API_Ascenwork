Create PROCEDURE [dbo].[SSP_GetAllDriverAndPlateNumberMappingList] --'<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @CarrierId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


	
	  


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array],[PlateNumberDriverMappingId]
      ,[PlateNumber]
      ,[DriverId]
      ,[Active]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
  FROM [PlateNumberDriverMapping] where Active = 1 
	FOR XML path('PlateNumberDriverMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END
