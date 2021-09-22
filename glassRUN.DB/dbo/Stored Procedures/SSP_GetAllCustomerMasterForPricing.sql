Create PROCEDURE [dbo].[SSP_GetAllCustomerMasterForPricing] --'<Json><ServicesAction>GetAllCustomerGroupListView</ServicesAction><CompanyId>10001</CompanyId><searchValue></searchValue></Json>'@xmlDoc XMLASBEGINDECLARE @intPointer INT;declare @companyId BIGINTdeclare @roleId BIGINTdeclare @customerPriceGroup nvarchar(250)declare @searchValue nvarchar(500)EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @companyId = tmp.[CompanyId],       @customerPriceGroup = tmp.[CustomerPriceGroup],       	   @searchValue =tmp.searchValue FROM OPENXML(@intpointer,'Json',2)   WITH   (    [CompanyId] bigint,    [CustomerPriceGroup] nvarchar(250),    	searchValue nvarchar(500)   )tmp;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)   Select Cast((Select  'true' AS [@json:Array]  ,COUNT(*) OVER () as TotalCount,
 (Select CompanyName from Company where CompanyMnemonic=CustomerMasterForPricing.[CustomerNumber]) as CompanyName,
      [CustomerNumber]
      ,[CustomerPriceGroup]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
      ,[CompanyId]	   from CustomerMasterForPricing where [CompanyId]=@companyId and [CustomerPriceGroup]=@customerPriceGroup	   FOR XML path('CustomerMasterForPricingList'),ELEMENTS,ROOT('Json')) AS XML)   END