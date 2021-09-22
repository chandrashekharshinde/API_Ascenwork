CREATE PROCEDURE [dbo].[SSP_AllParentCompanyList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


--SELECT @companyId = tmp.[CompanyId]
	   
--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			[CompanyId] bigint
           
--			)tmp ;

			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select(CAST((
SELECT CAST((SELECT  'true' AS [@json:Array] ,[CompanyId]
,[CompanyName]
,[CompanyMnemonic]
,[CompanyType]
,[ParentCompany]
,[AddressLine1]
,[AddressLine2]
,[AddressLine3]
,[City]
,[State]
,[CountryId]
,[Postcode]
,[Region]
,[RouteCode]
,[ZoneCode]
,[CategoryCode]
,[BranchPlant]
,[Email]
,[TaxId]
,[SoldTo]
,[ShipTo]
,[BillTo]
,[SiteURL]
,[ContactPersonNumber]
,[ContactPersonName]
,[logo]
,[header]
,[footer]
,[CreatedBy]
,[CreatedDate]
,[ModifiedBy]
,[ModifiedDate]
,[IsActive]
,[SequenceNo]
,[Field1]
,[Field2]
,[Field3]
,[Field4]
,[Field5]
,[Field6]
,[Field7]
,[Field8]
,[Field9]
,[Field10]
,[CreditLimit]
,[AvailableCreditLimit]
,[EmptiesLimit]
,[ActualEmpties]
FROM Company WHERE IsActive = 1 and (ParentCompany IS NULL OR ParentCompany = 0)
FOR XML path('ParentCompanyList'),ELEMENTS,ROOT('ParentCompany')) AS XML),
(select cast ((SELECT  'true' AS [@json:Array],[CompanyId] as Id,
[CompanyName]As [Name],
[IsActive]
from Company op  where op.CompanyType in(23,22)FOR XML path('CompanyList'),ELEMENTS,ROOT('Company')) AS xml)),
(select cast ((SELECT  'true' AS [@json:Array],[CompanyId] as Id,
[CompanyName] As [Name],
[IsActive]
from Company op  where op.CompanyType in(28)FOR XML path('TransporterList'),ELEMENTS,ROOT('Transporter')) AS xml))
FOR XML RAW('TableList'),ELEMENTS,ROOT('Json')) AS xml))
END


