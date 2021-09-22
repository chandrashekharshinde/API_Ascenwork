CREATE PROCEDURE [dbo].[SSP_LocationDetails_Paging]-- '<Json><ServicesAction>LoadLocationDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><LocationName></LocationName><LocationNameCriteria></LocationNameCriteria><DisplayName></DisplayName><DisplayNameCriteria></DisplayNameCriteria><LocationType></LocationType><LocationTypeCriteria></LocationTypeCriteria><AddressLine1></AddressLine1><AddressLine1Criteria></AddressLine1Criteria><AddressLine2></AddressLine2><AddressLine2Criteria></AddressLine2Criteria><AddressLine3></AddressLine3><AddressLine3Criteria></AddressLine3Criteria><City></City><CityCriteria></CityCriteria><CompanyName></CompanyName><CompanyNameCriteria></CompanyNameCriteria><State></State><StateCriteria></StateCriteria></Json>'
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

DECLARE @LocationCode nvarchar(150)
DECLARE @LocationCodeCriteria nvarchar(50)
DECLARE @LocationName nvarchar(150)
DECLARE @LocationNameCriteria nvarchar(50)
DECLARE @DisplayName nvarchar(150)
DECLARE @DisplayNameCriteria nvarchar(50)
DECLARE @LocationType nvarchar(150)
DECLARE @LocationTypeCriteria nvarchar(50)
DECLARE @AddressLine1 nvarchar(150)
DECLARE @AddressLine1Criteria nvarchar(50)
DECLARE @AddressLine2 nvarchar(150)
DECLARE @AddressLine2Criteria nvarchar(50)
DECLARE @AddressLine3 nvarchar(150)
DECLARE @AddressLine3Criteria nvarchar(50)
DECLARE @City nvarchar(150)
DECLARE @CityCriteria nvarchar(50)
DECLARE @State nvarchar(150)
DECLARE @StateCriteria nvarchar(50)
DECLARE @CompanyName nvarchar(150)
DECLARE @CompanyNameCriteria nvarchar(50)

DECLARE @LoginId BIGINT
Declare @PageName NVARCHAR(150)
declare @PageControlName     NVARCHAR(150)

set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	@LocationCode=tmp.[LocationCode],
	@LocationCodeCriteria=tmp.[LocationCodeCriteria],
    @LocationName=tmp.[LocationName],
	@LocationNameCriteria=tmp.[LocationNameCriteria],
	@DisplayName=tmp.[DisplayName],
	@DisplayNameCriteria=tmp.[DisplayNameCriteria],	
	@LocationType=tmp.LocationType,
	@LocationTypeCriteria=tmp.LocationTypeCriteria,
	@AddressLine1=tmp.AddressLine1,
	@AddressLine1Criteria=tmp.AddressLine1Criteria,
	@AddressLine2=tmp.AddressLine2,
	@AddressLine2Criteria=tmp.AddressLine2Criteria,
	@AddressLine3=tmp.AddressLine3,
	@AddressLine3Criteria=tmp.AddressLine3Criteria,
	@CompanyName=tmp.CompanyName,
	@CompanyNameCriteria=tmp.CompanyNameCriteria,
	@City=tmp.City,
	@CityCriteria=tmp.CityCriteria,
	@State=tmp.State,
	@StateCriteria=tmp.StateCriteria,
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@LoginId = tmp.[LoginId]
		,@PageName =tmp.[PageName]
		,@PageControlName=tmp.[PageControlName]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [LocationName] nvarchar(150),
   [LocationNameCriteria] nvarchar(50),
   [LocationCode] nvarchar(150),
   [LocationCodeCriteria] nvarchar(50),
   LocationType nvarchar(100),
   LocationTypeCriteria nvarchar(50),
   [DisplayName] nvarchar(150),
   [DisplayNameCriteria] nvarchar(50),
   [AddressLine1] nvarchar(500),
   [AddressLine1Criteria] nvarchar(50),
   [AddressLine2] nvarchar(500),
   [AddressLine2Criteria] nvarchar(50),
   [AddressLine3] nvarchar(500),
   [AddressLine3Criteria] nvarchar(50),
   [CompanyName] nvarchar(500),
   [CompanyNameCriteria] nvarchar(50),
   City nvarchar(150),
   CityCriteria nvarchar(50),
   State nvarchar(100),
   StateCriteria nvarchar(50)
   ,[LoginId] BIGINT
			,[PageControlName] nvarchar(250)
			,[PageName] nvarchar(250)
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @LocationName !=''
BEGIN

  IF @LocationNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationName LIKE ''%' + @LocationName + '%'''
  END
  IF @LocationNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationName NOT LIKE ''%' + @LocationName + '%'''
  END
  IF @LocationNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationName LIKE ''' + @LocationName + '%'''
  END
  IF @LocationNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationName LIKE ''%' + @LocationName + ''''
  END          
  IF @LocationNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and LocationName =  ''' +@LocationName+ ''''
  END
  IF @LocationNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and LocationName <>  ''' +@LocationName+ ''''
  END
END

IF @LocationCode !=''
BEGIN

  IF @LocationCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationCode LIKE ''%' + @LocationCode + '%'''
  END
  IF @LocationCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationCode NOT LIKE ''%' + @LocationCode + '%'''
  END
  IF @LocationCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationCode LIKE ''' + @LocationCode + '%'''
  END
  IF @LocationCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LocationCode LIKE ''%' + @LocationCode + ''''
  END          
  IF @LocationCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and LocationCode =  ''' +@LocationCode+ ''''
  END
  IF @LocationCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and LocationCode <>  ''' +@LocationCode+ ''''
  END
END

IF @DisplayName !=''
BEGIN

  IF @DisplayNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''%' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName NOT LIKE ''%' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''%' + @DisplayName + ''''
  END          
  IF @DisplayNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and DisplayName =  ''' +@DisplayName+ ''''
  END
  IF @DisplayNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DisplayName <>  ''' +@DisplayName+ ''''
  END
END

IF @LocationType !=''
BEGIN

  IF @LocationTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) LIKE ''%' + @LocationType + '%'''
  END
  IF @LocationTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) NOT LIKE ''%' + @LocationType + '%'''
  END
  IF @LocationTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) LIKE ''' + @LocationType + '%'''
  END
  IF @LocationTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) LIKE ''%' + @LocationType + ''''
  END          
  IF @LocationTypeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) =  ''' +@LocationType+ ''''
  END
  IF @LocationTypeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Location.LocationType) <>  ''' +@LocationType+ ''''
  END
END

IF @AddressLine1 !=''
BEGIN

  IF @AddressLine1Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''%' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 NOT LIKE ''%' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''%' + @AddressLine1 + ''''
  END          
  IF @AddressLine1Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine1 =  ''' +@AddressLine1+ ''''
  END
  IF @AddressLine1Criteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine1 <>  ''' +@AddressLine1+ ''''
  END
END

IF @AddressLine2 !=''
BEGIN

  IF @AddressLine2Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''%' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 NOT LIKE ''%' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''%' + @AddressLine2 + ''''
  END          
  IF @AddressLine2Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine2 =  ''' +@AddressLine2+ ''''
  END
  IF @AddressLine2Criteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine2 <>  ''' +@AddressLine2+ ''''
  END
END

IF @AddressLine3 !=''
BEGIN

  IF @AddressLine3Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''%' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 NOT LIKE ''%' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''%' + @AddressLine3 + ''''
  END          
  IF @AddressLine3Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine3 =  ''' +@AddressLine3+ ''''
  END
  IF @AddressLine3Criteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine3 <>  ''' +@AddressLine3+ ''''
  END
END

IF @State !=''
BEGIN

  IF @StateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and State LIKE ''%' + @State + '%'''
  END
  IF @StateCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and State NOT LIKE ''%' + @State + '%'''
  END
  IF @StateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and State LIKE ''' + @State + '%'''
  END
  IF @StateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and State LIKE ''%' + @State + ''''
  END          
  IF @StateCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and State =  ''' +@State+ ''''
  END
  IF @StateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and State <>  ''' +@State+ ''''
  END
END

IF @City !=''
BEGIN

  IF @CityCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and City LIKE ''%' + @City + '%'''
  END
  IF @CityCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and City NOT LIKE ''%' + @City + '%'''
  END
  IF @CityCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and City LIKE ''' + @City + '%'''
  END
  IF @CityCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and City LIKE ''%' + @City + ''''
  END          
  IF @CityCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and City =  ''' +@City+ ''''
  END
  IF @CityCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and City <>  ''' +@City+ ''''
  END
END

IF @CompanyName !=''
BEGIN

  IF @CompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) NOT LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) LIKE ''' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) LIKE ''%' + @CompanyName + ''''
  END          
  IF @CompanyNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) =  ''' +@CompanyName+ ''''
  END
  IF @CompanyNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) <>  ''' +@CompanyName+ ''''
  END
END

SET @whereClause = @whereClause + '' + (
			SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause](@LoginId, @PageName, @PageControlName)
			) + ''


set @sql=			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			[LocationId],
			[LocationName],
			[DisplayName]
		  ,[LocationCode]
		  ,[CompanyID]
		  ,[CompanyName]
		  ,[LocationType]
		  ,LocationTypeName
			,AddressLine1,
			AddressLine2,
			AddressLine3,
			[AddressLine4],
			City,
			State,	
			StateName,
			CityName,			
			[Pincode],			
			CreatedBy,
			CreatedDate,
			ModifiedBy,
			ModifiedDate,
			IsActive
			from (
			SELECT  distinct ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			[LocationId]
			,[LocationName]
			,[DisplayName]
			,[LocationCode]
			,[CompanyID]
			,(Select top 1 CompanyName from Company where Company.CompanyId=Location.CompanyID) as CompanyName
			,[LocationType]
			,(Select top 1 Name from Lookup where LookupId=Location.LocationType) as LocationTypeName
			,[LocationIdentifier]
			,[Area]
			,[AddressLine1]
			,[AddressLine2]
			,[AddressLine3]
			,[AddressLine4]
			,[City]
			,[State]
			--,(Select top 1 StateName from State where StateId=Location.State) as StateName
			--,(Select top 1 CityName from City where CityId=Location.City) as CityName
			,State as StateName
			,[City] as CityName
			,[Pincode]
			,CreatedBy
			,CreatedDate
			,ModifiedBy
			,ModifiedDate
			,IsActive
				
				 from Location 		
  where ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''LocationList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
  execute (@sql + @sql1)
END
