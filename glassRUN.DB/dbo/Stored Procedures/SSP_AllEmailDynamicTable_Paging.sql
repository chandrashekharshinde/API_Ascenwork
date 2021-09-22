

CREATE PROCEDURE [dbo].[SSP_AllEmailDynamicTable_Paging]
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

		Set  @whereClause =''

		SELECT
			@TableName=tmp.[TableName],
			@TableNameCriteria=tmp.[TableNameCriteria],
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
		

		Set @sql=
				'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						[EmailDynamicTableId],
						[TableName],
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[UpdatedBy],
						[UpdatedDate]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(t.UpdatedDate, t.CreatedDate) desc) as RowNumber, 
							COUNT(t.EmailDynamicTableId) OVER () as TotalCount,
							t.[EmailDynamicTableId],
							t.[TableName],
							t.[IsActive],
							t.[CreatedBy],
							t.[CreatedDate],
							t.[UpdatedBy],
							t.[UpdatedDate]
						FROM [EmailDynamicTable] t
						WHERE t.IsActive = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''EmailDynamicTableList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
