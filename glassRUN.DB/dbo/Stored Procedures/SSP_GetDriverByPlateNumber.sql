CREATE PROCEDURE [dbo].[SSP_GetDriverByPlateNumber] --'<Json><ServicesAction>LoadDriverByCarrier</ServicesAction><CarrierId>664</CarrierId></Json>'
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @plateNumber nvarchar(150)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @plateNumber = tmp.[PlateNumber]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PlateNumber] nvarchar(150)
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array], [PlateNumberDriverMappingId]
      ,[PlateNumber]
      ,[DriverId] as DeliveryPersonnelId
	  ,(Select top 1 Name from Login where LoginId=PlateNumberDriverMapping.[DriverId]) as DriverName
      ,[Active]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
			
  FROM  PlateNumberDriverMapping  
  where PlateNumber=@plateNumber and Active=1
	FOR XML path('PlateNumberDriverMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END


