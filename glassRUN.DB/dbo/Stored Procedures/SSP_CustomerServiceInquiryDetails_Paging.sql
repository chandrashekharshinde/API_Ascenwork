
CREATE PROCEDURE [dbo].[SSP_CustomerServiceInquiryDetails_Paging] --'<Json><ServicesAction>LoadCustomerServiceEnquiryDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><EnquiryEndDate></EnquiryEndDate><EnquiryEndDateCriteria></EnquiryEndDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><RequestEndDate></RequestEndDate><RequestEndDateCriteria></RequestEndDateCriteria><PickDateTime></PickDateTime><PickDateTimeCriteria></PickDateTimeCriteria><PickEndDateTime></PickEndDateTime><PickEndDateTimeCriteria></PickEndDateTimeCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><PromisedEndDate></PromisedEndDate><PromisedEndDateCriteria></PromisedEndDateCriteria><Status>Draft,Enquiry Approved</Status><StatusCriteria>in</StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><CurrentState>1,7</CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>4</RoleMasterId><LoginId>793</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><SONumber></SONumber><SupplierName></SupplierName><SupplierCode></SupplierCode><PONumber></PONumber><EnquiryType></EnquiryType><SoldToName></SoldToName><ShipToCode></ShipToCode><CollectionLocationName></CollectionLocationName><CollectionLocationCode></CollectionLocationCode><ShipToName></ShipToName><TruckSize></TruckSize><SONumberCriteria></SONumberCriteria><SupplierNameCriteria></SupplierNameCriteria><SupplierCodeCriteria></SupplierCodeCriteria><PONumberCriteria></PONumberCriteria><EnquiryTypeCriteria></EnquiryTypeCriteria><SoldToNameCriteria></SoldToNameCriteria><ShipToCodeCriteria></ShipToCodeCriteria><CollectionLocationNameCriteria></CollectionLocationNameCriteria><CollectionLocationCodeCriteria></CollectionLocationCodeCriteria><ShipToNameCriteria></ShipToNameCriteria><TruckSizeCriteria></TruckSizeCriteria><PageName>SalesAdminApproval</PageName><PageControlName>Enquiry</PageControlName><CarrierName></CarrierName><CarrierNameCriteria></CarrierNameCriteria><ShortName></ShortName><ShortNameCriteria></ShortNameCriteria><RPM></RPM><RPMCriteria></RPMCriteria></Json>'
	
	(@xmlDoc XML)
AS
BEGIN
	DECLARE @sqlTotalCount NVARCHAR(max)
	DECLARE @sql NVARCHAR(max)
	DECLARE @sql1 NVARCHAR(max)
	DECLARE @intPointer INT;
	DECLARE @whereClause NVARCHAR(max)
	DECLARE @whereClauseIcon NVARCHAR(max)
	DECLARE @roleId BIGINT
	DECLARE @PageSize INT
	DECLARE @PageIndex INT
	DECLARE @OrderByClause NVARCHAR(500)
	DECLARE @OrderBy NVARCHAR(100)
	DECLARE @OrderByCriteria NVARCHAR(100)
	DECLARE @EnquiryAutoNumber NVARCHAR(150)
	DECLARE @EnquiryAutoNumberCriteria NVARCHAR(50)
	DECLARE @BranchPlant NVARCHAR(150)
	DECLARE @BranchPlantCriteria NVARCHAR(50)
	DECLARE @Gratis NVARCHAR(150)
	DECLARE @GratisCriteria NVARCHAR(50)
	DECLARE @DeliveryLocation NVARCHAR(150)
	DECLARE @DeliveryLocationCriteria NVARCHAR(50)
	DECLARE @Status NVARCHAR(150)
	DECLARE @StatusCriteria NVARCHAR(50)
	DECLARE @EnquiryDate NVARCHAR(150)
	DECLARE @EnquiryDateCriteria NVARCHAR(50)

	
	Declare @AndOrCondition nvarchar(10)


	DECLARE @EnquiryEndDate NVARCHAR(150)
	DECLARE @EnquiryEndDateCriteria NVARCHAR(50)

	DECLARE @RequestDate NVARCHAR(150)
	DECLARE @RequestDateCriteria NVARCHAR(50)

	DECLARE @RequestEndDate NVARCHAR(150)
	DECLARE @RequestEndDateCriteria NVARCHAR(50)

	DECLARE @PromisedDate NVARCHAR(150)
	DECLARE @PromisedDateCriteria NVARCHAR(50)

	DECLARE @PromisedEndDate NVARCHAR(150)
	DECLARE @PromisedEndDateCriteria NVARCHAR(50)
	
	DECLARE @PickDateTime NVARCHAR(150)
	DECLARE @PickDateTimeCriteria NVARCHAR(50)

	DECLARE @PickEndDateTime NVARCHAR(150)
	DECLARE @PickEndDateTimeCriteria NVARCHAR(50)

	DECLARE @SoldToCode NVARCHAR(150)
	DECLARE @SoldToCodeCriteria NVARCHAR(50)
	DECLARE @CompanyNameValue NVARCHAR(150)
	DECLARE @CompanyNameValueCriteria NVARCHAR(50)
	DECLARE @DeliveryLocationName NVARCHAR(150)
	DECLARE @DeliveryLocationNameCriteria NVARCHAR(50)
	DECLARE @Area NVARCHAR(150)
	DECLARE @AreaCriteria NVARCHAR(50)
	DECLARE @TotalPrice NVARCHAR(150)
	DECLARE @TotalPriceCriteria NVARCHAR(50)
	DECLARE @Empties NVARCHAR(150)
	DECLARE @EmptiesCriteria NVARCHAR(50)
	DECLARE @ReceivedCapacityPalates NVARCHAR(150)
	DECLARE @ReceivedCapacityPalatesCriteria NVARCHAR(50)
	DECLARE @IsAvailableStock NVARCHAR(150)
	DECLARE @AvailableStockCriteria NVARCHAR(50)
	DECLARE @AvailableCredit NVARCHAR(150)
	DECLARE @AvailableCreditCriteria NVARCHAR(50)
	DECLARE @SONumber NVARCHAR(150)
	DECLARE @SupplierName NVARCHAR(150)
	DECLARE @SupplierCode NVARCHAR(150)
	DECLARE @PONumber NVARCHAR(150)
	DECLARE @EnquiryType NVARCHAR(150)
	DECLARE @SoldToName NVARCHAR(150)
	DECLARE @ShipToCode NVARCHAR(150)
	DECLARE @CollectionLocationName NVARCHAR(150)
	DECLARE @CollectionLocationCode NVARCHAR(150)
	DECLARE @ShipToName NVARCHAR(150)
	DECLARE @TruckSize NVARCHAR(150)
	DECLARE @SONumberCriteria NVARCHAR(150)
	DECLARE @SupplierNameCriteria NVARCHAR(150)
	DECLARE @SupplierCodeCriteria NVARCHAR(150)
	DECLARE @PONumberCriteria NVARCHAR(150)
	DECLARE @EnquiryTypeCriteria NVARCHAR(150)
	DECLARE @SoldToNameCriteria NVARCHAR(150)
	DECLARE @ShipToCodeCriteria NVARCHAR(150)
	DECLARE @CollectionLocationNameCriteria NVARCHAR(150)
	DECLARE @CollectionLocationCodeCriteria NVARCHAR(150)
	DECLARE @ShipToNameCriteria NVARCHAR(150)
	DECLARE @TruckSizeCriteria NVARCHAR(150)
	DECLARE @ProductCode NVARCHAR(max)
	DECLARE @ProductSearchCriteria NVARCHAR(100)
	DECLARE @LoginId BIGINT
	DECLARE @CultureId BIGINT
	DECLARE @IsExportToExcel NVARCHAR(2) = '0'
	DECLARE @PaginationClause NVARCHAR(max) 

	Declare @PageName NVARCHAR(150)
declare @PageControlName     NVARCHAR(150)

	DECLARE @ShortName NVARCHAR(150)
	DECLARE @ShortNameCriteria NVARCHAR(150)

		DECLARE @RPM NVARCHAR(150)
	DECLARE @RPMCriteria NVARCHAR(150)

DECLARE @CarrierName NVARCHAR(150)
	DECLARE @CarrierNameCriteria NVARCHAR(150)

	SET @PaginationClause = ''
	SET @whereClause = ''
	SET @whereClauseIcon = ''

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT @EnquiryAutoNumber = tmp.[EnquiryAutoNumber]
		,@EnquiryAutoNumberCriteria = tmp.[EnquiryAutoNumberCriteria]
		,@BranchPlant = tmp.[BranchPlant]
		,@BranchPlantCriteria = tmp.[BranchPlantCriteria]
		,@DeliveryLocation = tmp.[DeliveryLocation]
		,@DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria]
		,@Gratis = tmp.[Gratis]
		,@GratisCriteria = tmp.[GratisCriteria]
		,@EnquiryDate = tmp.[EnquiryDate]
		,@EnquiryDateCriteria = tmp.[EnquiryDateCriteria]

		,@EnquiryEndDate = tmp.[EnquiryEndDate]
		,@EnquiryEndDateCriteria = tmp.[EnquiryEndDateCriteria]
		,@CompanyNameValue = tmp.[CompanyNameValue]
		,@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria]
		,@DeliveryLocationName = tmp.[DeliveryLocationName]
		,@DeliveryLocationNameCriteria = tmp.[DeliveryLocationNameCriteria]
		,@Area = tmp.[Area]
		,@AreaCriteria = tmp.[AreaCriteria]

		,@RequestDate = tmp.[RequestDate]
		,@RequestDateCriteria = tmp.[RequestDateCriteria]

		,@RPM = tmp.[RPM]
		,@RPMCriteria = tmp.[RPMCriteria]


		,@RequestEndDate = tmp.[RequestEndDate]
		,@RequestEndDateCriteria = tmp.[RequestEndDateCriteria]

		,@PromisedDate = tmp.[PromisedDate]
		,@PromisedDateCriteria = tmp.[PromisedDateCriteria]

		,@PromisedEndDate = tmp.[PromisedEndDate]
		,@PromisedEndDateCriteria = tmp.[PromisedEndDateCriteria]

		,@PickDateTime = tmp.[PickDateTime]
		,@PickDateTimeCriteria = tmp.[PickDateTimeCriteria]
		,@PickEndDateTime = tmp.[PickEndDateTime]
		,@PickEndDateTimeCriteria = tmp.[PickEndDateTimeCriteria]

			,@CarrierName = tmp.[CarrierName]
		,@CarrierNameCriteria = tmp.[CarrierNameCriteria]

		,@Status = tmp.[Status]
		,@StatusCriteria = tmp.[StatusCriteria]
		,@PageSize = tmp.[PageSize]
		,@PageIndex = tmp.[PageIndex]
		,@OrderBy = tmp.[OrderBy]
		,@OrderByCriteria = tmp.[OrderByCriteria]
		,@roleId = tmp.[RoleMasterId]
		,@Empties = tmp.[Empties]
		,@EmptiesCriteria = tmp.[EmptiesCriteria]
		,@ReceivedCapacityPalates = tmp.[ReceivedCapacityPalates]
		,@ReceivedCapacityPalatesCriteria = tmp.[ReceivedCapacityPalatesCriteria]
		,@IsAvailableStock = tmp.[IsAvailableStock]
		,@AvailableStockCriteria = tmp.[AvailableStockCriteria]
		,@TotalPrice = tmp.[TotalPrice]
		,@TotalPriceCriteria = tmp.[TotalPriceCriteria]
		,@AvailableCredit = tmp.[AvailableCredit]
		,@AvailableCreditCriteria = tmp.[AvailableCreditCriteria]
		,@SONumber = tmp.SONumber
		,@SupplierName = tmp.SupplierName
		,@SupplierCode = tmp.SupplierCode
		,@PONumber = tmp.PONumber
		,@EnquiryType = tmp.EnquiryType
		,@SoldToName = tmp.SoldToName
		,@SoldToCode = tmp.SoldToCode
		,@ShipToCode = tmp.ShipToCode
		,@CollectionLocationName = tmp.CollectionLocationName
		,@CollectionLocationCode = tmp.CollectionLocationCode
		,@ShipToName = tmp.ShipToName
		,@TruckSize = tmp.TruckSize
		,@SONumberCriteria = tmp.SONumberCriteria
		,@SupplierNameCriteria = tmp.SupplierNameCriteria
		,@SupplierCodeCriteria = tmp.SupplierCodeCriteria
		,@PONumberCriteria = tmp.PONumberCriteria
		,@EnquiryTypeCriteria = tmp.EnquiryTypeCriteria
		,@SoldToNameCriteria = tmp.SoldToNameCriteria
		,@SoldToCodeCriteria = tmp.SoldToCodeCriteria
		,@ShipToCodeCriteria = tmp.ShipToCodeCriteria
		,@CollectionLocationNameCriteria = tmp.CollectionLocationNameCriteria
		,@CollectionLocationCodeCriteria = tmp.CollectionLocationCodeCriteria
		,@ShipToNameCriteria = tmp.ShipToNameCriteria
		,@TruckSizeCriteria = tmp.TruckSizeCriteria
		,@CultureId = [CultureId]
		,@ProductCode = [ProductCode]
		,@ProductSearchCriteria = [ProductSearchCriteria]
		,@LoginId = tmp.[LoginId]
		,@IsExportToExcel = tmp.[IsExportToExcel]
		,@PageName =tmp.[PageName]
		,@PageControlName=tmp.[PageControlName]
		,@ShortName = tmp.ShortName
		,@ShortNameCriteria = tmp.ShortNameCriteria

	FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[PageIndex] INT
			,[PageSize] INT
			,[OrderBy] NVARCHAR(2000)
			,[OrderByCriteria] NVARCHAR(2000)
			,[EnquiryAutoNumber] NVARCHAR(150)
			,[EnquiryAutoNumberCriteria] NVARCHAR(50)
			,[BranchPlant] NVARCHAR(150)
			,[BranchPlantCriteria] NVARCHAR(50)
			,[TotalPriceCriteria] NVARCHAR(150)
			,[TotalPrice] NVARCHAR(50)
			,[Area] NVARCHAR(150)
			,[AreaCriteria] NVARCHAR(50)
			,SONumber NVARCHAR(150)
			,SupplierName NVARCHAR(150)
			,SupplierCode NVARCHAR(150)
			,PONumber NVARCHAR(150)
			,EnquiryType NVARCHAR(150)
			,SoldToName NVARCHAR(150)
			,SoldToCode NVARCHAR(150)
			,ShipToCode NVARCHAR(150)
			,CollectionLocationName NVARCHAR(150)
			,CollectionLocationCode NVARCHAR(150)
			,ShipToName NVARCHAR(150)
			,TruckSize NVARCHAR(150)
			,SONumberCriteria NVARCHAR(150)
			,SupplierNameCriteria NVARCHAR(150)
			,SupplierCodeCriteria NVARCHAR(150)
			,PONumberCriteria NVARCHAR(150)
			,EnquiryTypeCriteria NVARCHAR(150)
			,SoldToNameCriteria NVARCHAR(150)
			,SoldToCodeCriteria NVARCHAR(150)
			,ShipToCodeCriteria NVARCHAR(150)
			,CollectionLocationNameCriteria NVARCHAR(150)
			,CollectionLocationCodeCriteria NVARCHAR(150)
			,ShipToNameCriteria NVARCHAR(150)
			,TruckSizeCriteria NVARCHAR(150)
			,[CompanyNameValue] NVARCHAR(150)
			,[CompanyNameValueCriteria] NVARCHAR(50)
			,[DeliveryLocationName] NVARCHAR(150)
			,[DeliveryLocationNameCriteria] NVARCHAR(50)
			,[DeliveryLocation] NVARCHAR(150)
			,[DeliveryLocationCriteria] NVARCHAR(50)
			,[Gratis] NVARCHAR(150)
			,[GratisCriteria] NVARCHAR(50)
			,[EnquiryDate] NVARCHAR(150)
			,[EnquiryDateCriteria] NVARCHAR(50)
			,[EnquiryEndDate] nvarchar(150)
			,[EnquiryEndDateCriteria] nvarchar(150)
			,[RequestDate] NVARCHAR(150)
			,[RequestDateCriteria] NVARCHAR(50)
			,[RequestEndDate] Nvarchar(150)
			,[RequestEndDateCriteria] nvarchar(50)
			,[PromisedDate] NVARCHAR(150)
			,[PromisedDateCriteria] NVARCHAR(50)
			,[PromisedEndDate] Nvarchar(150)
			,[PromisedEndDateCriteria] nvarchar(50)

			,[PickDateTime] NVARCHAR(150)
			,[PickDateTimeCriteria] NVARCHAR(50)
			,[PickEndDateTime] Nvarchar(150)
			,[PickEndDateTimeCriteria] nvarchar(50)

				,CarrierName NVARCHAR(150)
			,CarrierNameCriteria NVARCHAR(150)

							,[RPM] NVARCHAR(150)
			,[RPMCriteria] NVARCHAR(150)

			,[Status] NVARCHAR(150)
			,[Empties] NVARCHAR(150)
			,[EmptiesCriteria] NVARCHAR(150)
			,[ReceivedCapacityPalates] NVARCHAR(150)
			,[ReceivedCapacityPalatesCriteria] NVARCHAR(150)
			,[IsAvailableStock] NVARCHAR(150)
			,[AvailableStockCriteria] NVARCHAR(150)
			,[AvailableCredit] NVARCHAR(150)
			,[AvailableCreditCriteria] NVARCHAR(150)
			,[StatusCriteria] NVARCHAR(50)
			,[RoleMasterId] BIGINT
			,[CultureId] BIGINT
			,[LoginId] BIGINT
			,[ProductCode] NVARCHAR(500)
			,[ProductSearchCriteria] NVARCHAR(100)
			,[IsExportToExcel] BIT
			,[PageControlName] nvarchar(250)
			,[PageName] nvarchar(250)
				,ShortName NVARCHAR(150)
			,ShortNameCriteria NVARCHAR(150)

			) tmp

	IF (RTRIM(@OrderBy) = '')
	BEGIN
		SET @OrderByClause = ' ISNULL(t.ModifiedDate,t.CreatedDate) desc'
	END
	ELSE
	BEGIN
	if(@OrderBy = 'Status')
		begin
			SET @OrderByClause = '(SELECT [dbo].[fn_RoleWiseStatus] (4,t.CurrentState,1101)) ' + @OrderByCriteria
		end
	else
		begin
			SET @OrderByClause = '' + @OrderBy + ' ' + @OrderByCriteria
		end
		
	END

	PRINT @OrderByClause

	Print @EnquiryEndDate


	IF (RTRIM(@whereClause) = '')
	BEGIN
		SET @whereClause = '1=1'
	END

	IF (RTRIM(@whereClauseIcon) = '')
	BEGIN
		SET @whereClauseIcon = '1=1'
	END

	IF (@ProductCode IS NOT NULL)
	BEGIN
		SET @ProductCode = @ProductCode
		SET @ProductSearchCriteria = @ProductSearchCriteria
	END
	ELSE
	BEGIN
		SET @ProductCode = ''''
		SET @ProductSearchCriteria = ''''
	END

	SET @PageIndex = (CONVERT(BIGINT, @PageIndex) + 1)

	IF @EnquiryAutoNumber != ''
	BEGIN
		IF @EnquiryAutoNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber NOT LIKE ''%' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryAutoNumber + ''''
		END

		IF @EnquiryAutoNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber =  ''' + @EnquiryAutoNumber + ''''
		END

		IF @EnquiryAutoNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryAutoNumber <>  ''' + @EnquiryAutoNumber + ''''
		END
	END


		IF @TruckSize != ''
	BEGIN
		IF @TruckSizeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) LIKE ''%' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) NOT LIKE ''%' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) LIKE ''' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) LIKE ''%' + @TruckSize + ''''
		END

		IF @TruckSizeCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) =  ''' + @TruckSize + ''''
		END

		IF @TruckSizeCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) <>  ''' + @TruckSize + ''''
		END
	END


		IF @RPM != ''
	BEGIN
		IF @RPMCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) LIKE ''%' + @RPM + '%'''
		END

		IF @RPMCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) NOT LIKE ''%' + @RPM + '%'''
		END

		IF @RPMCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) LIKE ''' 
				+ @RPM + '%'''
		END

		IF @RPMCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) LIKE ''%' + @RPM + ''''
		END

		IF @RPMCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) =  ''' + 
				@RPM + ''''
		END

		IF @RPMCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) <>  ''' + 
				@RPM + ''''
		END
	END



	IF @BranchPlant != ''
	BEGIN
		IF @BranchPlantCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''%' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId NOT LIKE ''%' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''%' + @BranchPlant + ''''
		END

		IF @BranchPlantCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId =  ''' + @BranchPlant + ''''
		END

		IF @BranchPlantCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and t.StockLocationId <>  ''' + @BranchPlant + ''''
		END
	END

	------------------------------------------------New Filter-----------------------------------------------------------
	IF @SONumber != ''
	BEGIN
		IF @SONumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber LIKE ''%' + @SONumber + '%'''
		END

		IF @SONumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber NOT LIKE ''%' + @SONumber + '%'''
		END

		IF @SONumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber LIKE ''' + @SONumber + '%'''
		END

		IF @SONumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber LIKE ''%' + @SONumber + ''''
		END

		IF @SONumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber =  ''' + @SONumber + ''''
		END

		IF @SONumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SONumber <>  ''' + @SONumber + ''''
		END
	END


	IF @CarrierName != ''
	BEGIN
		IF @CarrierNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName LIKE ''%' + @CarrierName + '%'''
		END

		IF @CarrierNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName NOT LIKE ''%' + @CarrierName + '%'''
		END

		IF @CarrierNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName LIKE ''' + @CarrierName + '%'''
		END

		IF @CarrierNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName LIKE ''%' + @CarrierName + ''''
		END

		IF @CarrierNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName =  ''' + @CarrierName + ''''
		END

		IF @CarrierNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierName <>  ''' + @CarrierName + ''''
		END
	END


	-----------------------------------------------End Filter------------------------------------------------------------
	IF @CompanyNameValue != ''
	BEGIN
		IF @CompanyNameValueCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName LIKE ''%' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName NOT LIKE ''%' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName LIKE ''' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName LIKE ''%' + @CompanyNameValue + ''''
		END

		IF @CompanyNameValueCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName =  ''' + @CompanyNameValue + ''''
		END

		IF @CompanyNameValueCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and t.SoldToName <>  ''' + @CompanyNameValue + ''''
		END
	END

		IF @ShipToCode != ''
	BEGIN
		IF @ShipToCodeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''%' + @ShipToCode + '%'''
		END

		IF @ShipToCodeCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode NOT LIKE ''%' + @ShipToCode + '%'''
		END

		IF @ShipToCodeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''' + @ShipToCode + '%'''
		END

		IF @ShipToCodeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''%' + @ShipToCode + ''''
		END

		IF @ShipToCodeCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode =  ''' + @ShipToCode + ''''
		END

		IF @ShipToCodeCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode <>  ''' + @ShipToCode + ''''
		END
	END


	IF @ShortName != ''
	BEGIN
		IF @ShortNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) LIKE ''%' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) NOT LIKE ''%' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) LIKE ''' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) LIKE ''%' + @ShortName + ''''
		END

		IF @ShortNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) =  ''' + @ShortName + ''''
		END

		IF @ShortNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) <>  ''' + @ShortName + ''''
		END
	END


	IF @ShipToName != ''
	BEGIN
		IF @ShipToNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''%' + @ShipToName + '%'''
		END

		IF @ShipToNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName NOT LIKE ''%' + @ShipToName + '%'''
		END

		IF @ShipToNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''' + @ShipToName + '%'''
		END

		IF @ShipToNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''%' + @ShipToName + ''''
		END

		IF @ShipToNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName =  ''' + @ShipToName + ''''
		END

		IF @ShipToNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName <>  ''' + @ShipToName + ''''
		END
	END


	IF @DeliveryLocationName != ''
	BEGIN
		IF @DeliveryLocationNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''%' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName NOT LIKE ''%' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName LIKE ''%' + @DeliveryLocationName + ''''
		END

		IF @DeliveryLocationNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName =  ''' + @DeliveryLocationName + ''''
		END

		IF @DeliveryLocationNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and t.ShipToName <>  ''' + @DeliveryLocationName + ''''
		END
	END

	IF @SoldToCode != ''
	BEGIN
		IF @SoldToCodeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode LIKE ''%' + @SoldToCode + '%'''
		END

		IF @SoldToCodeCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode NOT LIKE ''%' + @SoldToCode + '%'''
		END

		IF @SoldToCodeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode LIKE ''' + @SoldToCode + '%'''
		END

		IF @SoldToCodeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode LIKE ''%' + @SoldToCode + ''''
		END

		IF @SoldToCodeCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode =  ''' + @SoldToCode + ''''
		END

		IF @SoldToCodeCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and SoldToCode <>  ''' + @SoldToCode + ''''
		END
	END

	IF @Area != ''
	BEGIN
		IF @AreaCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and Area LIKE ''%' + @Area + '%'''
		END

		IF @AreaCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and Area NOT LIKE ''%' + @Area + '%'''
		END

		IF @AreaCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Area LIKE ''' + @Area + '%'''
		END

		IF @AreaCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Area LIKE ''%' + @Area + ''''
		END

		IF @AreaCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and Area =  ''' + @Area + ''''
		END

		IF @AreaCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and Area <>  ''' + @Area + ''''
		END
	END


	IF @CollectionLocationName != ''
	BEGIN
		IF @CollectionLocationNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) LIKE ''%' + @CollectionLocationName + '%'''
		END

		IF @CollectionLocationNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) NOT LIKE ''%' + @CollectionLocationName + '%'''
		END

		IF @CollectionLocationNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) LIKE ''' + @CollectionLocationName + '%'''
		END

		IF @CollectionLocationNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) LIKE ''%' + @CollectionLocationName + ''''
		END

		IF @CollectionLocationNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) =  ''' + @CollectionLocationName + ''''
		END

		IF @CollectionLocationNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) <>  ''' + @CollectionLocationName + ''''
		END
	END

	IF @CollectionLocationCode != ''
	BEGIN
		IF @CollectionLocationCodeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode LIKE ''%' + @CollectionLocationCode + '%'''
		END

		IF @CollectionLocationCodeCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode NOT LIKE ''%' + @CollectionLocationCode + '%'''
		END

		IF @CollectionLocationCodeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode LIKE ''' + @CollectionLocationCode + '%'''
		END

		IF @CollectionLocationCodeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode LIKE ''%' + @CollectionLocationCode + ''''
		END

		IF @CollectionLocationCodeCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode =  ''' + @CollectionLocationCode + ''''
		END

		IF @CollectionLocationCodeCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and CollectionLocationCode <>  ''' + @CollectionLocationCode + ''''
		END
	END



	IF @Empties != ''
	BEGIN
		SET @whereClause = @whereClause + ' and (case when (c.ActualEmpties < 0) then ''C'' else ''W'' end) =  ''' + @Empties + ''''
	END

	IF @IsAvailableStock != ''
	BEGIN
		SET @whereClause = @whereClause + ' and (select [dbo].[fn_CheckStockValidation_New](t.EnquiryId)) =  ''' + @IsAvailableStock + ''''
	END

	IF @AvailableCredit != ''
	BEGIN
		SET @whereClause = @whereClause + ' and (select [dbo].[fn_CheckCreditLimitAvailability](t.EnquiryId)) =  ''' + @AvailableCredit + ''''
	END

	IF @ReceivedCapacityPalates != ''
	BEGIN
		SET @whereClause = @whereClause + 
			' and (case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),t.ShipTo,t.SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) < 0) then ''0'' else ''1'' end) =  ''' 
			+ @ReceivedCapacityPalates + ''''
	END

	IF @DeliveryLocation != ''
	BEGIN
		IF @DeliveryLocationCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''%' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode NOT LIKE ''%' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode LIKE ''%' + @DeliveryLocation + ''''
		END

		IF @DeliveryLocationCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode =  ''' + @DeliveryLocation + ''''
		END

		IF @DeliveryLocationCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and ShipToCode <>  ''' + @DeliveryLocation + ''''
		END
	END

	IF @Status != ''
	BEGIN
		IF @StatusCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId) + ',t.CurrentState,' + CONVERT(NVARCHAR(10), @CultureId) + ')) =  N''' + @Status + ''''
		END
		Else IF @StatusCriteria = 'in'
		Begin
			SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId) + ',t.CurrentState,' + CONVERT(NVARCHAR(10), @CultureId) + ')) IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] (N''' + CONVERT(NVARCHAR(500), @Status) + '''))'
		End
	END

	IF @Gratis != ''
	BEGIN
		IF @GratisCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) LIKE ''%' 
				+ @Gratis + '%'''
		END

		IF @GratisCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) NOT LIKE ''%' 
				+ @Gratis + '%'''
		END

		IF @GratisCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) LIKE ''' 
				+ @Gratis + '%'''
		END

		IF @GratisCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) LIKE ''%' 
				+ @Gratis + ''''
		END

		IF @GratisCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) =  ''' 
				+ @Gratis + ''''
		END

		IF @GratisCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and IsActive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) <>  ''' 
				+ @Gratis + ''''
		END
	END

	    IF @TotalPrice != ''
	BEGIN
		IF @TotalPriceCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) LIKE ''%' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) NOT LIKE ''%' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) LIKE ''' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) LIKE ''%' + @TotalPrice + ''''
		END

		IF @TotalPriceCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) =  ''' + @TotalPrice + ''''
		END

		IF @TotalPriceCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and CAST(ISNULL(t.TotalPrice,0) as NVARCHAR) <>  ''' + @TotalPrice + ''''
		END
	END



	IF @EnquiryDate != ''
	BEGIN
		IF @EnquiryEndDate != ''
		BEGIN
			if @EnquiryDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,EnquiryDate,103) ' +@EnquiryDateCriteria+ ' CONVERT(date,''' + @EnquiryDate + ''',103) '+@AndOrCondition+' CONVERT(date,EnquiryDate,103) ' +@EnquiryEndDateCriteria+ ' CONVERT(date,''' + @EnquiryEndDate + ''',103)'
		END
		ELSE IF @EnquiryDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,EnquiryDate,103) >= CONVERT(date,''' + @EnquiryDate + ''',103)'
		END
		ELSE IF @EnquiryDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,EnquiryDate,103) < CONVERT(date,''' + @EnquiryDate + ''',103)'
		END
	END


	IF @PickDateTime != ''
	BEGIN
		IF @PickEndDateTime != ''
		BEGIN
			if @PickDateTimeCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) '+@PickDateTimeCriteria+' CONVERT(date,''' + @PickDateTime + ''',103) '+@AndOrCondition+' CONVERT(date,PickDateTime,103) '+@PickEndDateTimeCriteria+' CONVERT(date,''' + @PickEndDateTime + ''',103)'
		END
		ELSE IF @PickDateTimeCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) >= CONVERT(date,''' + @PickDateTime + ''',103)'
		END
		ELSE IF @PickDateTimeCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) < CONVERT(date,''' + @PickDateTime + ''',103)'
		END
	END



	IF @RequestDate != ''
	BEGIN
		IF @RequestEndDate != '='
		BEGIN
			if @RequestDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,RequestDate,103) '+@RequestDateCriteria+' CONVERT(date,''' + @RequestDate + ''',103) '+@AndOrCondition+' CONVERT(date,RequestDate,103) '+@RequestEndDateCriteria+' CONVERT(date,''' + @RequestEndDate + ''',103)'
		END
		ELSE IF @RequestDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,RequestDate,103) >= CONVERT(date,''' + @RequestDate + ''',103)'
		END
		ELSE IF @RequestDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,RequestDate,103) < CONVERT(date,''' + @RequestDate + ''',103)'
		END
	END

	IF @PromisedDate != ''
	BEGIN
		IF @PromisedEndDate != '='
		BEGIN
			if @PromisedDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End
			SET @whereClause = @whereClause + ' and CONVERT(date,PromisedDate,103) '+@PromisedDateCriteria+' CONVERT(date,''' + @PromisedDate + ''',103) '+@AndOrCondition+' CONVERT(date,PromisedDate,103) '+@PromisedEndDateCriteria+' CONVERT(date,''' + @PromisedEndDate + ''',103)'
		END
		ELSE IF @PromisedDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PromisedDate,103) >= CONVERT(date,''' + @PromisedDate + ''',103)'
		END
		ELSE IF @PromisedDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PromisedDate,103) < CONVERT(date,''' + @PromisedDate + ''',103)'
		END
	END


	IF @ProductCode != ''
	BEGIN
		IF @ProductSearchCriteria = 'Include'
		BEGIN
			SET @whereClause = @whereClause + 'and t.EnquiryId in (SELECT EnquiryId FROM EnquiryProduct with (nolock) WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), 
					@ProductCode) + ''')) GROUP BY EnquiryId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + ''')))'
		END
		ELSE
		BEGIN
			SET @whereClause = @whereClause + 'and t.EnquiryId not in (SELECT EnquiryId FROM EnquiryProduct with (nolock) WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500
					), @ProductCode) + ''')) GROUP BY EnquiryId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + ''')))'
		END
	END


	IF @roleId IN (4, 14, 15)
	BEGIN
		PRINT @roleId

		SET @whereClause = @whereClause + ' and  (t.SoldTo in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + 
			') or t.CompanyId in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + '))'
	END

	--print 'IsExportToExcel' +@IsExportToExcel
	IF @IsExportToExcel != '0'
	BEGIN
		PRINT 'true'

		SET @PaginationClause = '1=1'
	END
	ELSE
	BEGIN
		PRINT 'false'

		SET @PaginationClause = '' + (
				SELECT [dbo].[fn_GetPaginationString](@PageSize, @PageIndex)
				) + ''
	END

	PRINT '1111' + @whereClause

	SET @whereClause = @whereClause + '' + (
			SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause](@LoginId, @PageName, @PageControlName)
			) + ''

	PRINT @whereClause

	SET @sql = 
		'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  
        ,[EnquiryId]
        ,rownumber,TotalCount,[EnquiryAutoNumber],PONumber,[EnquiryType],
  ShipToCode,
  0 as CheckedEnquiry,
  ModifiedDate,
  Area,
  ZoneName,
  RequestDate as RequestDate,
  PromisedDate as PromisedDate,
  RequestDate as RequestDateField,
  PromisedDate as PromisedDateField,
  PickDateTime as PickDateTime,
  OriginalCollectionDate as OriginalCollectionDate,
  EnquiryDate as EnquiryDate, 
 ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) as ReceivedCapacityPalettes,
  CONVERT(bigint,ISNULL(Capacity,0)) as Capacity,
  AssociatedOrder,
  CurrentState,
  Status,
  Class,
  format(ISNULL(TotalPrice,0), N''C'', (select SettingValue from SettingMaster where SettingParameter = ''CurrencyCultureCode'')) AS TotalPrice,
   ISNULL(BranchPlant,'''') as BranchPlant,
  ISNULL(Note,'''') as Note,
  EmptiesLimit,
  ActualEmpties,
  CreditLimit,
  AvailableCreditLimit,
  Empties,   
   case when ' 
	+ @IsExportToExcel + '=''1'' then case when ReceivedCapacityPalettesCheck =1 then ''Yes'' else ''No'' end else ReceivedCapacityPalettesCheck end as ReceivedCapacityPalettesCheck ,
 case when ' + 
	@IsExportToExcel + '=''1'' then case when IsAvailableStock =1 then ''Yes'' else ''No'' end else IsAvailableStock end as IsAvailableStock ,
  case when ' + @IsExportToExcel + 
	'=''1''  then case when IsAvailableCredit =1 then ''Yes'' else ''No'' end else IsAvailableCredit end as IsAvailableCredit ,
  NumberOfPalettes,
  TruckWeight,
  IsRecievingLocationCapacityExceed,  
  ShipTo,
  Field1,
  SoldTo    
,[PreviousState]
      ,[TruckSizeId]
      ,LTRIM(RTRIM(SUBSTRING(SoldToName, 0, CHARINDEX(''-'', SoldToName)))) as ShortName,
	   [SoldToName],
	  [ShipToName],
	  [SupplierName],
	  [SupplierCode],
	  [CollectionLocationName],
	     ISNULL(CollectionLocationCode,'''') as CollectionLocationCode,
	  [SONumber],
	  [TruckSize],
	  [SequenceNo],
		 SoldToCode,
		  ISNULL(CarrierCode,'''') as CarrierCode,
		   ISNULL(CarrierName,'''') as CarrierName,
		    ISNULL(CarrierId,'''') as CarrierId,
			RPMValue,
			 ISNULL(IsSelfCollect,0) as IsSelfCollect,
			  OrderedBy ,
	  GratisCode,Province,Description1,Description2 ,CreatedUserName ,CompanyType,Remarks
			 from (SELECT  ROW_NUMBER() OVER (ORDER BY ' 
	+ @OrderByClause + 
	') as rownumber , COUNT(*) OVER () as TotalCount,t.[EnquiryId],
  t.[EnquiryAutoNumber], 
  t.PONumber,
  t.[EnquiryType] ,
  t.ShipToCode  as ShipToCode,
  ISNULL(t.ModifiedDate,t.CreatedDate) as ModifiedDate,
   ISNULL(d.Area,''-'') as Area,
     	 d.Capacity,
  t.RequestDate,
  t.PickDateTime,
  t.OriginalCollectionDate,
  t.OrderProposedETD,
  t.EnquiryDate,  
 (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = t.EnquiryId and isactive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,
  t.CurrentState,
   (SELECT [dbo].[fn_RoleWiseStatus] (' 
	+ CONVERT(NVARCHAR(10), @roleId) + ',t.CurrentState,' + CONVERT(NVARCHAR(10), @CultureId) + ')) AS [Status],
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId) + 
	',t.CurrentState)) AS Class,
  t.TotalPrice,
    t.StockLocationId as BranchPlant,
  (select top 1 Note from Notes  with (nolock)  where ObjectId = t.EnquiryId and ObjectType = 1220 and RoleId in (select RoleId from NotesRoleWiseConfiguration  with (nolock) where ViewNotesByRoleId = ' 
	+ CONVERT(NVARCHAR(10), @roleId) + 
	' and ObjectType = 1220)) as Note,
 c.EmptiesLimit as EmptiesLimit,
  c.ActualEmpties as ActualEmpties,
  case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
  
   
         '

	SET @sql1 = 
		'  case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),t.ShipTo,t.SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) < 0  then ''0'' else ''1'' end  as ReceivedCapacityPalettesCheck,
		(select [dbo].[fn_CheckStockValidation_New](t.EnquiryId)) as IsAvailableStock,
	(select [dbo].[fn_CheckCreditLimitAvailability](t.EnquiryId)) as IsAvailableCredit,c.CreditLimit as CreditLimit,c.AvailableCreditLimit as AvailableCreditLimit,
   t.NumberOfPalettes,
   t.TruckWeight,
   ISNULL(t.IsRecievingLocationCapacityExceed, 0) as IsRecievingLocationCapacityExceed,
   t.ShipTo ,
   d.Field1,
   t.SoldTo,
	  [PreviousState],
      t.[TruckSizeId],
	  (Select top 1 tz.TruckSize from TruckSize tz where tz.TruckSizeId=t.[TruckSizeId]) as TruckSize,
	  t.[SoldToName],
	  t.[ShipToName],
	  t.[SequenceNo],
	  t.[SONumber],
	  zc.ZoneName,
	  t.SoldToCode as SoldToCode,
	  (Select sp.CompanyName from Company Sp where sp.CompanyId=t.CompanyId) as SupplierName,
	  t.CompanyCode as SupplierCode,
	  (Select cl.LocationName from Location cl where cl.LocationCode=t.CollectionLocationCode) as CollectionLocationName,
	  t.CollectionLocationCode,
	  t.PromisedDate  ,
	  t.CarrierCode ,
	  t.CarrierName ,
	  t.CarrierId ,
	  (Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = t.EnquiryId) > 0 then ''1'' else ''0'' end) as RPMValue,
	  t.IsSelfCollect ,
	  t.OrderedBy ,
	  t.GratisCode,t.Province,t.Description1,t.Description2,
	  (select  UserName   From  Login  where LoginId=t.CreatedBy)  as CreatedUserName,
	  c.CompanyType,
	  t.Remarks
    from [Enquiry] t with (nolock) left join  [Location] d  with (nolock)
    on t.shipto = d.LocationId
    left join Company c with (nolock) on  c.CompanyId = t.SoldTo
	left join ZoneCode zc on zc.CompanyId=t.SoldTo
    WHERE t.IsActive = 1 and ' 
		+ @whereClause + '  ) as tmp where ' + @PaginationClause + ' 
	FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML
    )'


	PRINT @sql
	PRINT @sql1

	EXECUTE (@sql + @sql1)
		--SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
		--EXEC sp_executesql @sql
END
