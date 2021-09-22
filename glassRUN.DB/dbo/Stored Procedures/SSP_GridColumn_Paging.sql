

CREATE PROCEDURE [dbo].[SSP_GridColumn_Paging]--'<Json><ServicesAction>GetAllGridColumnPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria></Json>'
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

		DECLARE @PageName nvarchar(100) 
		DECLARE @PropertyName nvarchar(100) 
		DECLARE @PropertyType nvarchar(100) 
		DECLARE @IsControlField nvarchar(100) 
		DECLARE @ResourceKey nvarchar(100) 
		DECLARE @OnScreenDisplay nvarchar(100) 
		DECLARE @IsDetailsViewAvailable nvarchar(100) 
		DECLARE @IsSystemMandatory nvarchar(100) 
		DECLARE @Data1 nvarchar(100) 
		DECLARE @Data2 nvarchar(100) 
		DECLARE @Data3 nvarchar(100) 
		DECLARE @IsActive nvarchar(100)

		DECLARE @PageNameCriteria nvarchar(100) 
		DECLARE @PropertyNameCriteria nvarchar(100) 
		DECLARE @PropertyTypeCriteria nvarchar(100) 
		DECLARE @IsControlFieldCriteria nvarchar(100) 
		DECLARE @ResourceKeyCriteria nvarchar(100) 
		DECLARE @OnScreenDisplayCriteria nvarchar(100) 
		DECLARE @IsDetailsViewAvailableCriteria nvarchar(100) 
		DECLARE @IsSystemMandatoryCriteria nvarchar(100) 
		DECLARE @Data1Criteria nvarchar(100) 
		DECLARE @Data2Criteria nvarchar(100) 
		DECLARE @Data3Criteria nvarchar(100) 
		DECLARE @IsActiveCriteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@PageName=tmp.[PageName],
			@PropertyName=tmp.[PropertyName],
			@PropertyType=tmp.[PropertyType],
			@IsControlField=tmp.[IsControlField],
			@ResourceKey=tmp.[ResourceKey],
			@OnScreenDisplay=tmp.[OnScreenDisplay],
			@IsDetailsViewAvailable=tmp.[IsDetailsViewAvailable],
			@IsSystemMandatory=tmp.[IsSystemMandatory],
			@Data1=tmp.[Data1],
			@Data2=tmp.[Data2],
			@Data3=tmp.[Data3],
			@IsActive=tmp.[IsActive],
			@PageNameCriteria=tmp.[PageNameCriteria],
			@PropertyNameCriteria=tmp.[PropertyNameCriteria],
			@PropertyTypeCriteria=tmp.[PropertyTypeCriteria],
			@IsControlFieldCriteria=tmp.[IsControlFieldCriteria],
			@ResourceKeyCriteria=tmp.[ResourceKeyCriteria],
			@OnScreenDisplayCriteria=tmp.[OnScreenDisplayCriteria],
			@IsDetailsViewAvailableCriteria=tmp.[IsDetailsViewAvailableCriteria],
			@IsSystemMandatoryCriteria=tmp.[IsSystemMandatoryCriteria],
			@Data1Criteria=tmp.[Data1Criteria],
			@Data2Criteria=tmp.[Data2Criteria],
			@Data3Criteria=tmp.[Data3Criteria],
			@IsActiveCriteria=tmp.[IsActiveCriteria],
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),
			[PageName] nvarchar(100), 
			[PropertyName] nvarchar(100), 
			[PropertyType] nvarchar(100), 
			[IsControlField] nvarchar(100), 
			[ResourceKey] nvarchar(100), 
			[OnScreenDisplay] nvarchar(100), 
			[IsDetailsViewAvailable] nvarchar(100), 
			[IsSystemMandatory] nvarchar(100), 
			[Data1] nvarchar(100), 
			[Data2] nvarchar(100), 
			[Data3] nvarchar(100), 
			[IsActive] nvarchar(100),
			[PageNameCriteria] nvarchar(100), 
			[PropertyNameCriteria] nvarchar(100), 
			[PropertyTypeCriteria] nvarchar(100), 
			[IsControlFieldCriteria] nvarchar(100), 
			[ResourceKeyCriteria] nvarchar(100), 
			[OnScreenDisplayCriteria] nvarchar(100), 
			[IsDetailsViewAvailableCriteria] nvarchar(100), 
			[IsSystemMandatoryCriteria] nvarchar(100), 
			[Data1Criteria] nvarchar(100), 
			[Data2Criteria] nvarchar(100), 
			[Data3Criteria] nvarchar(100), 
			[IsActiveCriteria] nvarchar(100)
		)tmp

		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'GridColumnId' END

		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

		--IF @PageName !=''
		--BEGIN
		
		--  IF @PageNameCriteria = 'contains'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName LIKE ''%' + @PageName + '%'''
		--  END
		--  IF @PageNameCriteria = 'doesnotcontain'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName NOT LIKE ''%' + @PageName + '%'''
		--  END
		--  IF @PageNameCriteria = 'startswith'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName LIKE ''' + @PageName + '%'''
		--  END
		--  IF @PageNameCriteria = 'endswith'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName LIKE ''%' + @PageName + ''''
		--  END          
		--  IF @PageNameCriteria = '='
		-- BEGIN
		
		-- SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName =  ''' +@PageName+ ''''
		--  END
		--  IF @PageNameCriteria = '<>'
		-- BEGIN
		
		-- SET @whereClause = @whereClause + ' and p.PageName +'' - ''+ ControlName <>  ''' +@PageName+ ''''
		--  END
		--END

		IF @PropertyName !=''
		BEGIN
		
		  IF @PropertyNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyName LIKE ''%' + @PropertyName + '%'''
		  END
		  IF @PropertyNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyName NOT LIKE ''%' + @PropertyName + '%'''
		  END
		  IF @PropertyNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyName LIKE ''' + @PropertyName + '%'''
		  END
		  IF @PropertyNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyName LIKE ''%' + @PropertyName + ''''
		  END          
		  IF @PropertyNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.PropertyName =  ''' +@PropertyName+ ''''
		  END
		  IF @PropertyNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and PropertyName <>  ''' +@PropertyName+ ''''
		  END
		END

		IF @PropertyType !=''
		BEGIN
		
		  IF @PropertyTypeCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyType LIKE ''%' + @PropertyType + '%'''
		  END
		  IF @PropertyTypeCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyType NOT LIKE ''%' + @PropertyType + '%'''
		  END
		  IF @PropertyTypeCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyType LIKE ''' + @PropertyType + '%'''
		  END
		  IF @PropertyTypeCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.PropertyType LIKE ''%' + @PropertyType + ''''
		  END          
		  IF @PropertyTypeCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.PropertyType =  ''' +@PropertyType+ ''''
		  END
		  IF @PropertyTypeCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.PropertyType <>  ''' +@PropertyType+ ''''
		  END
		END

		IF @ResourceKey !=''
		BEGIN
		
		  IF @ResourceKeyCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.ResourceKey LIKE ''%' + @ResourceKey + '%'''
		  END
		  IF @ResourceKeyCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.ResourceKey NOT LIKE ''%' + @ResourceKey + '%'''
		  END
		  IF @ResourceKeyCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.ResourceKey LIKE ''' + @ResourceKey + '%'''
		  END
		  IF @ResourceKeyCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.ResourceKey LIKE ''%' + @ResourceKey + ''''
		  END          
		  IF @ResourceKeyCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.ResourceKey =  ''' +@ResourceKey+ ''''
		  END
		  IF @ResourceKeyCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.ResourceKey <>  ''' +@ResourceKey+ ''''
		  END
		END

		print @whereClause

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						PageName,
						GridColumnId,
						ObjectId,
						PropertyName,
						PropertyType,
						IsControlField,
						ResourceKey,
						OnScreenDisplay,
						IsDetailsViewAvailable,
						IsSystemMandatory,
						Data1,
						Data2,
						Data3,
						IsActive,
						CreatedBy,
						CreatedDate,
						ModifiedBy,
						ModifiedDate
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY GridColumnId desc) as RowNumber, 
							COUNT(GridColumnId) OVER () as TotalCount,
							p.PageName +'' - ''+ ControlName as PageName,
							g.GridColumnId,
							g.ObjectId,
							g.PropertyName,
							g.PropertyType,
							g.IsControlField,
							g.ResourceKey,
							g.OnScreenDisplay,
							g.IsDetailsViewAvailable,
							g.IsSystemMandatory,
							g.Data1,
							g.Data2,
							g.Data3,
							g.IsActive,
							g.CreatedBy,
							g.CreatedDate,
							g.ModifiedBy,
							g.ModifiedDate
						FROM [GridColumn] g
						LEFT JOIN [PageControl] pc on pc.PageControlId = ObjectId
						JOIN Pages p on p.PageId = pc.PageId
						WHERE 1 = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''GridColumnList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END