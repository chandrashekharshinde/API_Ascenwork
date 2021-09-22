Create PROCEDURE [dbo].[SSP_AllShowCaseDetailsByCompanyId] --'<Json><ServicesAction>GetAllTruckSizeListByVehicleId</ServicesAction><VehicleTypeId>61</VehicleTypeId></Json>'@xmlDoc XMLASBEGINDECLARE @intPointer INT;declare @companyId bigint=0declare @ItemValue  nvarchar(250);EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @companyId = tmp.[CompanyId]	 FROM OPENXML(@intpointer,'Json',2)			WITH			(			[CompanyId] bigint           			)tmp ;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) SELECT CAST((SELECT 'true' AS [@json:Array] ,  [ShowCaseId]
      ,[Type]
      ,[CompanyId]
      ,[CompanyType]
      ,[CompanyCode]
      ,[ProductCode]
      ,[ProductName]
      ,[FromDate]
      ,[ToDate]
      ,[SmallImage]
      ,[BigImage]
      ,[Description]
      ,[Title]				   FROM ShowCase WHERE IsActive = 1 and CompanyId=@companyId	FOR XML path('ShowCaseList'),ELEMENTS,ROOT('Json')) AS XML)END