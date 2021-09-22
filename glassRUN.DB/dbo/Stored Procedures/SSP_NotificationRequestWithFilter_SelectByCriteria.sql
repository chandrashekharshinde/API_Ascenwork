CREATE PROCEDURE [dbo].[SSP_NotificationRequestWithFilter_SelectByCriteria] --'<Json><ServicesAction>LoadCustomerServiceEnquiryDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate>29/07/2019</EnquiryDate><EnquiryDateCriteria>&lt;</EnquiryDateCriteria><EnquiryEndDate>30/07/2019</EnquiryEndDate><EnquiryEndDateCriteria>&gt;=</EnquiryEndDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><RequestEndDate></RequestEndDate><RequestEndDateCriteria></RequestEndDateCriteria><PickDateTime></PickDateTime><PickDateTimeCriteria></PickDateTimeCriteria><PickEndDateTime></PickEndDateTime><PickEndDateTimeCriteria></PickEndDateTimeCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><PromisedEndDate></PromisedEndDate><PromisedEndDateCriteria></PromisedEndDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><CurrentState>1,7</CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>3</RoleMasterId><LoginId>507</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><SONumber></SONumber><SupplierName></SupplierName><SupplierCode></SupplierCode><PONumber></PONumber><EnquiryType></EnquiryType><SoldToName></SoldToName><ShipToCode></ShipToCode><CollectionLocationName></CollectionLocationName><CollectionLocationCode></CollectionLocationCode><ShipToName></ShipToName><TruckSize></TruckSize><SONumberCriteria></SONumberCriteria><SupplierNameCriteria></SupplierNameCriteria><SupplierCodeCriteria></SupplierCodeCriteria><PONumberCriteria></PONumberCriteria><EnquiryTypeCriteria></EnquiryTypeCriteria><SoldToNameCriteria></SoldToNameCriteria><ShipToCodeCriteria></ShipToCodeCriteria><CollectionLocationNameCriteria></CollectionLocationNameCriteria><CollectionLocationCodeCriteria></CollectionLocationCodeCriteria><ShipToNameCriteria></ShipToNameCriteria><TruckSizeCriteria></TruckSizeCriteria><PageName>SalesAdminApproval</PageName><PageControlName>Enquiry</PageControlName><CarrierName></CarrierName><CarrierNameCriteria></CarrierNameCriteria><ShortName></ShortName><ShortNameCriteria></ShortNameCriteria><RPM></RPM><RPMCriteria></RPMCriteria></Json>'
	--'<Json><ServicesAction>LoadCustomerServiceEnquiryDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><CurrentState>1,7</CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>3</RoleMasterId><LoginId>467</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><SONumber></SONumber><SupplierName></SupplierName><SupplierCode></SupplierCode><PONumber></PONumber><EnquiryType></EnquiryType><SoldToName></SoldToName><ShipToCode></ShipToCode><CollectionLocationName></CollectionLocationName><CollectionLocationCode></CollectionLocationCode><ShipToName></ShipToName><TruckSize></TruckSize><SONumberCriteria></SONumberCriteria><SupplierNameCriteria></SupplierNameCriteria><SupplierCodeCriteria></SupplierCodeCriteria><PONumberCriteria></PONumberCriteria><EnquiryTypeCriteria></EnquiryTypeCriteria><SoldToNameCriteria></SoldToNameCriteria><ShipToCodeCriteria></ShipToCodeCriteria><CollectionLocationNameCriteria></CollectionLocationNameCriteria><CollectionLocationCodeCriteria></CollectionLocationCodeCriteria><ShipToNameCriteria></ShipToNameCriteria><TruckSizeCriteria></TruckSizeCriteria><PageName>SalesAdminApproval</PageName></Json>'
	(@xmlDoc XML)
AS
BEGIN
	DECLARE @sqlTotalCount NVARCHAR(max)
	DECLARE @sql NVARCHAR(max)
	
	DECLARE @intPointer INT;
	DECLARE @whereClause NVARCHAR(max)
	
	DECLARE @PageSize INT
	DECLARE @PageIndex INT
	DECLARE @OrderByClause NVARCHAR(500)
	DECLARE @OrderBy NVARCHAR(100)
	DECLARE @NotificationType NVARCHAR(200)
	DECLARE @DeviceType NVARCHAR(100)
	DECLARE @FromDate NVARCHAR(100)
	DECLARE @EndDate NVARCHAR(100)
	DECLARE @SearchValue NVARCHAR(100)
	DECLARE @LoginId INT
	DECLARE @PaginationClause NVARCHAR(max) 

	

	SET @PaginationClause = ''
	SET @whereClause = ''

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT 

		@PageSize = tmp.[PageSize]
		,@PageIndex = tmp.[PageIndex]
		,@OrderBy = tmp.[OrderBy]
		,@NotificationType = tmp.[NotificationType]
		,@DeviceType = tmp.[DeviceType]
		,@FromDate = tmp.[FromDate]
		,@EndDate = tmp.[EndDate]
		,@SearchValue = tmp.[SearchValue]
		,@LoginId  = tmp.[LoginId]
		
		
	FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[PageIndex] INT
			,[PageSize] INT
			,[OrderBy] NVARCHAR(2000)
			,[NotificationType] NVARCHAR(250)
			,[DeviceType] NVARCHAR(250)
			,[FromDate] NVARCHAR(250)
			,[EndDate] NVARCHAR(250)
			,[SearchValue] NVARCHAR(250)
			,[LoginId] INT
			
			) tmp

	IF (RTRIM(@OrderBy) = ''  or  @OrderBy is null)
	BEGIN


		SET @OrderByClause = ' nr.NotificationRequestId desc'
	END
	else
	begin

	SET @OrderByClause = ' nr.IsSentDatetime '+ @OrderBy

	end
	
	PRINT @OrderByClause
	

	IF (RTRIM(@whereClause) = '')
	BEGIN
		SET @whereClause = '1=1'
	END




	IF @NotificationType != ''
	BEGIN
		

		SET @whereClause = @whereClause + ' and NotifcationType =''' + @NotificationType + ''''
	END



	IF @DeviceType != ''
	BEGIN
		

		SET @whereClause = @whereClause + ' and DeviceType =''' + @DeviceType + ''''
	END



	IF @SearchValue != ''
	BEGIN
		

		SET @whereClause = @whereClause + ' and Title like ''%' + @SearchValue + '%'''
	END


	IF @LoginId != 0
	BEGIN
		

		SET @whereClause = @whereClause + ' and LoginId =''' + Convert(nvarchar(250),@LoginId) + ''''
	END



	IF @FromDate != ''  and @EndDate != ''
	BEGIN
		

		SET @whereClause = @whereClause + ' and CONVERT(DATE,IsSentDatetime, 103) BETWEEN CONVERT(DATE,'''+@FromDate+''', 103) AND CONVERT(DATE,'''+@EndDate+''', 103)'
	END

	

	SET @PaginationClause = '' + (
				SELECT [dbo].[fn_GetPaginationStringV2](@PageSize, @PageIndex+1)
				) + ''


	PRINT @whereClause

	SET @sql = 
		'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT 
 ''true'' AS [@json:Array]  
        ,NotificationRequestId 
		,Title
		,IsSentDatetime
		,IsAck
			 from (SELECT  ROW_NUMBER() OVER (ORDER BY  '+ @OrderByClause+') 
			 as rownumber , COUNT(*) OVER () as TotalCount,
 NotificationRequestId ,Title ,ISNULL(IsAck,0) as IsAck  ,IsSentDatetime  from NotificationRequest  nR 
 WHERE nR.IsActive = 1 and ' 
		+ @whereClause + ' ) as tmp
  where ' + @PaginationClause + '
	FOR XML PATH(''NotificationRequestList''),ELEMENTS,ROOT(''Json'')) AS XML
    )

'


	PRINT @sql
	
	EXECUTE (@sql)
		
END