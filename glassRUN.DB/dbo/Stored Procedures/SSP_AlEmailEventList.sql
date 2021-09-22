Create PROCEDURE [dbo].[SSP_AlEmailEventList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>592</CompanyId></Json>'

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
SELECT CAST((SELECT  'true' AS [@json:Array] , [EmailEventId]
      ,[SupplierId]
      ,[EventName]
      ,[EventCode]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
  FROM [EmailEvent] WHERE IsActive = 1
	FOR XML path('EmailEventList'),ELEMENTS,ROOT('Json')) AS XML)
END
