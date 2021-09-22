﻿Create PROCEDURE [dbo].[SSP_GetCompanyAndTransporterList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select(CAST((
SELECT CAST((SELECT  'true' AS [@json:Array],
[CompanyName]+' ('+[CompanyMnemonic]+')' As [Name],
[IsActive]
from Company op  where op.CompanyType in(23,22)

(select cast ((SELECT  'true' AS [@json:Array],
[CompanyName]+' ('+[CompanyMnemonic]+')' As [Name],
[IsActive]
from Company op  where op.CompanyType in(28)
FOR XML RAW('TableList'),ELEMENTS,ROOT('Json')) AS xml))
END



