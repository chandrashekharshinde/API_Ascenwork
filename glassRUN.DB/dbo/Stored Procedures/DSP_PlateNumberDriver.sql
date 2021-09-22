
Create PROCEDURE [dbo].[DSP_PlateNumberDriver] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @PlateNumberDriverMappingId bigint;
--Declare @EventMasterID12 bigint;
--Declare @NotificationTypeMasterID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @PlateNumberDriverMappingId = tmp.[PlateNumberDriverMappingId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PlateNumberDriverMappingId] bigint
           
			)tmp ;


			
Update PlateNumberDriverMapping SET Active=0, UpdatedDate=GETDATE() where PlateNumberDriverMappingId=@PlateNumberDriverMappingId

 SELECT @PlateNumberDriverMappingId as PlateNumberDriverMappingId FOR XML RAW('Json'),ELEMENTS
END
