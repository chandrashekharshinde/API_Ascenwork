





CREATE PROCEDURE [dbo].[SSP_GetAllFinancePartner_Paging]-- '<Json><ServicesAction>GetAllFinancePartner_Paging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerName></FinancerName><FinancerNameCriteria></FinancerNameCriteria><AddressLine1></AddressLine1><AddressLine1Criteria></AddressLine1Criteria><AddressLine2></AddressLine2><AddressLine2Criteria></AddressLine2Criteria><AddressLine3Criteria></AddressLine3Criteria><AddressLine3></AddressLine3></Json>'
(
	@xmlDoc XML
)
AS
BEGIN
	
	-- exec [dbo].[SSP_GetAllTransportVehicle_Paging] '<Json><ServicesAction>GetAllPaymentPlanPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PlanName></PlanName><PlanNameCriteria></PlanNameCriteria><SlabName></SlabName><SlabNameCriteria></SlabNameCriteria><Amount></Amount><AmountCriteria></AmountCriteria><AmountUnitName></AmountUnitName><AmountUnitNameCriteria></AmountUnitNameCriteria><EffectiveFrom></EffectiveFrom><EffectiveFromCriteria></EffectiveFromCriteria><EffectiveTo></EffectiveTo><EffectiveToCriteria></EffectiveToCriteria><ApplicableAfterName></ApplicableAfterName><ApplicableAfterNameCriteria></ApplicableAfterNameCriteria></Json>'	
	
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
		DECLARE @whereClause nvarchar(4000)

		Declare @PageSize INT
		Declare @PageIndex INT
		Declare @OrderBy NVARCHAR(100)

		DECLARE @FinancerName nvarchar(100)
		DECLARE @FinancerNameCriteria nvarchar(100)
		DECLARE @AddressLine1 nvarchar(100)
		DECLARE @AddressLine1Criteria nvarchar(100)
		DECLARE @AddressLine2 nvarchar(100)
		DECLARE @AddressLine2Criteria nvarchar(100)
		

		Set  @whereClause =''

		SELECT
			@FinancerName=tmp.[FinancerName],
			@FinancerNameCriteria=tmp.[FinancerNameCriteria],
			@AddressLine1=tmp.[AddressLine1],
			@AddressLine1Criteria=tmp.[AddressLine1Criteria],
			@AddressLine2=tmp.[AddressLine2],
			@AddressLine2Criteria=tmp.[AddressLine2Criteria],			
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),  
			[FinancerName] nvarchar(100),
			[FinancerNameCriteria] nvarchar(100),
			[AddressLine1] nvarchar(100),
			[AddressLine1Criteria] nvarchar(100),
			[AddressLine2] nvarchar(100),
			[AddressLine2Criteria] nvarchar(100)
			
		)tmp


		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'FinancePatnerId' END


		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


		IF @FinancerName !=''
		BEGIN
		
			IF @FinancerNameCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName LIKE ''%' + @FinancerName + '%'''
			END
			IF @FinancerNameCriteria = 'notcontains'
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName NOT LIKE ''%' + @FinancerName + '%'''
			END
			IF @FinancerNameCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName LIKE ''' + @FinancerName + '%'''
			END
			IF @FinancerNameCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName LIKE ''%' + @FinancerName + ''''
			END          
			IF @FinancerNameCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName =  ''' +@FinancerName+ ''''
			END
			IF @FinancerNameCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and FinancerName <>  ''' +@FinancerName+ ''''
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
			IF @AddressLine1Criteria = '<>'
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
			IF @AddressLine2Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and AddressLine2 <>  ''' +@AddressLine2+ ''''
			END
		END

		


		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array],
						[RowNumber], 
						[TotalCount],
						FinancePatnerId,
						[FinancerName], 
						[AddressLine1],
						[AddressLine2],
						[AddressLine3],
						[City],
						[State],						
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate, CreatedDate) desc) as RowNumber, 
							COUNT([FinancePatnerId]) OVER () as TotalCount,
							[FinancePatnerId],
							[FinancerName], 
						[AddressLine1],
						[AddressLine2],
						[AddressLine3],
						[City],
						[State],						
						[IsActive],
						[CreatedBy],
						[CreatedDate],
						[ModifiedBy],
						[ModifiedDate]
						FROM [dbo].[FinancePatner] 
						
						WHERE IsActive = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''FinancePatnerList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END