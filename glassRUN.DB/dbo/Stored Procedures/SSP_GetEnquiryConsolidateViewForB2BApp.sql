
CREATE PROCEDURE [dbo].[SSP_GetEnquiryConsolidateViewForB2BApp] --'<Json><ServicesAction>GetEnquiryForSubDApp</ServicesAction><CompanyId>10056</CompanyId><searchValue></searchValue><OrderStatus>Active</OrderStatus><FromDate>2019-12-27</FromDate><ToDate>2019-12-30</ToDate><orderBy></orderBy></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @fromDate nvarchar(50)
declare @toDate nvarchar(50)
declare @companyIds nvarchar(500)

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
@toDate = tmp.ToDate

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint,
			FromDate nvarchar(50),
			ToDate nvarchar(50)
			)tmp;

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

IF(RTRIM(ISNULL(@fromDate,'')) <> '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	IF(RTRIM(ISNULL(@fromDate,'')) <> RTRIM(ISNULL(@toDate,'')))
	BEGIN 
		SET @whereClause = @whereClause + ' and (CONVERT(DATE,dbo.Enquiry.RequestDate, 103) BETWEEN CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103) AND CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
	END
	ELSE
	BEGIN
		SET @whereClause = @whereClause + ' and (CONVERT(DATE,dbo.Enquiry.RequestDate, 103) = CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103)' 
	END
END
ELSE IF(RTRIM(ISNULL(@fromDate,'')) = '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,dbo.Enquiry.RequestDate, 103) < CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
END
ELSE
BEGIN
	
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,dbo.Enquiry.RequestDate, 103) <= CONVERT(DATE,DATEADD(day, 7, GETDATE()), 103))' 

END

SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,
dbo.Enquiry.EnquiryId, dbo.Enquiry.EnquiryAutoNumber, dbo.Enquiry.SoldToCode, dbo.Enquiry.SoldToName, dbo.Enquiry.ShipToCode, dbo.Enquiry.ShipToName, dbo.EnquiryProduct.ProductCode, dbo.EnquiryProduct.ProductName, 
                         dbo.EnquiryProduct.ProductQuantity, (CONVERT(varchar,dbo.Enquiry.RequestDate, 103)) As RequestDate, dbo.EnquiryProduct.UnitPrice, dbo.Enquiry.TotalPrice
						 ,(select count(*) from Enquiry e1 WHERE e1.IsActive = 1 and e1.RequestDate is not null
	  and e1.CompanyId = ' + CAST(@companyId AS nvarchar(500)) + ' and e1.CurrentState = 1 
	  and (CONVERT(date,e1.RequestDate, 103)) = (CONVERT(date,dbo.Enquiry.RequestDate, 103))) as TotalEnquiriesCount
	  ,ISNULL((select SUM(its.ItemQuantity) from ItemStock its where its.ItemCode = dbo.EnquiryProduct.ProductCode),0) As Stock
	  ,isnull((select top 1 PriorityRating from CustomerPriority p where p.CompanyId=dbo.Enquiry.SoldTo and p.IsActive=1 and p.ParentCompanyId=' + CAST(@companyId AS nvarchar(500)) + '),0) as PriorityRating
FROM            dbo.Enquiry INNER JOIN
                         dbo.EnquiryProduct ON dbo.Enquiry.EnquiryId = dbo.EnquiryProduct.EnquiryId
						 where dbo.Enquiry.RequestDate is not null
						 and dbo.Enquiry.CompanyId = ' + CAST(@companyId AS nvarchar(500)) + '  and dbo.Enquiry.CurrentState = 1 and dbo.Enquiry.IsActive = 1
						 and ' + @whereClause + '

	  FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'

	  PRINT @sql
 
 EXEC sp_executesql @sql

	--and (CONVERT(DATETIME,dbo.Enquiry.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))

END


