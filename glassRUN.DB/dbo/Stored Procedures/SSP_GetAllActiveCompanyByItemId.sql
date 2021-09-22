CREATE PROCEDURE [dbo].[SSP_GetAllActiveCompanyByItemId] --'<Json><ServicesAction>GetAllCompanyListByItemId</ServicesAction><ItemId>73</ItemId><Status>0</Status></Json>'
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
      ,[SoldTo]
      ,[ShipTo]
      ,[BillTo]
      ,[SiteURL]
      ,[ContactPersonNumber]
      ,[ContactPersonName]
      ,[logo]
      ,[header]
      ,[footer]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
	  ,ISNULL((select top 1 ItemSoldToMappingId from ItemSoldToMapping where ItemId = @ItemId and IsActive = 1 and  CompanyMnemonic = SoldTo),0) as ItemSoldToMappingId
      ,[Field10]
	  , CASE WHEN (select count(SoldTo) from ItemSoldToMapping where ItemId = @ItemId and IsActive = 1 and CompanyMnemonic = SoldTo) > 0
        THEN 0 ELSE 1 END
	   as IsActiveForItem
	FROM [dbo].Company 

  WHERE IsActive = 1 and CompanyType in (22,26) and Field10 <> 'G' or Field10 is null
  

   

	FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)
END