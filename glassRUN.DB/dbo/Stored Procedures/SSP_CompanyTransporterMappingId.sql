Create PROCEDURE [dbo].[SSP_CompanyTransporterMappingId]
(
@xmlDoc XML
)
AS

BEGINDECLARE @intPointer INT;declare @CompanyTransporterMappingId bigint = 0EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @CompanyTransporterMappingId=tmp.[CompanyTransporterMappingId]		  FROM OPENXML(@intpointer,'Json',2)			WITH			(				[CompanyTransporterMappingId] bigint			)tmp;			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT  'true' AS [@json:Array],				[CompanyTransporterMappingId],
				[CompanyId],
				[TransporterId],	
				[IsActive],
								(select cast ((SELECT  'true' AS [@json:Array] ,				[CompanyTransporterMappingId],
				[CompanyId],
				[TransporterId] as Id,	
				[IsActive]
				from CompanyTransporterMapping op  where op.CompanyId = ctm.CompanyId and op.isactive=1				FOR XML path('TransporterList'),ELEMENTS) AS xml))FROM CompanyTransporterMapping ctm	 where ctm.IsActive = 1 and ctm.CompanyTransporterMappingId=@CompanyTransporterMappingIdFOR XML path('CompanyTransporterMappingList'),ELEMENTS,ROOT('Json')) AS XML)END
