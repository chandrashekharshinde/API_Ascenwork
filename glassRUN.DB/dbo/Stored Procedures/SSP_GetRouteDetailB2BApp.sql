
CREATE PROCEDURE [dbo].[SSP_GetRouteDetailB2BApp]

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @searchValue nvarchar(500)
declare @ProductType nvarchar(50)
declare @ItemSection nvarchar(200)
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@searchValue =tmp.searchValue,
@companyId = tmp.CompanyId,
@ProductType = tmp.ProductType,
@ItemSection=tmp.ItemSection

FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
	searchValue nvarchar(500),
	ItemSection nvarchar(200),
	CompanyId bigint,
	ProductType nvarchar(50)
	)tmp;


;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
	   [ActionRuleTypeMappingId]
      ,[ActionName]
      ,[RuleType]
      ,[IsActive]
  FROM [dbo].[ActionRuleTypeMapping] where [IsActive]=1
	  FOR XML PATH('ActionRuleTypeMappingList'),ELEMENTS,ROOT('ActionRuleTypeMapping')) AS XML)



END