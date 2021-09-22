
CREATE PROCEDURE [dbo].[SSP_ObjectPropertiesByEventMasterId] -- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

@xmlDoc XML
AS
BEGIN

DECLARE @intPointer INT;
Declare @EventMasterId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @EventMasterId = tmp.[EventMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventMasterId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
		--Eopm.[EventObjectPropertiesMappingId],
		--STUFF( (SELECT ',' +  PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in (select  distinct ID from fnSplitValues(eopm.ObjectPropertyIds))     FOR XML PATH (''))  , 1, 1, '') PropertyName,
		--Eopm.[IsActive],
		--Eopm.[CreatedBy],
		--Eopm.[CreatedDate],	
		--Eopm.[UpdatedBy],
		--Eopm.[UpdatedDate]
		--from EventObjectPropertiesMapping Eopm
		  op.PropertyName
		 from ObjectProperties op 
		inner join EventObjectPropertiesMapping Eopm on  op.ObjectPropertiesId in( select   ID from fnSplitValues(eopm.ObjectPropertyIds))
		and Eopm.isactive = 1 and Eopm.EventMasterId=@EventMasterId  group by op.PropertyName
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END