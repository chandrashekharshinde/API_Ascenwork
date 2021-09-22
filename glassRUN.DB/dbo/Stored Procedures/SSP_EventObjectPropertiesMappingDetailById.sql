
CREATE PROCEDURE [dbo].[SSP_EventObjectPropertiesMappingDetailById]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

@xmlDoc XML
AS
BEGIN

DECLARE @intPointer INT;
Declare @EventObjectPropertiesMappingId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @EventObjectPropertiesMappingId = tmp.[EventObjectPropertiesMappingId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventObjectPropertiesMappingId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
[EventObjectPropertiesMappingId],
[EventMasterId],
[ObjectId],
[ObjectPropertyIds],
[IsActive],
[CreatedBy],
[CreatedDate],	
[UpdatedBy],
[UpdatedDate]
FROM EventObjectPropertiesMapping WHERE IsActive = 1 and EventObjectPropertiesMappingId=@EventObjectPropertiesMappingId
	FOR XML path('EventObjectPropertiesMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END