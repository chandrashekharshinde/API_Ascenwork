
CREATE PROCEDURE [dbo].[DSP_EventObjectPropertiesMapping] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventMasterID bigint;
Declare @ObjectID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventMasterID = tmp.[EventMasterId],@ObjectID=tmp.[ObjectID]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventMasterId] bigint,
			[ObjectID] bigint
           
			)tmp ;

print @ObjectID
print @EventMasterID
			
Update EventObjectPropertiesMapping SET IsActive=0 where EventMasterId=@EventMasterID and ObjectId=@ObjectID

 SELECT @EventMasterID as EventMasterId FOR XML RAW('Json'),ELEMENTS
END