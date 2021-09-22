CREATE PROCEDURE [dbo].[SSP_GetAllPaymentPlan_Paging]
(
	@xmlDoc XML
)
AS
BEGIN
--exec [dbo].[SSP_GetAllPaymentPlan_Paging] '<Json><ServicesAction>GetAllPaymentPlanPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PlanName></PlanName><PlanNameCriteria></PlanNameCriteria><SlabName></SlabName><SlabNameCriteria></SlabNameCriteria><Amount></Amount><AmountCriteria></AmountCriteria><AmountUnitName></AmountUnitName><AmountUnitNameCriteria></AmountUnitNameCriteria><EffectiveFrom></EffectiveFrom><EffectiveFromCriteria></EffectiveFromCriteria><EffectiveTo></EffectiveTo><EffectiveToCriteria></EffectiveToCriteria><ApplicableAfterName></ApplicableAfterName><ApplicableAfterNameCriteria></ApplicableAfterNameCriteria></Json>'	
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

		DECLARE @PlanName nvarchar(100)
		DECLARE @PlanNameCriteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@PlanName=tmp.[PlanName],
			@PlanNameCriteria=tmp.[PlanNameCriteria],
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),  
			[PlanName] nvarchar(100),
			[PlanNameCriteria] nvarchar(100)
		)tmp

		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PaymentPlanId' END

		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

		IF @PlanName !=''
		BEGIN
		
		  IF @PlanNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PlanName LIKE ''%' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PlanName NOT LIKE ''%' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PlanName LIKE ''' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and PlanName LIKE ''%' + @PlanName + ''''
		  END          
		  IF @PlanNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and PlanName =  ''' +@PlanName+ ''''
		  END
		  IF @PlanNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and PlanName <>  ''' +@PlanName+ ''''
		  END
		END

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						[PaymentPlanId],
						[PlanName],
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[UpdatedBy],
						[UpdatedDate]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate, CreatedDate) desc) as RowNumber, 
							COUNT(PaymentPlanId) OVER () as TotalCount,
							[PaymentPlanId],
							[PlanName],
							[IsActive],
							[CreatedBy],
							[CreatedDate],
							[UpdatedBy],
							[UpdatedDate]
						FROM [PaymentPlan] 
						WHERE IsActive = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''PaymentPlanList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
