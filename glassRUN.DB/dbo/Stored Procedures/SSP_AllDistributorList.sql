Create PROCEDURE [dbo].[SSP_AllDistributorList] --'<Json><ServicesAction>LoadDistributorDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><UserId>0</UserId></Json>'
(@xmlDoc XML)
AS
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @transportVehicle nvarchar(150)
DECLARE @TruckTypeCriteria nvarchar(50)
DECLARE @TruckSize nvarchar(150)
DECLARE @transportVehicleCriteria nvarchar(50)
DECLARE @userId bigint

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@userId=tmp.UserId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),    
   UserId bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ProfileId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)







set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
UserName,
ProfileId,
Name,
EmailId,
ContactNumber,
ISNULL(ReferenceId,0) as ReferenceId

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(p.UpdatedDate,p.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
l.UserName,
p.ProfileId,
p.Name,
p.EmailId,
p.ContactNumber,
p.UpdatedDate,
p.CreatedDate,
p.ReferenceId
 from Login l join Profile p on l.ProfileId=p.ProfileId
	  WHERE l.IsActive = 1 and p.IsActive=1 and l.RoleMasterId in (select RoleMasterId from RoleMaster where RoleName=''Customer'')  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''ProfileList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
