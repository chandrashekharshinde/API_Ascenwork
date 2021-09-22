CREATE PROCEDURE [dbo].[SSP_CustomerApp_GetAllCustomerList] @xmlDoc XMLASBEGINDECLARE @intPointer INT;-- ISSUE QUERYDECLARE @sql nvarchar(max)Declare @username nvarchar(max)EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocDeclare @companyId bigintSELECT 

@companyId = tmp.CompanyId

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint
			)tmp;;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  , CompanyId,CompanyMnemonic,CompanyName from Company where CompanyType = 24 and CompanyId in (select RelatedEntity from EntityRelationship where PrimaryEntity = @companyId and EntityRelationship.IsActive = 1)FOR XML PATH('OutletList'),ELEMENTS,ROOT('Json')) AS XML)END
