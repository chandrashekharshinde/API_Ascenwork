CREATE PROCEDURE [dbo].[SSP_GetAllCustomerFromHierarchy] --'<Json><ServicesAction>GetCustomerDetailsBySupplier</ServicesAction><ParentCompanyId>66</ParentCompanyId><searchValue>s18</searchValue></Json>'@xmlDoc XMLASBEGINDECLARE @intPointer INT;declare @ParentCompanyId BIGINTdeclare @roleId BIGINTdeclare @CultureId bigintdeclare @searchValue nvarchar(500)EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @ParentCompanyId = tmp.[ParentCompanyId],       @roleId = tmp.[RoleId],       @CultureId = tmp.[CultureId],	   @searchValue =tmp.searchValue FROM OPENXML(@intpointer,'Json',2)   WITH   (    [ParentCompanyId] bigint,    [RoleId] bigint,    [CultureId] bigint,	searchValue nvarchar(500)   )tmp;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)   Select Cast((Select  'true' AS [@json:Array]  ,   [HierarchyId],COUNT(*) OVER () as TotalCount
      ,[HierarchyType]
      ,[CompanyId]
      ,[CompanyCode]
	  ,(Select top 1 CompanyName from Company where CompanyId=[Hierarchy].[CompanyId]) as CompanyName
	  ,(Select top 1 AddressLine1 from Company where CompanyId=[Hierarchy].[CompanyId]) as AddressLine1
	  ,(Select top 1 AddressLine2 from Company where CompanyId=[Hierarchy].[CompanyId]) as AddressLine2
	  ,isNull((Select top 1 Field4 from Company where CompanyId=[Hierarchy].[CompanyId]),'NC') ContractOrNonContract
	  ,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=[Hierarchy].[CompanyId] and p.IsActive=1 and p.ParentCompanyId=@ParentCompanyId),0) as PriorityRating
	  ,(select top 1 [Name] from LookUp where LookUpId= (Select top 1 Field3 from Company c where CompanyId=[Hierarchy].[CompanyId] and c.IsActive=1))AS CustomerGroupName
      ,[IsActive]
      ,[IsDefault]
	  ,1 as IsSelectedCustomerGroup from [Hierarchy] where [ParentCompanyId]=@ParentCompanyId	  --and ((Select top 1 CompanyName from Company where CompanyId=[Hierarchy].[CompanyId])  like '%'+@searchValue+'%' or @searchValue='') FOR XML path('CustomerList'),ELEMENTS,ROOT('Json')) AS XML)   END