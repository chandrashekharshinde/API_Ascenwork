CREATE PROCEDURE [dbo].[SSP_TruckSize_Paging] --'<Json><ServicesAction>LoadUserProfile</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><EmailId></EmailId><EmailIdCriteria></EmailIdCriteria><LicenseNumber></LicenseNumber><LicenseNumberCriteria></LicenseNumberCriteria><ContactNumber></ContactNumber><ContactNumberCriteria></ContactNumberCriteria><CarrierId>358</CarrierId></Json>'
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

DECLARE @VehicleType nvarchar(150)
DECLARE @VehicleTypeCriteria nvarchar(50)
DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(50)
DECLARE @TruckCapacityPalettes nvarchar(150)
DECLARE @TruckCapacityPalettesCriteria nvarchar(50)
DECLARE @TruckCapacityWeight nvarchar(150)
DECLARE @TruckCapacityWeightCriteria nvarchar(50)
DECLARE @Height nvarchar(150)
DECLARE @HeightCriteria nvarchar(50)
DECLARE @Width nvarchar(150)
DECLARE @WidthCriteria nvarchar(50)
DECLARE @Length nvarchar(150)
DECLARE @LengthCriteria nvarchar(50)







set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @VehicleType=tmp.[VehicleType],
	@VehicleTypeCriteria=tmp.[VehicleTypeCriteria],
	@TruckSize=tmp.[TruckSize],
	@TruckSizeCriteria=tmp.[TruckSizeCriteria],

	@TruckCapacityPalettes=tmp.[TruckCapacityPalettes],
	@TruckCapacityPalettesCriteria=tmp.[TruckCapacityPalettesCriteria],
	
	@TruckCapacityWeight=tmp.[TruckCapacityWeight],
	@TruckCapacityWeightCriteria=tmp.[TruckCapacityWeightCriteria],
	@Height=tmp.[Height],
    @HeightCriteria=tmp.[HeightCriteria],
	
	@Width=tmp.[Width],
	@WidthCriteria=tmp.[WidthCriteria],
	@Length=tmp.[Length],
	@LengthCriteria=tmp.[LengthCriteria],


    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [VehicleType] nvarchar(150),
   [VehicleTypeCriteria] nvarchar(50),
   [TruckSize] nvarchar(150),
   [TruckSizeCriteria] nvarchar(50),
   [TruckCapacityPalettes] nvarchar(150),
   [TruckCapacityPalettesCriteria] nvarchar(50),
   [TruckCapacityWeight] nvarchar(150),
   [TruckCapacityWeightCriteria] nvarchar(50),
   [Height]varchar(50),
   [HeightCriteria] nvarchar(50),
   [Width]varchar(50),
   [WidthCriteria] nvarchar(50),
   [Length]varchar(50),
   [LengthCriteria] nvarchar(50),
   [CarrierId] int
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'CreatedDate desc' END


SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @VehicleType !=''
BEGIN

  IF @VehicleTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) LIKE ''%' + @VehicleType + '%'''
  END
  IF @VehicleTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) NOT LIKE ''%' + @VehicleType + '%'''
  END
  IF @VehicleTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) LIKE ''' + @VehicleType + '%'''
  END
  IF @VehicleTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) LIKE ''%' + @VehicleType + ''''
  END          
  IF @VehicleTypeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) =  ''' +@VehicleType+ ''''
  END
  IF @VehicleTypeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from  LookUp where LookUpId=[VehicleType]) <>  ''' +@VehicleType+ ''''
  END
END

IF @TruckSize !=''
BEGIN

  IF @TruckSizeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize NOT LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + ''''
  END          
  IF @TruckSizeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize =  ''' +@TruckSize+ ''''
  END
  IF @TruckSizeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize <>  ''' +@TruckSize+ ''''
  END
END

IF @TruckCapacityPalettes !=''
BEGIN

  IF @TruckCapacityPalettesCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityPalettes LIKE ''%' + @TruckCapacityPalettes + '%'''
  END
  IF @TruckCapacityPalettesCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityPalettes NOT LIKE ''%' + @TruckCapacityPalettes + '%'''
  END
  IF @TruckCapacityPalettesCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityPalettes LIKE ''' + @TruckCapacityPalettes + '%'''
  END
  IF @TruckCapacityPalettesCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityPalettes LIKE ''%' + @TruckCapacityPalettes + ''''
  END          
  IF @TruckCapacityPalettesCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityPalettes =  ''' +@TruckCapacityPalettes+ ''''
  END
  IF @TruckCapacityPalettesCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityPalettes <>  ''' +@TruckCapacityPalettes+ ''''
  END
END


IF @TruckCapacityWeight !=''
BEGIN

  IF @TruckCapacityWeightCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityWeight LIKE ''%' + @TruckCapacityWeight + '%'''
  END
  IF @TruckCapacityWeightCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityWeight NOT LIKE ''%' + @TruckCapacityWeight + '%'''
  END
  IF @TruckCapacityWeightCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityWeight LIKE ''' + @TruckCapacityWeight + '%'''
  END
  IF @TruckCapacityWeightCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckCapacityWeight LIKE ''%' + @TruckCapacityWeight + ''''
  END          
  IF @TruckCapacityWeightCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityWeight =  ''' +@TruckCapacityWeight+ ''''
  END
  IF @TruckCapacityWeightCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityWeight <>  ''' +@TruckCapacityWeight+ ''''
  END
END

  IF @Height !=''
	BEGIN

	  IF @HeightCriteria = 'contains'
	  BEGIN
  
	  SET @whereClause = @whereClause + ' and Height LIKE ''%' + @Height + '%'''
	  END
	  IF @HeightCriteria = 'notcontains'
	  BEGIN
  
	  SET @whereClause = @whereClause + ' and Height NOT LIKE ''%' + @Height + '%'''
	  END
	  IF @HeightCriteria = 'startswith'
	  BEGIN
  
	  SET @whereClause = @whereClause + ' and Height LIKE ''' + @Height + '%'''
	  END
	  IF @HeightCriteria = 'endswith'
	  BEGIN
  
	  SET @whereClause = @whereClause + ' and Height LIKE ''%' + @Height + ''''
	  END          
	  IF @HeightCriteria = 'eq'
	 BEGIN

	 SET @whereClause = @whereClause + ' and TruckCapacityPalettes =  ''' +@Height+ ''''
	  END
	  IF @HeightCriteria = 'neq'
	 BEGIN

 SET @whereClause = @whereClause + ' and Height <>  ''' +@Height+ ''''
  END
END

  IF @Width !=''
BEGIN

  IF @WidthCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Width LIKE ''%' + @Width + '%'''
  END
  IF @WidthCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Width NOT LIKE ''%' + @Width + '%'''
  END
  IF @WidthCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Width LIKE ''' + @Width + '%'''
  END
  IF @WidthCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Width LIKE ''%' + @Width + ''''
  END          
  IF @WidthCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityPalettes =  ''' +@Width+ ''''
  END
  IF @WidthCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Width <>  ''' +@Width+ ''''
  END
END

  IF @Length !=''
BEGIN

  IF @LengthCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Length LIKE ''%' + @Length + '%'''
  END
  IF @LengthCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Length NOT LIKE ''%' + @Length + '%'''
  END
  IF @LengthCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Length LIKE ''' + @Length + '%'''
  END
  IF @LengthCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Length LIKE ''%' + @Length + ''''
  END          
  IF @LengthCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckCapacityPalettes =  ''' +@Length+ ''''
  END
  IF @LengthCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Length <>  ''' +@Length+ ''''
  END
END
set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			UpdatedDate,
			CreatedDate,
			TruckSizeId,
			VehicleType,
			TruckSize,
			TruckCapacityPalettes,
			TruckCapacityWeight,
			[Height],
			[Width],
			[Length],
			[IsActive] 
			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
		    [TruckSizeId],
			[UpdatedDate],
			[CreatedDate],
			(select top 1 Name from  LookUp where LookUpId=[VehicleType])VehicleType,
			[TruckSize],
			[TruckCapacityPalettes],
			[TruckCapacityWeight],
			[IsActive],
			[Height],
			[Width],
			[Length] from TruckSize
			
			where ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) +  ' ORDER BY '+@orderBy+'
  FOR XML path(''TruckSizeList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END
