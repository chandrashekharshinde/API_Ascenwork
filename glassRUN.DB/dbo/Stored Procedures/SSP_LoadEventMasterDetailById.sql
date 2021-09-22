
create PROCEDURE [dbo].[SSP_LoadEventMasterDetailById]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

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
	[EventMasterId],
	[EventCode],
	[EventDescription],
	[IsActive],
	[CreatedBy],
	[CreatedDate],	
	[UpdatedBy],
	[UpdatedDate]

  FROM EventMaster WHERE IsActive = 1 and EventMasterId=@EventMasterId
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END