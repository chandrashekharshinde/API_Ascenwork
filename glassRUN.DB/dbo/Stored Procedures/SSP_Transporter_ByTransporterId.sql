CREATE PROCEDURE [dbo].[SSP_Transporter_ByTransporterId] --1
(
@xmlDoc XML='<Json><TransporterId>0</TransporterId></Json>'
)
AS
BEGIN

DECLARE @intPointer INT;
declare @transporterId BIGINT=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @transporterId = tmp.[TransporterId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TransporterId] bigint
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
	SELECT CAST((select  'true' AS [@json:Array] , c.CompanyName as [TransporterName]
	,c.CompanyId as [TransporterId]
	,c.CompanyMnemonic as [TransporterCode] 
	from Company c 
	where c.CompanyType=28 AND c.IsActive=1

		FOR XML path('TransporterList'),ELEMENTS,ROOT('Transporter')) AS XML)
END
