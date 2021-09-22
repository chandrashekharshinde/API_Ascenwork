CREATE PROCEDURE [dbo].[SSP_AllState] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
			
SELECT CAST((SELECT  'true' AS [@json:Array],
	StateId,
	StateName,
	StateCode,
	IsActive,
	CreatedBy,
	CreatedDate,
	UpdatedBy,
	UpdatedDate
   FROM [State] WHERE IsActive = 1  order by StateName Asc
	FOR XML path('StateList'),ELEMENTS,ROOT('Json')) AS XML)
END