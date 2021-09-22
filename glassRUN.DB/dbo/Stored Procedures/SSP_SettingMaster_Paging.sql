

CREATE PROCEDURE [dbo].[SSP_SettingMaster_Paging] --'<Json><ServicesAction>GetAllSettingMasterPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria></Json>'
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

		DECLARE @SettingParameter nvarchar(100) 
		DECLARE @SettingValue nvarchar(100) 
		DECLARE @Description nvarchar(100) 
		DECLARE @IsActive nvarchar(100)

		DECLARE @SettingParameterCriteria nvarchar(100) 
		DECLARE @SettingValueCriteria nvarchar(100) 
		DECLARE @DescriptionCriteria nvarchar(100) 
		DECLARE @IsActiveCriteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@SettingParameter=tmp.[SettingParameter],
			@SettingValue=tmp.[SettingValue],
			@Description=tmp.[Description],
			@IsActive=tmp.[IsActive],
			@SettingParameterCriteria=tmp.[SettingParameterCriteria],
			@SettingValueCriteria=tmp.[SettingValueCriteria],
			@DescriptionCriteria=tmp.[DescriptionCriteria],
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
			[SettingParameter] nvarchar(100), 
			[SettingValue] nvarchar(100), 
			[Description] nvarchar(100), 
			[IsActive] nvarchar(100),
			[SettingParameterCriteria] nvarchar(100), 
			[SettingValueCriteria] nvarchar(100), 
			[DescriptionCriteria] nvarchar(100), 
			[IsActiveCriteria] nvarchar(100)
		)tmp

		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'SettingMasterId' END

		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

		IF @SettingParameter !=''
		BEGIN
		
		  IF @SettingParameterCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingParameter LIKE ''%' + @SettingParameter + '%'''
		  END
		  IF @SettingParameterCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingParameter NOT LIKE ''%' + @SettingParameter + '%'''
		  END
		  IF @SettingParameterCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingParameter LIKE ''' + @SettingParameter + '%'''
		  END
		  IF @SettingParameterCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingParameter LIKE ''%' + @SettingParameter + ''''
		  END          
		  IF @SettingParameterCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.SettingParameter =  ''' +@SettingParameter+ ''''
		  END
		  IF @SettingParameterCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and SettingParameter <>  ''' +@SettingParameter+ ''''
		  END
		END

		IF @SettingValue !=''
		BEGIN
		
		  IF @SettingValueCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingValue LIKE ''%' + @SettingValue + '%'''
		  END
		  IF @SettingValueCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingValue NOT LIKE ''%' + @SettingValue + '%'''
		  END
		  IF @SettingValueCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingValue LIKE ''' + @SettingValue + '%'''
		  END
		  IF @SettingValueCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.SettingValue LIKE ''%' + @SettingValue + ''''
		  END          
		  IF @SettingValueCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.SettingValue =  ''' +@SettingValue+ ''''
		  END
		  IF @SettingValueCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.SettingValue <>  ''' +@SettingValue+ ''''
		  END
		END

		IF @Description !=''
		BEGIN
		
		  IF @DescriptionCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.Description LIKE ''%' + @Description + '%'''
		  END
		  IF @DescriptionCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.Description NOT LIKE ''%' + @Description + '%'''
		  END
		  IF @DescriptionCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.Description LIKE ''' + @Description + '%'''
		  END
		  IF @DescriptionCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and g.Description LIKE ''%' + @Description + ''''
		  END          
		  IF @DescriptionCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.Description =  ''' +@Description+ ''''
		  END
		  IF @DescriptionCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and g.Description <>  ''' +@Description+ ''''
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
						SettingMasterId,
						SettingParameter,
						SettingValue,
						Description,
						IsActive,
						CreatedBy,
						CreatedDate,
						UpdatedBy,
						UpdatedDate,
						PageId,
						PageName,
						ControlType,
						PossibleValues
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY SettingMasterId desc) as RowNumber, 
							COUNT(SettingMasterId) OVER () as TotalCount,
							g.SettingMasterId,
							g.SettingParameter,
							g.SettingValue,
							g.Description,
							Case When g.IsActive=1 then ''Yes'' else ''NO'' end as IsActive,
							g.CreatedBy,
							g.CreatedDate,
							(select top 1 l.Name from login l where l.loginID=g.UpdatedBy)UpdatedBy,
							g.UpdatedDate,
							p.PageId,
						    ISNULL(p.PageName,''Global'') as PageName,
							isnull(ControlType,0)ControlType,
							isnull(PossibleValues,0)PossibleValues
						FROM [SettingMaster] g left join Pages p on g.PageName=p.PageName
						WHERE 1 = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''SettingMasterList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END