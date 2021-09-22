CREATE PROCEDURE [dbo].[SSP_AllPaymentTerm] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
			
SELECT CAST((SELECT  'true' AS [@json:Array],
		[PaymentTermId],
		[PaymentTermId] as Id,
		[PaymentTermName] As [Name],
		[PaymentTermCode],
		[IsActive],
		[CreatedBy],
		[CreatedDate],
		[UpadatedBy],
		[UpdatedDate]
   FROM [PaymentTerm] WHERE IsActive = 1 
	FOR XML path('PaymentTermList'),ELEMENTS,ROOT('Json')) AS XML)
END
