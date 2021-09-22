CREATE PROCEDURE [dbo].[SSP_GetWaveDetailsByWaveId] --'<Json><ServicesAction>GetWaveDetailsById</ServicesAction><WaveDefinitionId>1</WaveDefinitionId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @waveDefinitionId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @waveDefinitionId = tmp.[WaveDefinitionId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[WaveDefinitionId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[WaveDefinitionId]
      ,convert(nvarchar,CAST(WaveDateTime as time),100) as WaveDateTime
      ,[RuleText]
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
	   ,(select cast ((SELECT   'true' AS [@json:Array], [WaveDefinitionDetailsId]
      ,[WaveDefinitionId]
      ,[TruckSizeId]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
	  ,(select TruckSize from TruckSize where TruckSizeId=wdd.TruckSizeId) as TruckSize
	  from [WaveDefinitionDetails] wdd		
   WHERE wdd.IsActive = 1 AND wdd.WaveDefinitionId = [WaveDefinition].WaveDefinitionId  FOR XML path('WaveDefinitionDetailList'),ELEMENTS) AS xml))
				   FROM [WaveDefinition]  
	  WHERE IsActive = 1 and [WaveDefinitionId]=@waveDefinitionId
	FOR XML path('WaveDefinitionList'),ELEMENTS,ROOT('Json')) AS XML)
END
