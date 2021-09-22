CREATE PROCEDURE [dbo].[SSP_GetAllPaymentPlanTransporterMapping_Paging]
(
	@xmlDoc XML
)
AS
BEGIN
--exec [dbo].[SSP_GetAllPaymentPlanTransporterMapping_Paging] '<Json><ServicesAction>GetAllPaymentPlanTransporterMapping_Paging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PlanName></PlanName><PlanNameCriteria></PlanNameCriteria><CompanyName></CompanyName><CompanyNameCriteria></CompanyNameCriteria></Json>'	
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
		DECLARE @CompanyName nvarchar(100)
		DECLARE @CompanyNameCriteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@PlanName=tmp.[PlanName],
			@PlanNameCriteria=tmp.[PlanNameCriteria],
			@CompanyName=tmp.[CompanyName],
			@CompanyNameCriteria=tmp.[CompanyNameCriteria],
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
			[PlanNameCriteria] nvarchar(100),
			[CompanyName] nvarchar(100),
			[CompanyNameCriteria] nvarchar(100)
		)tmp


		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PaymentPlanTransporterMappingId' END


		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


		IF @PlanName !=''
		BEGIN
		
		  IF @PlanNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and p.PlanName LIKE ''%' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and p.PlanName NOT LIKE ''%' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and p.PlanName LIKE ''' + @PlanName + '%'''
		  END
		  IF @PlanNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and p.PlanName LIKE ''%' + @PlanName + ''''
		  END          
		  IF @PlanNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and p.PlanName =  ''' +@PlanName+ ''''
		  END
		  IF @PlanNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and p.PlanName <>  ''' +@PlanName+ ''''
		  END
		END

		IF @CompanyName !=''
		BEGIN
		
		  IF @CompanyNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CompanyName + '%'''
		  END
		  IF @CompanyNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.CompanyName NOT LIKE ''%' + @CompanyName + '%'''
		  END
		  IF @CompanyNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''' + @CompanyName + '%'''
		  END
		  IF @CompanyNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CompanyName + ''''
		  END          
		  IF @CompanyNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and c.CompanyName =  ''' +@CompanyName+ ''''
		  END
		  IF @CompanyNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and c.CompanyName <>  ''' +@CompanyName+ ''''
		  END
		END
		

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						[RowNumber],
						[TotalCount],
						[PaymentPlanTransporterMappingId],
						[PaymentPlanId],
						[PlanName],
						[CompanyId],
						[CompanyName]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(p.UpdatedDate, p.CreatedDate) desc) as RowNumber, 
							COUNT(ptm.PaymentPlanTransporterMappingId) OVER () as TotalCount,
							ptm.[PaymentPlanTransporterMappingId],
							p.[PaymentPlanId],
							p.[PlanName],
							c.[CompanyId],
							c.[CompanyName]
						FROM [PaymentPlanTransporterMapping] ptm
						Join [PaymentPlan] p on ptm.PaymentPlanId=p.PaymentPlanId
						Join [Company] c on ptm.TransporterId=c.CompanyId And c.CompanyType=28	--transporter
						WHERE ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''PaymentPlanTransporterMappingList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
