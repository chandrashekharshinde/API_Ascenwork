CREATE PROCEDURE [dbo].[SSP_GetTruckDetailsByTruckId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @truckSizeId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @truckSizeId = tmp.[TruckSizeId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TruckSizeId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[TruckSizeId]
,(Select Name from LookUp where LookUpId=[TruckSize].VehicleType) as TruckType
,isnull((Select LookUpId from LookUp where LookUpId=[TruckSize].VehicleType),'0') as VehicleTypeId
				  ,[TruckSize]
				  ,[TruckCapacityPalettes]
				  ,[TruckCapacityWeight]
				  ,[IsActive]
				  ,[Height]
				  ,[Width] 
				  ,[Length]
				   FROM [TruckSize]  
	  WHERE [TruckSizeId]=@truckSizeId
	FOR XML path('TruckList'),ELEMENTS,ROOT('Json')) AS XML)
END
