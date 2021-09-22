
CREATE PROCEDURE [dbo].[SSP_GetEnquiryOfCustomerB2BApp] --'<Json><ServicesAction>GetEnquiryForSubDApp</ServicesAction><CompanyId>10056</CompanyId><SoldToCode>76666002</SoldToCode><searchValue></searchValue><OrderStatus>Active</OrderStatus><FromDate>2020-1-1</FromDate><ToDate>2020-1-1</ToDate><orderBy></orderBy></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @searchValue nvarchar(500)
declare @orderStatus nvarchar(50)
declare @fromDate nvarchar(50)
declare @toDate nvarchar(50)
declare @soldToCode nvarchar(500)

DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
DECLARE @whereClause NVARCHAR(max)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

set  @whereClause =''

SELECT 

@companyId = tmp.CompanyId,
@fromDate = tmp.FromDate,
@toDate = tmp.ToDate,
@soldToCode = tmp.SoldToCode

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint,
			FromDate nvarchar(50),
			ToDate nvarchar(50),
			SoldToCode nvarchar(500)
			)tmp;

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

IF(RTRIM(ISNULL(@soldToCode,'')) = '') BEGIN SET @soldToCode = '' END

IF(RTRIM(ISNULL(@fromDate,'')) <> '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	IF(RTRIM(ISNULL(@fromDate,'')) <> RTRIM(ISNULL(@toDate,'')))
	BEGIN 
		SET @whereClause = @whereClause + ' and (CONVERT(DATE,tmp.RequestDate, 103) BETWEEN CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103) AND CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
	END
	ELSE
	BEGIN
		SET @whereClause = @whereClause + ' and (CONVERT(DATE,tmp.RequestDate, 103) = CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103))' 
	END
END
ELSE IF(RTRIM(ISNULL(@fromDate,'')) = '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,tmp.RequestDate, 103) < CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
END
ELSE
BEGIN
	
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,tmp.RequestDate, 103) <= CONVERT(DATE,DATEADD(day, 7, GETDATE()), 103))' 

END

SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]
		  ,EnquiryId
		  ,EnquiryAutoNumber
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,(CONVERT(varchar,RequestDate, 103)) As RequestDate
		  ,(CONVERT(varchar,EnquiryDate, 103)) As EnquiryDate
		  ,TotalPrice
		  ,PriorityRating
		  ,(select cast ((SELECT ''true'' AS [@json:Array] , ep.[EnquiryProductId]
	,ep.[EnquiryId]
	,ep.[ProductCode]
	,ep.ProductName
	,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ProductPrice
	,ISNULL((ep.UnitPrice),0) as ProductPricePerUnit
	,ep.[ProductQuantity]
	,ep.[ItemType]
	,ISNULL((select SUM(its.ItemQuantity) from ItemStock its where its.ItemCode = ep.ProductCode),0) As Stock
	from [EnquiryProduct] ep
	WHERE ep.IsActive = 1 AND ep.EnquiryId = tmp.EnquiryId 
	FOR XML path(''EnquiryProductList''),ELEMENTS) AS xml))
		  from 
		  (SELECT EnquiryId
		  ,EnquiryAutoNumber
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,RequestDate
		  ,EnquiryDate
		  ,TotalPrice
		  ,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=Enquiry.SoldTo and p.IsActive=1 and p.ParentCompanyId=' + CAST(@companyId AS nvarchar(500)) + '),0) as PriorityRating
		  from Enquiry WHERE IsActive = 1
		  and CompanyId = ' + CAST(@companyId AS nvarchar(500)) + ' and CurrentState = 1 and RequestDate is not null) as tmp
		  WHERE (tmp.SoldToCode = ''' + @soldToCode + ''' or ''' + @soldToCode + ''' = '''') and ' + @whereClause + '
		  order by  tmp.RequestDate desc

		  FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'
PRINT @sql
 
 EXEC sp_executesql @sql

END
