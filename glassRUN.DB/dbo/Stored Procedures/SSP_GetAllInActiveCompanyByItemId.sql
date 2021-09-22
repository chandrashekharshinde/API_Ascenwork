CREATE PROCEDURE [dbo].[SSP_GetAllInActiveCompanyByItemId] --'<Json><ServicesAction>GetAllCompanyListByItemId</ServicesAction><ItemId>0</ItemId><Status>0</Status></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @ItemId bigint;
declare @Status int;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ItemId = tmp.[ItemId],
@Status = tmp.[Status]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemId] bigint,
			[Status] int
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  
    'true' AS [@json:Array] ,
    [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
	  ,[CompanyName]+' ('+ISNULL([CompanyMnemonic],'-')+')' as CompanyNameAndMnemonic
	  	  ,[CompanyType]
		  ,istm.ItemSoldToMappingId
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Postcode]
      ,[Region]
      ,[RouteCode]
      ,[ZoneCode]
      ,[CategoryCode]
      ,[BranchPlant]
      ,[Email]
      ,[TaxId]
      ,c.[SoldTo]
      ,c.[ShipTo]
      ,[BillTo]
      ,[SiteURL]
      ,[ContactPersonNumber]
      ,[ContactPersonName]
      ,[logo]
      ,[header]
      ,[footer]
	  ,0 as IsActiveForItem
	FROM [dbo].Company c right join ItemSoldToMapping istm on c.CompanyId = istm.SoldTo

  WHERE c.IsActive = 1 and CompanyType = 22  and ItemId = @ItemId and istm.IsActive = 1
   

   

	FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)
END
