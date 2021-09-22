





CREATE PROCEDURE [dbo].[SSP_GetAllPaymentSlab_Paging]
(
	@xmlDoc XML
)
AS
BEGIN
--exec [dbo].[SSP_GetAllPaymentSlab_Paging] '<Json><ServicesAction>GetAllPaymentPlanPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PlanName></PlanName><PlanNameCriteria></PlanNameCriteria><SlabName></SlabName><SlabNameCriteria></SlabNameCriteria><Amount></Amount><AmountCriteria></AmountCriteria><AmountUnitName></AmountUnitName><AmountUnitNameCriteria></AmountUnitNameCriteria><EffectiveFrom></EffectiveFrom><EffectiveFromCriteria></EffectiveFromCriteria><EffectiveTo></EffectiveTo><EffectiveToCriteria></EffectiveToCriteria><ApplicableAfterName></ApplicableAfterName><ApplicableAfterNameCriteria></ApplicableAfterNameCriteria></Json>'	
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
		DECLARE @whereClause_Activity NVARCHAR(max)

		Declare @PageSize INT
		Declare @PageIndex INT
		Declare @OrderBy NVARCHAR(100)

		DECLARE @PlanName nvarchar(100)
		DECLARE @PlanNameCriteria nvarchar(100)
		DECLARE @SlabName nvarchar(100)
		DECLARE @SlabNameCriteria nvarchar(100)
		DECLARE @Amount nvarchar(100)
		DECLARE @AmountCriteria nvarchar(100)
		DECLARE @AmountUnitName nvarchar(100)
		DECLARE @AmountUnitNameCriteria nvarchar(100)
		DECLARE @EffectiveFrom nvarchar(100)
		DECLARE @EffectiveFromCriteria nvarchar(100)
		DECLARE @EffectiveTo nvarchar(100)
		DECLARE @EffectiveToCriteria nvarchar(100)
		DECLARE @ApplicableAfterName nvarchar(100)
		DECLARE @ApplicableAfterNameCriteria nvarchar(100)

		Set  @whereClause =''
		Set  @whereClause_Activity =''

		SELECT
			@PlanName=tmp.[PlanName],
			@PlanNameCriteria=tmp.[PlanNameCriteria],
			@SlabName=tmp.[SlabName],
			@SlabNameCriteria=tmp.[SlabNameCriteria],
			@Amount=tmp.[Amount],
			@AmountCriteria=tmp.[AmountCriteria],
			@AmountUnitName=tmp.[AmountUnitName],
			@AmountUnitNameCriteria=tmp.[AmountUnitNameCriteria],
			@EffectiveFrom=tmp.[EffectiveFrom],
			@EffectiveFromCriteria=tmp.[EffectiveFromCriteria],
			@EffectiveTo=tmp.[EffectiveTo],
			@EffectiveToCriteria=tmp.[EffectiveToCriteria],
			@ApplicableAfterName=tmp.[ApplicableAfterName],
			@ApplicableAfterNameCriteria=tmp.[ApplicableAfterNameCriteria],
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
			[SlabName] nvarchar(100),
			[SlabNameCriteria] nvarchar(100),
			[Amount] nvarchar(100),
			[AmountCriteria] nvarchar(100),
			[AmountUnitName] nvarchar(100),
			[AmountUnitNameCriteria] nvarchar(100),
			[EffectiveFrom] nvarchar(100),
			[EffectiveFromCriteria] nvarchar(100),
			[EffectiveTo] nvarchar(100),
			[EffectiveToCriteria] nvarchar(100),
			[ApplicableAfterName] nvarchar(100),
			[ApplicableAfterNameCriteria] nvarchar(100)
		)tmp


		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PaymentSlabId' END


		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END
		IF(RTRIM(@whereClause_Activity) = '') BEGIN SET @whereClause_Activity = 'ws.StatusCode=ps.ApplicableAfter And ws.IsActive=1' END

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

		IF @SlabName !=''
		BEGIN
		
		  IF @SlabNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and sl.Name LIKE ''%' + @SlabName + '%'''
		  END
		  IF @SlabNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and sl.Name NOT LIKE ''%' + @SlabName + '%'''
		  END
		  IF @SlabNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and sl.Name LIKE ''' + @SlabName + '%'''
		  END
		  IF @SlabNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and sl.Name LIKE ''%' + @SlabName + ''''
		  END          
		  IF @SlabNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and sl.Name =  ''' +@SlabName+ ''''
		  END
		  IF @SlabNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and sl.Name <>  ''' +@SlabName+ ''''
		  END
		END

		IF @Amount !=''
		BEGIN
			IF @AmountCriteria = '='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(ps.Amount,0)) =  CONVERT(float,'''+@Amount+''')'
				END
			Else IF @AmountCriteria = '>'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(ps.Amount,0)) >  CONVERT(float,'''+@Amount+''')'
				END
			Else IF @AmountCriteria = '<'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(ps.Amount,0)) <  CONVERT(float,'''+@Amount+''')'
				END
		END

		IF @AmountUnitName !=''
		BEGIN
		
		  IF @AmountUnitNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ul.Name LIKE ''%' + @AmountUnitName + '%'''
		  END
		  IF @AmountUnitNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ul.Name NOT LIKE ''%' + @AmountUnitName + '%'''
		  END
		  IF @AmountUnitNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ul.Name LIKE ''' + @AmountUnitName + '%'''
		  END
		  IF @AmountUnitNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ul.Name LIKE ''%' + @AmountUnitName + ''''
		  END          
		  IF @AmountUnitNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and ul.Name =  ''' +@AmountUnitName+ ''''
		  END
		  IF @AmountUnitNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and ul.Name <>  ''' +@AmountUnitName+ ''''
		  END
		END

		IF @EffectiveFrom !=''
		BEGIN
			IF @EffectiveFromCriteria = '='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveFrom,103) = CONVERT(date,'''+@EffectiveFrom+''',103)'
				END
			Else IF @EffectiveFromCriteria = '>='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveFrom,103) > CONVERT(date,'''+@EffectiveFrom+''',103)'
				END
			Else IF @EffectiveFromCriteria = '<'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveFrom,103) < CONVERT(date,'''+@EffectiveFrom+''',103)'
				END
		END
		
		IF @EffectiveTo !=''
		BEGIN
			IF @EffectiveToCriteria = '='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveTo,103) = CONVERT(date,'''+@EffectiveTo+''',103)'
				END
			Else IF @EffectiveToCriteria = '>='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveTo,103) > CONVERT(date,'''+@EffectiveTo+''',103)'
				END
			Else IF @EffectiveToCriteria = '<'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(date,ps.EffectiveTo,103) < CONVERT(date,'''+@EffectiveTo+''',103)'
				END
		END

		IF @ApplicableAfterName !=''
		BEGIN

		  IF @ApplicableAfterNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName LIKE ''%' + @ApplicableAfterName + '%'''
		  END
		  IF @ApplicableAfterNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName NOT LIKE ''%' + @ApplicableAfterName + '%'''
		  END
		  IF @ApplicableAfterNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName LIKE ''' + @ApplicableAfterName + '%'''
		  END
		  IF @ApplicableAfterNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName LIKE ''%' + @ApplicableAfterName + ''''
		  END          
		  IF @ApplicableAfterNameCriteria = '='
		 BEGIN
		
		 SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName =  ''' +@ApplicableAfterName+ ''''
		  END
		  IF @ApplicableAfterNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause_Activity = @whereClause_Activity + ' and ws.ActivityName <>  ''' +@ApplicableAfterName+ ''''
		  END
		END


		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						[PaymentSlabId],
						[PaymentPlanId],
						[PlanName],
						[SlabId],
						[SlabName],
						[Amount],
						[AmountUnit],
						[AmountUnitName],
						[EffectiveFrom],
						[EffectiveTo],
						[ApplicableAfter],
						[ApplicableAfterName],
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[UpdatedBy],
						[UpdatedDate]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(ps.UpdatedDate, ps.CreatedDate) desc) as RowNumber, 
							COUNT(ps.PaymentSlabId) OVER () as TotalCount,
							ps.[PaymentSlabId],
							p.[PaymentPlanId],
							p.[PlanName],
							ps.[SlabId],
							sl.[Name] AS ''SlabName'',
							ps.[Amount],
							ps.[AmountUnit],
							ul.[Name] AS ''AmountUnitName'',
							ps.[EffectiveFrom],
							ps.[EffectiveTo],
							ps.[ApplicableAfter],
							(Select Top 1 ws.[ActivityName] From [WorkFlowStep] ws Where ' + @whereClause_Activity +') AS ''ApplicableAfterName'',
							ps.[IsActive],
							ps.[CreatedBy],
							ps.[CreatedDate],
							ps.[UpdatedBy],
							ps.[UpdatedDate]
						FROM [PaymentPlan] p 
						Join [PaymentSlab] ps on ps.PaymentPlanId=p.PaymentPlanId
						Join [LookUp] sl on ps.SlabId=sl.LookUpId
						Join [LookUp] ul on ps.AmountUnit=ul.LookUpId
						--Join [WorkFlowStep] ws on p.ApplicableAfter=ws.WorkFlowStepId
						WHERE ps.IsActive = 1 
						and p.IsActive=1
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''PaymentSlabList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
