
CREATE PROCEDURE [dbo].[SSP_EventObjectPropertiesMapping_Paging] --'<Json><ServicesAction>LoadUserProfile</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><UserName></UserName><UserNameCriteria></UserNameCriteria><EmailId></EmailId><EmailIdCriteria></EmailIdCriteria><LicenseNumber></LicenseNumber><LicenseNumberCriteria></LicenseNumberCriteria><ContactNumber></ContactNumber><ContactNumberCriteria></ContactNumberCriteria><CarrierId>358</CarrierId></Json>'
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

DECLARE @ObjectName nvarchar(150)
DECLARE @ObjectNameCriteria nvarchar(50)
DECLARE @EventMasterName nvarchar(150)
DECLARE @EventMasterNameCriteria nvarchar(50)
DECLARE @ObjectPropertiesName nvarchar(150)
DECLARE @ObjectPropertiesNameCriteria nvarchar(50)








set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @ObjectName=tmp.[ObjectName],
	@ObjectNameCriteria=tmp.[ObjectNameCriteria],
	@EventMasterName=tmp.[EventMasterName],
	@EventMasterNameCriteria=tmp.[EventMasterNameCriteria],
	@ObjectPropertiesName=tmp.[ObjectPropertiesName],
	@ObjectPropertiesNameCriteria=tmp.[ObjectPropertiesNameCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [ObjectName] nvarchar(150),
   [ObjectNameCriteria] nvarchar(50),
   [EventMasterName] nvarchar(150),
   [EventMasterNameCriteria] nvarchar(50),
   [ObjectPropertiesName] nvarchar(150),
   [ObjectPropertiesNameCriteria] nvarchar(50),
   [CarrierId] int
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @ObjectName !=''
BEGIN

  IF @ObjectNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ObjectName LIKE ''%' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ObjectName NOT LIKE ''%' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ObjectName LIKE ''' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ObjectName LIKE ''%' + @ObjectName + ''''
  END          
  IF @ObjectNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ObjectName =  ''' +@ObjectName+ ''''
  END
  IF @ObjectNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ObjectName <>  ''' +@ObjectName+ ''''
  END
END

IF @EventMasterName !=''
BEGIN

  IF @EventMasterNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventMasterName + '%'''
  END
  IF @EventMasterNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode NOT LIKE ''%' + @EventMasterName + '%'''
  END
  IF @EventMasterNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''' + @EventMasterName + '%'''
  END
  IF @EventMasterNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventMasterName + ''''
  END          
  IF @EventMasterNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode =  ''' +@EventMasterName+ ''''
  END
  IF @EventMasterNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode <>  ''' +@EventMasterName+ ''''
  END
END

IF @ObjectPropertiesName !=''
BEGIN

  IF @ObjectPropertiesNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @ObjectPropertiesName + '%'''
  END
  IF @ObjectPropertiesNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') NOT LIKE ''%' + @ObjectPropertiesName + '%'''
  END
  IF @ObjectPropertiesNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') LIKE ''' + @ObjectPropertiesName + '%'''
  END
  IF @ObjectPropertiesNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @ObjectPropertiesName + ''''
  END          
  IF @ObjectPropertiesNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') =  ''' +@ObjectPropertiesName+ ''''
  END
  IF @ObjectPropertiesNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') <>  ''' +@ObjectPropertiesName+ ''''
  END
END



set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			[EventMasterId],
			[ObjectId],
			[ObjectPropertiesId],
			[EventCode] as EventMasterName,
			[DisplayName] as ObjectName,
			[PropertyName] as ObjectPropertiesName,
			[IsActive]
			

			 from (
			SELECT distinct ROW_NUMBER() OVER (ORDER BY   ISNULL(Eopm.EventMasterId ,eopm.objectid) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			
			 Eopm.EventMasterId , Eopm.ObjectId,
			em.[EventCode],
			STUFF( (SELECT '','' +  op.PropertyName  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') PropertyName,
			STUFF( (SELECT '','' + convert(nvarchar(max),op.ObjectPropertiesId)  FROM ObjectProperties op  where op.ObjectPropertiesId in 
			(select opm1.ObjectPropertyIds from EventObjectPropertiesMapping opm1 where opm1.EventMasterId=Eopm.EventMasterId and opm1.ObjectId=Eopm.ObjectId)     FOR XML PATH (''''))  , 1, 1, '''') ObjectPropertiesId,
			obj.[DisplayName],
			Eopm.[IsActive]
			from EventMaster em left join EventObjectPropertiesMapping Eopm
			left join Object obj on Eopm.ObjectId = obj.ObjectId
			on em.EventMasterId = Eopm.EventMasterId
			where em.IsActive = 1 and obj.IsActive=1 and Eopm.isactive = 1   and  ' + @whereClause +' group by Eopm.EventMasterId ,eopm.objectid ,em.[EventCode],obj.[DisplayName],	Eopm.[IsActive]) as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''EventObjectPropertiesMappingList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END