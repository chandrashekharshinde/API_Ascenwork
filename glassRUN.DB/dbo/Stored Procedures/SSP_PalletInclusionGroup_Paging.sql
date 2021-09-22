
CREATE PROCEDURE [dbo].[SSP_PalletInclusionGroup_Paging] --'<Json><ServicesAction>GetAllPalletInclusionGroupPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PalletInclusionGroupCriteria></PalletInclusionGroupCriteria><PalletInclusionGroup></PalletInclusionGroup><TruckSizeCriteria></TruckSizeCriteria><TruckSize></TruckSize><LocationNameCriteria></LocationNameCriteria><LocationName></LocationName><TruckCapacityPalettes>14</TruckCapacityPalettes><TruckCapacityPalettesCriteria>contains</TruckCapacityPalettesCriteria><TruckCapacityWeight></TruckCapacityWeight><TruckCapacityWeightCriteria></TruckCapacityWeightCriteria></Json>'
(
	@xmlDoc XML
)
AS
BEGIN
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @sqlTotalCount nvarchar(4000)
		Declare @sql nvarchar(4000)
		DECLARE @whereClause NVARCHAR(max)

		Declare @PageSize INT
		Declare @PageIndex INT
		Declare @OrderBy NVARCHAR(100)

		DECLARE @PalletInclusionGroupCriteria nvarchar(100) 
		DECLARE @PalletInclusionGroup nvarchar(100) 

		DECLARE @TruckSizeCriteria nvarchar(100) 
		DECLARE @TruckSize nvarchar(100) 

		DECLARE @LocationNameCriteria nvarchar(100) 
		DECLARE @LocationName nvarchar(100) 
		DEclare @IsExportToExcel bit = 0
		Declare @PaginationClause nvarchar(max) = ''

		DECLARE @TruckCapacityPalettes nvarchar(100) 
		DECLARE @TruckCapacityPalettesCriteria nvarchar(100) 

		DECLARE @TruckCapacityWeight nvarchar(100) 
		DECLARE @TruckCapacityWeightCriteria nvarchar(100) 
		Set  @whereClause =''

		SELECT
		@PalletInclusionGroupCriteria=tmp.[PalletInclusionGroupCriteria],
		@PalletInclusionGroup=tmp.[PalletInclusionGroup],
		@TruckSizeCriteria=tmp.[TruckSizeCriteria],
		@TruckSize=tmp.[TruckSize],
		@LocationNameCriteria=tmp.[LocationNameCriteria],
		@LocationName=tmp.[LocationName],
		@TruckCapacityPalettes = tmp.[TruckCapacityPalettes],
		@TruckCapacityPalettesCriteria = tmp.[TruckCapacityPalettesCriteria],
		@TruckCapacityWeight = tmp.[TruckCapacityWeight],
		@TruckCapacityWeightCriteria = tmp.[TruckCapacityWeightCriteria],
		@PageSize = tmp.[PageSize],
		@PageIndex = tmp.[PageIndex],
		@OrderBy = tmp.[OrderBy],
		@IsExportToExcel = tmp.[IsExportToExcel]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),
			[PalletInclusionGroupCriteria] nvarchar(2000),
			[PalletInclusionGroup] nvarchar(2000),
			[TruckSizeCriteria] nvarchar(2000),
			[TruckSize] nvarchar(2000),
			[TruckCapacityPalettes] nvarchar(2000),
			[TruckCapacityPalettesCriteria] nvarchar(2000),
			[TruckCapacityWeight] nvarchar(2000),
			[TruckCapacityWeightCriteria] nvarchar(2000),
			[IsExportToExcel] bit,
			[LocationNameCriteria] nvarchar(2000),
			[LocationName] nvarchar(2000)
		
		)tmp

		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'LocationName' END

		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

		

		IF @PalletInclusionGroup !=''
		BEGIN
		
		  IF @PalletInclusionGroupCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PalletInclusionGroup LIKE ''%' + @PalletInclusionGroup + '%'''
		  END
		  IF @PalletInclusionGroupCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PalletInclusionGroup NOT LIKE ''%' + @PalletInclusionGroup + '%'''
		  END
		  IF @PalletInclusionGroupCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PalletInclusionGroup LIKE ''' + @PalletInclusionGroup + '%'''
		  END
		  IF @PalletInclusionGroupCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PalletInclusionGroup LIKE ''%' + @PalletInclusionGroup + ''''
		  END          
		  IF @PalletInclusionGroupCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and PalletInclusionGroup =  ''' +@PalletInclusionGroup+ ''''
		  END
		  IF @PalletInclusionGroupCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and PalletInclusionGroup <>  ''' +@PalletInclusionGroup+ ''''
		  END
		END


		IF @TruckSize !=''
		BEGIN
		
		  IF @TruckSizeCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + '%'''
		  END
		  IF @TruckSizeCriteria = 'doesnotcontain'
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
		  IF @TruckSizeCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckSize =  ''' +@TruckSize+ ''''
		  END
		  IF @TruckSizeCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckSize <>  ''' +@TruckSize+ ''''
		  END
		END
	

	IF @LocationName !=''
		BEGIN
		
		  IF @LocationNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and LocationName LIKE ''%' + @LocationName + '%'''
		  END
		  IF @LocationNameCriteria = 'doesnotcontain'
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
		  IF @LocationNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and LocationName <>  ''' +@LocationName+ ''''
		  END
		END

		IF @TruckCapacityWeight !=''
		BEGIN
		
		  IF @TruckCapacityWeightCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and TruckCapacityWeight LIKE ''%' + @TruckCapacityWeight + '%'''
		  END
		  IF @TruckCapacityWeightCriteria = 'doesnotcontain'
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
		  IF @TruckCapacityWeightCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckCapacityWeight =  ''' +@TruckCapacityWeight+ ''''
		  END
		  IF @TruckCapacityWeightCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckCapacityWeight <>  ''' +@TruckCapacityWeight+ ''''
		  END
		END

		IF @TruckCapacityPalettes !=''
		BEGIN
		
		  IF @TruckCapacityPalettesCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and TruckCapacityPalettes LIKE ''%' + @TruckCapacityPalettes + '%'''
		  END
		  IF @TruckCapacityPalettesCriteria = 'doesnotcontain'
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
		  IF @TruckCapacityPalettesCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckCapacityPalettes =  ''' +@TruckCapacityPalettes+ ''''
		  END
		  IF @TruckCapacityPalettesCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and TruckCapacityPalettes <>  ''' +@TruckCapacityPalettes+ ''''
		  END
		END

		print @whereClause

If @IsExportToExcel != '0'
	Begin			
		SET @PaginationClause = '1=1'
	End
Else
	Begin
		SET @PaginationClause = [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)
	ENd

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						DestinationId,
						PalletInclusionGroup,
						TruckSizeId,
						TruckSize,
						TruckCapacityPalettes,
						TruckCapacityWeight,
						LocationName
					From (
						SELECT 
						ROW_NUMBER() OVER (ORDER BY LocationName asc) as RowNumber, 
						COUNT(LocationName) OVER () as TotalCount
						, * from 
						(SELECT Distinct  r.DestinationId
						,Isnull(r.PalletInclusionGroup,''0'') as PalletInclusionGroup,
						t.TruckSizeId
						,t.TruckSize
						,t.TruckCapacityPalettes
						,t.TruckCapacityWeight
						,dl.LocationName+'' (''+dl.LocationCode+'')'' as LocationName
						from [Route] r join TruckSize t on t.TruckSizeId=r.TruckSizeId 
						join [Location] dl on dl.LocationId=r.DestinationId
						where isnull(r.PalletInclusionGroup,''0'') !=''0'' and r.PalletInclusionGroup !='''')as PalletInclusionGroup Where 1=1
						and ' + @whereClause +'
						) as tmp  where '+ @PaginationClause + '
				FOR XML path(''PalletInclusionGroupList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END