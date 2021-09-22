CREATE PROCEDURE [dbo].[SSP_AllUnitOfMeasureList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

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
SELECT CAST((SELECT  'true' AS [@json:Array] ,[LookUpId]
      ,[LookupCategory]
      ,[Name]
      ,[Code]
      ,[Description]
      ,[ShortCode]
      ,[SortOrder]
      ,[ResourceKey]
      ,[Criteria]
      ,[Remarks]
	  from [LookUp] where LookupCategory=6
	FOR XML path('UnitOfMeasureList'),ELEMENTS,ROOT('Json')) AS XML)
END
