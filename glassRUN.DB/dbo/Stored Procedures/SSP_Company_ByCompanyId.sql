CREATE PROCEDURE [dbo].[SSP_Company_ByCompanyId] --1
@companyId BIGINT
AS
BEGIN

	SELECT  [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
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
      ,[Field10]
	FROM [dbo].Company
	 WHERE (CompanyId=@companyId OR @companyId=0) AND IsActive=1
	FOR XML RAW('Company'),ELEMENTS
	
	
	
END
