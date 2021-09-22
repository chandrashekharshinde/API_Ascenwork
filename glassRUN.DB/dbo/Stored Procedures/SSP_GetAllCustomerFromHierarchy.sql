﻿
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
	  ,1 as IsSelectedCustomerGroup from [Hierarchy] where [ParentCompanyId]=@ParentCompanyId