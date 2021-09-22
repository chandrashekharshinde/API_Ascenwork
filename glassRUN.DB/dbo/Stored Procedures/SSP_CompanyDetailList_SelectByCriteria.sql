CREATE PROCEDURE [dbo].[SSP_CompanyDetailList_SelectByCriteria]--'<Json><ServicesAction>LoadCustomerServiceEnquiryDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><OrderBy></OrderBy><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)



set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [EnquiryAutoNumber] nvarchar(150),
   [EnquiryAutoNumberCriteria] nvarchar(50)
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'tmp.CompanyId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((  select *from ( SELECT    
 COUNT(CompanyId) OVER () as TotalCount, [CompanyId]
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
	FROM [dbo].Company   where IsActive=1) tmp
   WHERE ' + @whereClause + ' ORDER BY '+@orderBy+' OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY  FOR XML path(''CompanyList''),ELEMENTS,ROOT(''Json'')) AS XML)'



   

 PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
