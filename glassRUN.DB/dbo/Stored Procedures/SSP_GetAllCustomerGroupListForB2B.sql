CREATE PROCEDURE [dbo].[SSP_GetAllCustomerGroupListForB2B] --'<Json><CompanyId>10001</CompanyId></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
DECLARE @intPointer INT;
-- ISSUE QUERY
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@companyId = tmp.CompanyId

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint
			)tmp;


;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
	  CustomerPriceGroup
	,GroupCode
	,CompanyId
	,CreatedBy
	,FORMAT(CreatedDate, 'dd-MMM-yyyy') As CreatedDate
	,IsActive
	,(select COUNT(*) from CustomerMasterForPricing where CustomerMasterForPricing.CustomerPriceGroup = CustomerGroupForPricing.CustomerPriceGroup) As NumberOfCustomers
	,(select cast ((select 'true' AS [@json:Array]
		,CompanyId
		,CustomerPriceGroup
		,CustomerNumber
		,(select CompanyName from Company where CompanyMnemonic = CustomerNumber) As CustomerName
		,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=(select top 1 Company.CompanyId from Company where CompanyMnemonic = CustomerNumber) and p.IsActive=1),0) as PriorityRating
	    ,(select top 1 [Name] from LookUp where LookUpId= (Select top 1 Field3 from Company c where c.CompanyMnemonic = CustomerNumber and c.IsActive=1))AS CustomerGroupName
		,GroupCode
		,CreatedBy
		,IsActive
		from CustomerMasterForPricing where CustomerMasterForPricing.CustomerPriceGroup = CustomerGroupForPricing.CustomerPriceGroup
		FOR XML path('ChildGroupList'),ELEMENTS)AS XML)) 
	from CustomerGroupForPricing
	where CompanyId = @companyId
	  FOR XML PATH('CustomerGroupList'),ELEMENTS,ROOT('Json')) AS XML)

END
