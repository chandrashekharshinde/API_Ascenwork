CREATE PROCEDURE [dbo].[SSP_LoadOrderCarrierNumber] --'<Json><ServicesAction>GetAllTransporterListByCompanyId</ServicesAction><CompanyId>1483</CompanyId></Json>'
(
@xmlDoc XML
)
AS
BEGIN

DECLARE @intPointer INT;
declare @CompanyId BIGINT
declare @LoginId BIGINT
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
			)tmp 

Declare @whereClause nvarchar(max)
SET @whereClause = @whereClause + ''+ (SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@LoginId,'SalesAdminApproval','Enquiry')) +''
Print @whereClause
			
;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
	SELECT CAST((Select distinct * from (select  'true' AS [@json:Array] , c.CompanyName as [Name],c.CompanyId as [Id],c.CompanyMnemonic as [Code]  
	from Company c join Route r on c.CompanyId=r.CarrierNumber where r.CompanyId=@CompanyId and c.CompanyType=28 and c.IsActive=1 and r.IsActive=1
 union all
 select 'true' AS [@json:Array] , c.CompanyName as [Name],c.CompanyId as [Id],c.CompanyMnemonic as [Code]  
 from Company c where  c.CompanyType=28 and c.IsActive=1  and not EXISTS (select r.RouteId from Route r where r.CompanyId=@CompanyId and r.IsActive=1)) tmp order by [Name]
FOR XML path('BindingDataList'),ELEMENTS,ROOT('Json')) AS XML)
END
