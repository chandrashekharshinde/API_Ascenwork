
create PROCEDURE [dbo].[DSP_EventMaster] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

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


			
Update EventMaster SET IsActive=0 where EventMasterId=@EventMasterId

 SELECT @EventMasterId as EventMasterId FOR XML RAW('Json'),ELEMENTS
END