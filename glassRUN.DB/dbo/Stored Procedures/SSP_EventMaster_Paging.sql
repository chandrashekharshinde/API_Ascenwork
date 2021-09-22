
CREATE PROCEDURE [dbo].[SSP_EventMaster_Paging] --'<Json><ServicesAction>LoadUserProfile</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><UserName></UserName><UserNameCriteria></UserNameCriteria><EmailId></EmailId><EmailIdCriteria></EmailIdCriteria><LicenseNumber></LicenseNumber><LicenseNumberCriteria></LicenseNumberCriteria><ContactNumber></ContactNumber><ContactNumberCriteria></ContactNumberCriteria><CarrierId>358</CarrierId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @whereClauseIcon NVARCHAR(max)

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)

DECLARE @EventCode nvarchar(150)
DECLARE @EventCodeCriteria nvarchar(50)
DECLARE @EventDescription nvarchar(150)
DECLARE @EventDescriptionCriteria nvarchar(50)

--CompanyType
--CompanyTypeCriteria
--SKUCode
--SKUCodeCriteria
--Company
--CompanyCriteria






set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @EventCode=tmp.[EventCode],
	@EventCodeCriteria=tmp.[EventCodeCriteria],
	@EventDescription=tmp.[EventDescription],
	@EventDescriptionCriteria=tmp.[EventDescriptionCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [EventCode] nvarchar(150),
   [EventCodeCriteria] nvarchar(50),
   [EventDescription] nvarchar(150),
   [EventDescriptionCriteria] nvarchar(50),
   [CarrierId] int
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @EventCode !=''
BEGIN

  IF @EventCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode NOT LIKE ''%' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventCode + ''''
  END          
  IF @EventCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode =  ''' +@EventCode+ ''''
  END
  IF @EventCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode <>  ''' +@EventCode+ ''''
  END
END

IF @EventDescription !=''
BEGIN

  IF @EventDescriptionCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventDescription LIKE ''%' + @EventDescription + '%'''
  END
  IF @EventDescriptionCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventDescription NOT LIKE ''%' + @EventDescription + '%'''
  END
  IF @EventDescriptionCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventDescription LIKE ''' + @EventDescription + '%'''
  END
  IF @EventDescriptionCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventDescription LIKE ''%' + @EventDescription + ''''
  END          
  IF @EventDescriptionCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventDescription =  ''' +@EventDescription+ ''''
  END
  IF @EventDescriptionCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventDescription <>  ''' +@EventDescription+ ''''
  END
END





set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			[EventMasterId],
			[EventCode],
			[EventDescription],
			[IsActive],
			[CreatedBy],
			[CreatedDate],	
			[UpdatedBy],
			[UpdatedDate]
			--,CONVERT(XML,DocumentsList)

			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			[EventMasterId],
			[EventCode],
			[EventDescription],
			[IsActive],
			[CreatedBy],
			[CreatedDate],	
			[UpdatedBy],
			[UpdatedDate]
			from EventMaster
 where IsActive=1    and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''EventMasterList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END