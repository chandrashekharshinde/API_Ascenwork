

CREATE PROCEDURE [dbo].[SSP_AllEmailDynamicColumn_Paging]
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

		DECLARE @TableName nvarchar(100)
		DECLARE @TableNameCriteria nvarchar(100)
		DECLARE @ColumnName nvarchar(100)
		DECLARE @ColumnNameCriteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@TableName=tmp.[TableName],
			@TableNameCriteria=tmp.[TableNameCriteria],
			@ColumnName=tmp.[ColumnName],
			@ColumnNameCriteria=tmp.[ColumnNameCriteria],
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),  
			[TableName] nvarchar(100),
			[TableNameCriteria] nvarchar(100),
			[ColumnName] nvarchar(100),
			[ColumnNameCriteria] nvarchar(100),
			[UserId] bigint
		)tmp


		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'EmailDynamicColumnId' END


		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


		IF @TableName !=''
		BEGIN
		
		  IF @TableNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and t.TableName LIKE ''%' + @TableName + '%'''
		  END
		  IF @TableNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and t.TableName NOT LIKE ''%' + @TableName + '%'''
		  END
		  IF @TableNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and t.TableName LIKE ''' + @TableName + '%'''
		  END
		  IF @TableNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and t.TableName LIKE ''%' + @TableName + ''''
		  END          
		  IF @TableNameCriteria = 'eq'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and t.TableName =  ''' +@TableName+ ''''
		  END
		  IF @TableNameCriteria = 'neq'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and t.TableName <>  ''' +@TableName+ ''''
		  END
		END

		IF @ColumnName !=''
		BEGIN
		
		  IF @ColumnNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.ColumnName LIKE ''%' + @ColumnName + '%'''
		  END
		  IF @ColumnNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.ColumnName NOT LIKE ''%' + @ColumnName + '%'''
		  END
		  IF @ColumnNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.ColumnName LIKE ''' + @ColumnName + '%'''
		  END
		  IF @ColumnNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.ColumnName LIKE ''%' + @ColumnName + ''''
		  END          
		  IF @ColumnNameCriteria = 'eq'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and c.ColumnName =  ''' +@ColumnName+ ''''
		  END
		  IF @ColumnNameCriteria = 'neq'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and c.ColumnName <>  ''' +@ColumnName+ ''''
		  END
		END


		Set @sql=
				'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						[EmailDynamicColumnId],
						[EmailDynamicTableId],
						[TableName],
						[ColumnName],
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[UpdatedBy],
						[UpdatedDate]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(c.UpdatedDate, c.CreatedDate) desc) as RowNumber, 
							COUNT(c.EmailDynamicColumnId) OVER () as TotalCount,
							c.[EmailDynamicColumnId],
							c.[EmailDynamicTableId],
							t.[TableName],
							c.[ColumnName],
							c.[IsActive],
							c.[CreatedBy],
							c.[CreatedDate],
							c.[UpdatedBy],
							c.[UpdatedDate]
						FROM [EmailDynamicColumn] c 
						Join [EmailDynamicTable] t on c.EmailDynamicTableId=t.EmailDynamicTableId
						WHERE c.IsActive = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''EmailDynamicColumnList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
