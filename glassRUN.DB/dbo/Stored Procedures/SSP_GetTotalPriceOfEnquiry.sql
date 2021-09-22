CREATE PROCEDURE [dbo].[SSP_GetTotalPriceOfEnquiry] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , SUM(ep.ProductQuantity * ep.UnitPrice) as TotalCreditPrice from Enquiry e join EnquiryProduct ep on e.EnquiryId=ep.EnquiryId
where e.EnquiryId not in (Select EnquiryId from [Order] where EnquiryId is not null) and e.IsActive=1 and CurrentState =1



	FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)
END
