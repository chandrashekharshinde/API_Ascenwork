

-- =============================================
-- Author:		Vinod Yadav
-- Create date: 20 jan 2020
-- Description:	<Description,,>
-- exec [dbo].[SSP_GetEnquiryConsolidateViewV2] 10056 ,'',''
-- exec [dbo].[SSP_GetEnquiryConsolidateViewV2]
-- exec [dbo].[SSP_GetEnquiryConsolidateViewV2]
-- =============================================

CREATE PROCEDURE [dbo].[SSP_GetEnquiryConsolidateViewV2] 

@companyId bigint,
@fromDate nvarchar(50),
@toDate nvarchar(50)

AS

BEGIN

DECLARE @sql nvarchar(max)
DECLARE @whereClause NVARCHAR(max)

set  @whereClause =''

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

IF(RTRIM(ISNULL(@fromDate,'')) <> '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	IF(RTRIM(ISNULL(@fromDate,'')) <> RTRIM(ISNULL(@toDate,'')))
	BEGIN 
	    SET @whereClause = @whereClause + ' and (CONVERT(DATE,eq.RequestDate, 103) BETWEEN CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103) AND CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
	END
	ELSE
	BEGIN
		SET @whereClause = @whereClause + ' and (CONVERT(DATE,eq.RequestDate, 103) = CONVERT(DATE,CAST(''' + @fromDate + ''' As Date), 103)' 
	END
END
ELSE IF(RTRIM(ISNULL(@fromDate,'')) = '' and RTRIM(ISNULL(@toDate,'')) <> '') 
BEGIN 
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,eq.RequestDate, 103) < CONVERT(DATE,CAST(''' + @toDate + ''' As Date), 103))' 
END
ELSE
BEGIN
	
	SET @whereClause = @whereClause + ' and (CONVERT(DATE,eq.RequestDate, 103) <= CONVERT(DATE,DATEADD(day, 7, GETDATE()), 103))' 

END

SET @sql = 'SELECT eq.EnquiryId, eq.EnquiryAutoNumber, eq.SoldToCode, eq.SoldToName, eq.ShipToCode, eq.ShipToName, eqp.ProductCode, eqp.ProductName, 
				eqp.ProductQuantity,eqp.UOM, eq.RequestDate,Isnull(eqp.UnitPrice,0) as UnitPrice, Isnull(eq.TotalPrice,0) as TotalPrice
				,0 as TotalEnquiriesCount
				,0 As Stock
				,isnull(cp.PriorityRating,0) as PriorityRating
				FROM dbo.Enquiry eq with (NOLOCK) INNER JOIN
				dbo.EnquiryProduct eqp with (NOLOCK)  ON eq.EnquiryId = eqp.EnquiryId
				Left JOIN CustomerPriority cp with (NOLOCK) ON cp.CompanyId=eq.SoldTo and cp.IsActive=1 and cp.ParentCompanyId=' + CAST(@companyId AS nvarchar(500)) + '
				where eq.RequestDate is not null
				and eq.CompanyId = ' + CAST(@companyId AS nvarchar(500)) + '  and eq.CurrentState = 1 and eq.IsActive = 1
				and ' + @whereClause + ''

	  PRINT @sql
 
 EXEC sp_executesql @sql

END
