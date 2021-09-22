Create PROCEDURE [dbo].[DSP_WaveDefinition] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @definitionId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @definitionId = tmp.[WaveDefinitionId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[WaveDefinitionId] bigint
           
			)tmp ;


			
Update WaveDefinition SET IsActive=0 where WaveDefinitionId=@definitionId

Update WaveDefinitionDetails SET IsActive=0 where WaveDefinitionId=@definitionId
 SELECT @definitionId as WaveDefinition FOR XML RAW('Json'),ELEMENTS
END
