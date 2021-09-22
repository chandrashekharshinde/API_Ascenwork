CREATE PROCEDURE [dbo].[SSP_CompanyTransporterMapping_Paging] --'<Json><ServicesAction>LoadRouteDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><CompanyName></CompanyName><CompanyNameCriteria></CompanyNameCriteria><TransporterName></TransporterName><TransporterNameCriteria></TransporterNameCriteria><OriginName></OriginName><OriginNameCriteria></OriginNameCriteria><DestinationName></DestinationName><DestinationNameCriteria></DestinationNameCriteria><TruckSizeName></TruckSizeName><TruckSizeNameCriteria></TruckSizeNameCriteria></Json>'
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

DECLARE @CompanyName nvarchar(150)
DECLARE @CompanyNameCriteria nvarchar(50)
DECLARE @TransporterName nvarchar(150)
DECLARE @TransporterNameCriteria nvarchar(50)
DECLARE @OriginName nvarchar(150)
DECLARE @OriginNameCriteria nvarchar(50)
DECLARE @DestinationName nvarchar(150)
DECLARE @DestinationNameCriteria nvarchar(50)
DECLARE @TruckSizeName nvarchar(150)
DECLARE @TruckSizeNameCriteria nvarchar(50)






set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @CompanyName=tmp.[CompanyName],
	@CompanyNameCriteria=tmp.[CompanyNameCriteria],
	@TransporterName=tmp.[TransporterName],
	@TransporterNameCriteria=tmp.[TransporterNameCriteria],
	@OriginName=tmp.[OriginName],
	@OriginNameCriteria=tmp.[OriginNameCriteria],
	@DestinationName=tmp.[DestinationName],
	@DestinationNameCriteria=tmp.[DestinationNameCriteria],
	@TruckSizeName=tmp.[TruckSizeName],
	@TruckSizeNameCriteria=tmp.[TruckSizeNameCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [CompanyName] nvarchar(150),
   [CompanyNameCriteria] nvarchar(50),
   [TransporterName] nvarchar(150),
   [TransporterNameCriteria] nvarchar(50),
   [OriginName] nvarchar(150),
   [OriginNameCriteria] nvarchar(50),
   [DestinationName] nvarchar(150),
   [DestinationNameCriteria] nvarchar(50),
   [TruckSizeName] nvarchar(150),
   [TruckSizeNameCriteria] nvarchar(50),
   [CarrierId] int
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @CompanyName !=''
BEGIN

  IF @CompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName NOT LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyName + ''''
  END          
  IF @CompanyNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyName =  ''' +@CompanyName+ ''''
  END
  IF @CompanyNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyName <>  ''' +@CompanyName+ ''''
  END
END

IF @TransporterName !=''
BEGIN

  IF @TransporterNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterName LIKE ''%' + @TransporterName + '%'''
  END
  IF @TransporterNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterName NOT LIKE ''%' + @TransporterName + '%'''
  END
  IF @TransporterNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterName LIKE ''' + @TransporterName + '%'''
  END
  IF @TransporterNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterName LIKE ''%' + @TransporterName + ''''
  END          
  IF @TransporterNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterName =  ''' +@TransporterName+ ''''
  END
  IF @TransporterNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterName <>  ''' +@TransporterName+ ''''
  END
END

IF @OriginName !=''
BEGIN

  IF @OriginNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  OriginName LIKE ''%' + @OriginName + '%'''
  END
  IF @OriginNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OriginName NOT LIKE ''%' + @OriginName + '%'''
  END
  IF @OriginNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  OriginName LIKE ''' + @OriginName + '%'''
  END
  IF @OriginNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OriginName LIKE ''%' + @OriginName + ''''
  END          
  IF @OriginNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and  OriginName =  ''' +@OriginName+ ''''
  END
  IF @OriginNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and  OriginName <>  ''' +@OriginName+ ''''
  END
END

IF @DestinationName !=''
BEGIN

  IF @DestinationNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DestinationName LIKE ''%' + @DestinationName + '%'''
  END
  IF @DestinationNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DestinationName NOT LIKE ''%' + @DestinationName + '%'''
  END
  IF @DestinationNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DestinationName LIKE ''' + @DestinationName + '%'''
  END
  IF @DestinationNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DestinationName LIKE ''%' + @DestinationName + ''''
  END          
  IF @DestinationNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DestinationName =  ''' +@DestinationName+ ''''
  END
  IF @DestinationNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DestinationName <>  ''' +@DestinationName+ ''''
  END
END


IF @TruckSizeName !=''
BEGIN

  IF @TruckSizeNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSizeName LIKE ''%' + @TruckSizeName + '%'''
  END
  IF @TruckSizeNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSizeName NOT LIKE ''%' + @TruckSizeName + '%'''
  END
  IF @TruckSizeNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSizeName LIKE ''' + @TruckSizeName + '%'''
  END
  IF @TruckSizeNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSizeName LIKE ''%' + @TruckSizeName + ''''
  END          
  IF @TruckSizeNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSizeName =  ''' +@TruckSizeName+ ''''
  END
  IF @TruckSizeNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSizeName <>  ''' +@TruckSizeName+ ''''
  END
END

set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select distinct ''true'' AS [@json:Array],
			TotalCount,
			[CompanyId],
			[RouteId],
			[CompanyName],
			[DestinationId],
			OriginId,
			TruckSizeId,
			CONVERT(VARCHAR(10),CreatedDate, 103) as CreatedDate,
			[TransPorterName],
			DestinationName,
			OriginName,
			TruckSizeName,
			IsActive
			--[TranporterId]
			 from (
			 Select *,ROW_NUMBER() OVER (ORDER BY  ISNULL(UpdatedDate,CreatedDate) desc) as rownumber,
			COUNT(*) OVER () as TotalCount from (
			SELECT distinct 
			 [CompanyId],

			(select STUFF(( SELECT  '', ''+c1.CompanyName+ '' (''+c1.CompanyMnemonic+'')'' FROM Company c1 where c1.[CompanyId] in (
			SELECT * FROM [dbo].[fnSplitValues] ((select STUFF(( SELECT  '', ''+r1.CarrierNumber 
			FROM [Route] r1 where r1.[RouteId]=R.[RouteId] and r1.IsActive = 1  FOR XML PATH('''') ), 1, 1, ''''))))
			FOR XML PATH('''') ), 1, 1, '''')) as TransPorterName,

			(select top 1 CompanyName+ '' (''+CompanyMnemonic+'')'' from Company tr where tr.CompanyId=r.[CompanyId]) as CompanyName,
			r.RouteId,
			r.UpdatedDate,
			r.CreatedDate,
			r.[RouteNumber],
			r.[OriginId],
			r.[DestinationId],
			r.[TruckSizeId],
			(select top 1 LocationName from Location where Location.IsActive=1 and LocationId=r.[DestinationId]) as DestinationName,
			(select top 1 LocationName from Location where Location.IsActive=1 and LocationId=r.[OriginId]) as OriginName,
			(select top 1 TruckSize from TruckSize where TruckSizeId=r.[TruckSizeId]) as TruckSizeName,
			r.[IsActive]
			from [Route] r) as tmp12
			where tmp12.IsActive in (1,0)
			-- [CompanyId],
			--(select STUFF(( SELECT  '', ''+c1.CompanyName FROM Company c1 where c1.[CompanyId] in (
			--SELECT * FROM [dbo].[fnSplitValues] ((select STUFF(( SELECT  '', ''+r1.CarrierNumber FROM [Route] r1 where r1.[CompanyId]=R.[CompanyId] and r1.IsActive = 1 FOR XML PATH('''') ), 1, 1, ''''))))
			--FOR XML PATH('''') ), 1, 1, '''')) as TransPorterName,
			--(select top 1 CompanyName from Company tr where tr.CompanyId=r.[CompanyId]) as CompanyName,
			--r.[RouteNumber],
			--r.[OriginId],
			--r.[DestinationId],
			--r.[TruckSizeId],
			--r.[IsActive]
			--from [Route] r
			--where r.IsActive = 1 
			 and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''RouteObjectList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END
