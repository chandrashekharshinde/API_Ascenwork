
CREATE PROCEDURE [dbo].[SSP_OrderGridModified_Paging] --'<Json><ServicesAction>LoadOrderGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><PurchaseOrderNumber></PurchaseOrderNumber><PlateNumberCriteria></PlateNumberCriteria><PlateNumber></PlateNumber><DriverName></DriverName><DriverNameCriteria></DriverNameCriteria><TripCostCriteria></TripCostCriteria><TripCost></TripCost><ApprovedByCriteria></ApprovedByCriteria><ApprovedBy></ApprovedBy><TripRevenueCriteria></TripRevenueCriteria><SalesOrderNumberCriteria></SalesOrderNumberCriteria><SalesOrderNumber></SalesOrderNumber><TripRevenue></TripRevenue><CarrierNumberValueCriteria></CarrierNumberValueCriteria><CarrierNumberValue></CarrierNumberValue><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><OrderNumberCriteria></OrderNumberCriteria><OrderNumber></OrderNumber><BranchPlantName></BranchPlantName><BranchPlantNameCriteria></BranchPlantNameCriteria><BranchPlantCode></BranchPlantCode><BranchPlantCodeCriteria></BranchPlantCodeCriteria><ReceivedCapacityPalettesCriteria></ReceivedCapacityPalettesCriteria><ReceivedCapacityPalettes></ReceivedCapacityPalettes><OrderDate></OrderDate><OrderDateCriteria></OrderDateCriteria><OrderEndDate></OrderEndDate><OrderEndDateCriteria></OrderEndDateCriteria><PickupDateDate></PickupDateDate><PickupDateCriteria></PickupDateCriteria><PickupDateEndDate></PickupDateEndDate><PickupDateEndDateCriteria></PickupDateEndDateCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><EnquiryEndDate></EnquiryEndDate><EnquiryEndDateCriteria></EnquiryEndDateCriteria><RequestCollectionDate></RequestCollectionDate><RequestCollectionDateCriteria></RequestCollectionDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><PromisedEndDate></PromisedEndDate><PromisedEndDateCriteria></PromisedEndDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><CurrentState></CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>7</RoleMasterId><UserId>10508</UserId><LoginId>10508</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><CollectedDate></CollectedDate><CollectedDateCriteria></CollectedDateCriteria><DeliveredCriteria></DeliveredCriteria><DeliveredDate></DeliveredDate><PlanCollectionDate></PlanCollectionDate><PlanCollectionDateCriteria></PlanCollectionDateCriteria><PlanCollectionEndDate></PlanCollectionEndDate><PlanCollectionEndDateCriteria></PlanCollectionEndDateCriteria><PlanDeliveryDateCriteria></PlanDeliveryDateCriteria><PlanDeliveryDate></PlanDeliveryDate><PlanDeliveryEndDateCriteria></PlanDeliveryEndDateCriteria><PlanDeliveryEndDate></PlanDeliveryEndDate><PlateNumberDataCriteria></PlateNumberDataCriteria><PlateNumberData></PlateNumberData><OrderAttentionNeededFilter>0</OrderAttentionNeededFilter><PageName>DriverAssignment</PageName><PageControlName>Order</PageControlName><Shift></Shift><ShiftCriteria></ShiftCriteria><LoadNumber>1111</LoadNumber><LoadNumberCriteria>=</LoadNumberCriteria><UserName></UserName><UserNameCriteria></UserNameCriteria></Json>'
	--'<Json><ServicesAction>LoadOrderGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><PurchaseOrderNumber></PurchaseOrderNumber><PlateNumberCriteria></PlateNumberCriteria><PlateNumber></PlateNumber><DriverName></DriverName><DriverNameCriteria></DriverNameCriteria><TripCostCriteria></TripCostCriteria><TripCost></TripCost><TripRevenueCriteria></TripRevenueCriteria><SalesOrderNumberCriteria></SalesOrderNumberCriteria><SalesOrderNumber></SalesOrderNumber><TripRevenue></TripRevenue><CarrierNumberValueCriteria></CarrierNumberValueCriteria><CarrierNumberValue></CarrierNumberValue><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><OrderNumberCriteria></OrderNumberCriteria><OrderNumber></OrderNumber><BranchPlantName></BranchPlantName><BranchPlantNameCriteria></BranchPlantNameCriteria><OrderDate></OrderDate><OrderDateCriteria></OrderDateCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><RequestCollectionDate></RequestCollectionDate><RequestCollectionDateCriteria></RequestCollectionDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><CurrentState></CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>7</RoleMasterId><UserId>10508</UserId><LoginId>10508</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><CollectedDate></CollectedDate><CollectedDateCriteria></CollectedDateCriteria><DeliveredCriteria></DeliveredCriteria><DeliveredDate></DeliveredDate><PlanCollectionDate></PlanCollectionDate><PlanCollectionDateCriteria></PlanCollectionDateCriteria><PlanDeliveryDateCriteria></PlanDeliveryDateCriteria><PlanDeliveryDate></PlanDeliveryDate><PlateNumberDataCriteria></PlateNumberDataCriteria><PlateNumberData></PlateNumberData><OrderAttentionNeededFilter>0</OrderAttentionNeededFilter><PageName>DriverAssignment</PageName><PageControlName>Order</PageControlName><Shift>)</Shift><ShiftCriteria>&lt;&gt;</ShiftCriteria></Json>'
	(@xmlDoc XML)
AS
BEGIN
	DECLARE @sqlTotalCount NVARCHAR(max)
	DECLARE @sql NVARCHAR(max)
	DECLARE @sql1 NVARCHAR(max)
	DECLARE @sql2 NVARCHAR(max)
	DECLARE @sql3 NVARCHAR(max)
	DECLARE @intPointer INT;
	DECLARE @whereClause NVARCHAR(max)
	DECLARE @roleId BIGINT
	DECLARE @userId BIGINT
	DECLARE @LoginId BIGINT
	DECLARE @PageSize INT
	DECLARE @PageIndex INT
	DECLARE @OrderBy NVARCHAR(150)
	DECLARE @PageName NVARCHAR(150)
	DECLARE @PageControlName NVARCHAR(150)
	DECLARE @SalesOrderNumber NVARCHAR(150)
	DECLARE @SalesOrderNumberCriteria NVARCHAR(50)
	DECLARE @OrderNumber NVARCHAR(150)
	DECLARE @OrderNumberCriteria NVARCHAR(50)
	DECLARE @PurchaseOrderNumber NVARCHAR(150)
	DECLARE @PurchaseOrderNumberCriteria NVARCHAR(50)
	DECLARE @EnquiryAutoNumber NVARCHAR(150)
	DECLARE @EnquiryAutoNumberCriteria NVARCHAR(50)
		DECLARE @SupplierName NVARCHAR(150)
	DECLARE @SupplierNameCriteria NVARCHAR(50)
	DECLARE @BranchPlant NVARCHAR(150)
	DECLARE @BranchPlantCriteria NVARCHAR(50)

	Declare @AndOrCondition nvarchar(10)

	DECLARE @BranchPlantCode NVARCHAR(150)
	DECLARE @BranchPlantCodeCriteria NVARCHAR(50)

	DECLARE @BranchPlantName NVARCHAR(150)
	DECLARE @BranchPlantNameCriteria NVARCHAR(50)
	DECLARE @Gratis NVARCHAR(150)
	DECLARE @GratisCriteria NVARCHAR(50)
	DECLARE @DeliveryLocation NVARCHAR(150)
	DECLARE @DeliveryLocationCriteria NVARCHAR(50)
	DECLARE @Status NVARCHAR(150)
	DECLARE @StatusCriteria NVARCHAR(50)
	DECLARE @ShortName NVARCHAR(150)
	DECLARE @ShortNameCriteria NVARCHAR(50)
	DECLARE @PickShift NVARCHAR(150)
	DECLARE @PickShiftCriteria NVARCHAR(50)
	DECLARE @SchedulingDate NVARCHAR(150)
	DECLARE @SchedulingDateCriteria NVARCHAR(50)
	DECLARE @OrderType NVARCHAR(150)
	DECLARE @OrderTypeCriteria NVARCHAR(150)
	DECLARE @OrderDate NVARCHAR(150)
	DECLARE @OrderDateCriteria NVARCHAR(50)

	DECLARE @OrderEndDate NVARCHAR(150)
	DECLARE @OrderEndDateCriteria NVARCHAR(50)

	DECLARE @PickupDateDate NVARCHAR(150)
	DECLARE @PickupDateCriteria NVARCHAR(50)
	DECLARE @PickupDateEndDate NVARCHAR(150)
	DECLARE @PickupDateEndDateCriteria NVARCHAR(50)

	DECLARE @ApprovedBy NVARCHAR(150)
	DECLARE @ApprovedByCriteria NVARCHAR(50)
	
	DECLARE @PromisedDate NVARCHAR(150)
	DECLARE @PromisedDateCriteria NVARCHAR(50)
	DECLARE @PromisedEndDate NVARCHAR(150)
	DECLARE @PromisedEndDateCriteria NVARCHAR(50)



	DECLARE @CollectedDate NVARCHAR(150)
	DECLARE @CollectedDateCriteria NVARCHAR(50)
	DECLARE @DeliveredDate NVARCHAR(150)
	DECLARE @DeliveredCriteria NVARCHAR(50)

	DECLARE @PlanCollectionDate NVARCHAR(150)
	DECLARE @PlanCollectionDateCriteria NVARCHAR(50)

	DECLARE @PlanCollectionEndDate NVARCHAR(150)
	DECLARE @PlanCollectionEndDateCriteria NVARCHAR(50)

	DECLARE @PlanDeliveryDate NVARCHAR(150)
	DECLARE @PlanDeliveryDateCriteria NVARCHAR(50)
	DECLARE @PlanDeliveryEndDate NVARCHAR(150)
	DECLARE @PlanDeliveryEndDateCriteria NVARCHAR(50)

	DECLARE @PickUpDate NVARCHAR(150)
	
	DECLARE @ConfirmedPickUpDate NVARCHAR(150)
	DECLARE @ConfirmedPickUpDateCriteria NVARCHAR(50)
	DECLARE @EnquiryDate NVARCHAR(150)
	DECLARE @EnquiryDateCriteria NVARCHAR(50)

		DECLARE @EnquiryEndDate NVARCHAR(150)
	DECLARE @EnquiryEndDateCriteria NVARCHAR(50)

	DECLARE @CompanyNameValue NVARCHAR(150)
	DECLARE @CompanyNameValueCriteria NVARCHAR(50)


	DECLARE @ShortCompanyName NVARCHAR(150)
	DECLARE @ShortCompanyNameCriteria NVARCHAR(50)

	
	DECLARE @UserName NVARCHAR(150)
	DECLARE @UserNameCriteria NVARCHAR(50)
	DECLARE @Empties NVARCHAR(150)
	DECLARE @EmptiesCriteria NVARCHAR(50)
	DECLARE @statusForChangeInPickShift NVARCHAR(150)
	DECLARE @statusForChangeInPickShiftCriteria NVARCHAR(50)
	DECLARE @CultureId BIGINT
	DECLARE @ReceivedCapacityPalates NVARCHAR(150)
	DECLARE @ReceivedCapacityPalatesCriteria NVARCHAR(50)
	DECLARE @LoadNumber NVARCHAR(150)
	DECLARE @LoadNumberCriteria NVARCHAR(50)
	DECLARE @ProductCode NVARCHAR(max)
	DECLARE @ProductSearchCriteria NVARCHAR(100)
	DECLARE @TruckSize NVARCHAR(150)
	DECLARE @TruckSizeCriteria NVARCHAR(50)
	DECLARE @ProductCodeData NVARCHAR(150)
	DECLARE @ProductCodeCriteria NVARCHAR(50)
	DECLARE @ProductName NVARCHAR(150)
	DECLARE @ProductNameCriteria NVARCHAR(50)
	DECLARE @ProductQuantity NVARCHAR(150)
	DECLARE @ProductQuantityCriteria NVARCHAR(50)
	DECLARE @Description1 NVARCHAR(150)
	DECLARE @Description1Criteria NVARCHAR(50)
	DECLARE @Description2 NVARCHAR(150)
	DECLARE @Description2Criteria NVARCHAR(50)
	DECLARE @CarrierNumber NVARCHAR(150)
	DECLARE @CarrierNumberCriteria NVARCHAR(50)
	DECLARE @Province NVARCHAR(150)
	DECLARE @ProvinceCriteria NVARCHAR(50)
	DECLARE @OrderedBy NVARCHAR(150)
	DECLARE @OrderedByCriteria NVARCHAR(50)
	DECLARE @IsRPMPresent NVARCHAR(150)
	DECLARE @IsRPMPresentCriteria NVARCHAR(50)
	DECLARE @TruckOutTime NVARCHAR(150)
	DECLARE @TruckOutTimeCriteria NVARCHAR(50)
	DECLARE @AllocatedPlateNo NVARCHAR(150)
	DECLARE @AllocatedPlateNoCriteria NVARCHAR(50)
	DECLARE @DeliveryLocationName NVARCHAR(150)
	DECLARE @DeliveryLocationNameCriteria NVARCHAR(50)
	DECLARE @PlateNumberData NVARCHAR(150)
	DECLARE @PlateNumberDataCriteria NVARCHAR(50)
	DECLARE @CarrierNumberValue NVARCHAR(150)
	DECLARE @CarrierNumberValueCriteria NVARCHAR(50)
	DECLARE @TripCost NVARCHAR(150)
	DECLARE @TripCostCriteria NVARCHAR(50)
	DECLARE @TripRevenue NVARCHAR(150)
	DECLARE @TripRevenueCriteria NVARCHAR(50)
	DECLARE @DriverName NVARCHAR(150)
	DECLARE @DriverNameCriteria NVARCHAR(50)
	DECLARE @PlateNumber NVARCHAR(150)
	DECLARE @PlateNumberCriteria NVARCHAR(50)
	DECLARE @TripProfit NVARCHAR(150)
	DECLARE @TripProfitPerCent NVARCHAR(150)
	DECLARE @PaymentAdvanceAmount NVARCHAR(150)
	DECLARE @PaymentRequestDate NVARCHAR(150)
	DECLARE @PaymentRequestStatus NVARCHAR(150)
	DECLARE @BillingStatus NVARCHAR(150)
	DECLARE @BillingCreditedAmount NVARCHAR(150)
	DECLARE @BillingCreditedAmountStatus NVARCHAR(150)
	DECLARE @BillingCreditedAmountDate NVARCHAR(150)
	DECLARE @BalanceAmount NVARCHAR(150)
	DECLARE @BalAmtStatus NVARCHAR(150)
	DECLARE @BalanceAmountDate NVARCHAR(150)
	DECLARE @TripProfitCriteria NVARCHAR(50)
	DECLARE @TripProfitPerCentCriteria NVARCHAR(50)
	DECLARE @PaymentAdvanceAmountCriteria NVARCHAR(50)
	DECLARE @PaymentRequestDateCriteria NVARCHAR(50)
	DECLARE @PaymentRequestStatusCriteria NVARCHAR(50)
	DECLARE @BillingStatusCriteria NVARCHAR(50)
	DECLARE @BillingCreditedAmountCriteria NVARCHAR(50)
	DECLARE @BillingCreditedAmountStatusCriteria NVARCHAR(50)
	DECLARE @BillingCreditedAmountDateCriteria NVARCHAR(50)
	DECLARE @BalanceAmountCriteria NVARCHAR(50)
	DECLARE @BalAmtStatusCriteria NVARCHAR(50)
	DECLARE @BalanceAmountDateCriteria NVARCHAR(50)
	DECLARE @OrderAttentionNeededFilter NVARCHAR(10)
	DECLARE @IsExportToExcel NVARCHAR(2) = '0'
	DECLARE @PaginationClause NVARCHAR(max)
	DECLARE @Shift NVARCHAR(150)
	DECLARE @ShiftCriteria NVARCHAR(50)
	DECLARE @ReceivedCapacityPalettes NVARCHAR(150)
	DECLARE @ReceivedCapacityPalettesCriteria NVARCHAR(50)
	DECLARE @TotalPrice NVARCHAR(50)
	DECLARE @TotalPriceCriteria NVARCHAR(50)


	SET @PaginationClause = ''
	SET @whereClause = ''

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT @SalesOrderNumber = tmp.[SalesOrderNumber]
		,@SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria]
		,@OrderNumber = tmp.[OrderNumber]
		,@OrderNumberCriteria = tmp.[OrderNumberCriteria]
		,@DriverName = tmp.[DriverName]
		,@DriverNameCriteria = tmp.[DriverNameCriteria]
		,@PurchaseOrderNumber = tmp.[PurchaseOrderNumber]
		,@PurchaseOrderNumberCriteria = tmp.[PurchaseOrderNumberCriteria]
		,@EnquiryAutoNumber = tmp.[EnquiryAutoNumber]
		,@EnquiryAutoNumberCriteria = tmp.[EnquiryAutoNumberCriteria]
		,@SupplierName = tmp.[SupplierName]
		,@SupplierNameCriteria = tmp.[SupplierNameCriteria]
		,@BranchPlant = tmp.[BranchPlant]
		,@BranchPlantCriteria = tmp.[BranchPlantCriteria]
		,@DeliveryLocationName = tmp.[DeliveryLocationName]
		,@DeliveryLocationNameCriteria = tmp.[DeliveryLocationNameCriteria]
		,@PlateNumberData = tmp.[PlateNumberData]
		,@PlateNumberDataCriteria = tmp.[PlateNumberDataCriteria]
		,@CollectedDate = tmp.[CollectedDate]
		,@CollectedDateCriteria = tmp.[CollectedDateCriteria]
		,@DeliveredDate = tmp.[DeliveredDate]
		,@DeliveredCriteria = tmp.[DeliveredCriteria]
		,@ApprovedBy = tmp.ApprovedBy
		,@ApprovedByCriteria = tmp.ApprovedByCriteria
		,@PlanCollectionDate = tmp.[PlanCollectionDate]
		,@PlanCollectionDateCriteria = tmp.[PlanCollectionDateCriteria]

		,@PlanCollectionEndDate = tmp.[PlanCollectionEndDate]
		,@PlanCollectionEndDateCriteria = tmp.[PlanCollectionEndDateCriteria]


		,@PlanDeliveryDate = tmp.[PlanDeliveryDate]
		,@PlanDeliveryDateCriteria = tmp.[PlanDeliveryDateCriteria]

		,@PlanDeliveryEndDate = tmp.[PlanDeliveryEndDate]
		,@PlanDeliveryEndDateCriteria = tmp.[PlanDeliveryEndDateCriteria]

		,@EnquiryDate = tmp.[EnquiryDate]
		,@EnquiryDateCriteria = tmp.[EnquiryDateCriteria]
		,@EnquiryEndDate = tmp.[EnquiryEndDate]
		,@EnquiryEndDateCriteria = tmp.[EnquiryEndDateCriteria]
		,@LoginId = tmp.[LoginId]
		,@BranchPlantCode = tmp.[BranchPlantCode]
		,@BranchPlantCodeCriteria = tmp.[BranchPlantCodeCriteria]
		,@BranchPlantName = tmp.[BranchPlantName]
		,@BranchPlantNameCriteria = tmp.[BranchPlantNameCriteria]
		,@PlateNumber = tmp.[PlateNumber]
		,@PlateNumberCriteria = tmp.[PlateNumberCriteria]
		,@DeliveryLocation = tmp.[DeliveryLocation]
		,@DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria]
		,@ShortName = tmp.[ShortName]
		,@ShortNameCriteria = tmp.[ShortNameCriteria]
		,@Gratis = tmp.[Gratis]
		,@GratisCriteria = tmp.[GratisCriteria]
		,@Status = tmp.[Status]
		,@StatusCriteria = tmp.[StatusCriteria]
		,@PickShift = tmp.[PickShift]
		,@PickShiftCriteria = tmp.[PickShiftCriteria]
		,@SchedulingDate = tmp.[SchedulingDate]
		,@SchedulingDateCriteria = tmp.[SchedulingDateCriteria]
		,@OrderType = tmp.[OrderType]
		,@OrderTypeCriteria = tmp.[OrderTypeCriteria]
		,@PageSize = tmp.[PageSize]
		,@PageIndex = tmp.[PageIndex]
		,@OrderBy = tmp.[OrderBy]
		,@roleId = tmp.[RoleMasterId]
		,@OrderDate = tmp.[OrderDate]
		,@OrderDateCriteria = tmp.[OrderDateCriteria]

		,@OrderEndDate = tmp.[OrderEndDate]
		,@OrderEndDateCriteria = tmp.[OrderEndDateCriteria]

		,@PickUpDate = tmp.[PickUpDate]
		,@PickupDateDate = tmp.[PickupDateDate]
		,@PickupDateCriteria = tmp.[PickupDateCriteria]

		,@PickupDateEndDate = tmp.[PickupDateEndDate]
		,@PickupDateEndDateCriteria = tmp.[PickupDateEndDateCriteria]

		,@PromisedDate = tmp.[PromisedDate]
		,@PromisedDateCriteria  = tmp.[PromisedDateCriteria]
		,@PromisedEndDate = tmp.[PromisedEndDate]
		,@PromisedEndDateCriteria = tmp.[PromisedEndDateCriteria]

		,@ConfirmedPickUpDate = tmp.[ConfirmedPickUpDate]
		,@ConfirmedPickUpDateCriteria = tmp.[ConfirmedPickUpDateCriteria]
		,@TruckSize = tmp.[TruckSize]
		,@TruckSizeCriteria = tmp.[TruckSizeCriteria]
		,@CompanyNameValue = tmp.[CompanyNameValue]
		,@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria]
		,@ShortCompanyName = tmp.[ShortCompanyName]
		,@ShortCompanyNameCriteria = tmp.[ShortCompanyNameCriteria]
		,@ProductCode = [ProductCode]
		,@ProductSearchCriteria = [ProductSearchCriteria]
		,@LoadNumber = tmp.[LoadNumber]
		,@LoadNumberCriteria = tmp.[LoadNumberCriteria]
		,@UserName = [UserName]
		,@UserNameCriteria = [UserNameCriteria]
		,@Empties = tmp.[Empties]
		,@CultureId = [CultureId]
		,@EmptiesCriteria = tmp.[EmptiesCriteria]
		,@statusForChangeInPickShift = tmp.[StatusForChangeInPickShift]
		,@statusForChangeInPickShiftCriteria = tmp.[StatusForChangeInPickShiftCriteria]
		,@ReceivedCapacityPalates = tmp.[ReceivedCapacityPalates]
		,@ReceivedCapacityPalatesCriteria = tmp.[ReceivedCapacityPalatesCriteria]
		,@ProductCodeData = tmp.[ProductCodeData]
		,@ProductCodeCriteria = tmp.[ProductCodeCriteria]
		,@ProductName = tmp.[ProductName]
		,@ProductNameCriteria = tmp.[ProductName]
		,@ProductQuantity = tmp.[ProductQuantity]
		,@ProductQuantityCriteria = tmp.[ProductQuantityCriteria]
		,@Description1 = tmp.[Description1]
		,@Description1Criteria = tmp.[Description1Criteria]
		,@Description2 = tmp.[Description2]
		,@Description2Criteria = tmp.[Description2Criteria]
		,@Province = tmp.[Province]
		,@ProvinceCriteria = tmp.[ProvinceCriteria]
		,@OrderedBy = tmp.[OrderedBy]
		,@OrderedByCriteria = tmp.[OrderedByCriteria]
		,@IsRPMPresent = tmp.[IsRPMPresent]
		,@IsRPMPresentCriteria = tmp.[IsRPMPresentCriteria]
		,@CarrierNumber = tmp.[CarrierNumber]
		,@CarrierNumberCriteria = tmp.[CarrierNumberCriteria]
		,@TruckOutTime = tmp.TruckOutTime
		,@TruckOutTimeCriteria = tmp.TruckOutTimeCriteria
		,@TripCost = tmp.[TripCost]
		,@TripCostCriteria = tmp.[TripCostCriteria]
		,@TripRevenue = tmp.[TripRevenue]
		,@TripRevenueCriteria = tmp.[TripRevenueCriteria]
		,@AllocatedPlateNo = tmp.AllocatedPlateNo
		,@AllocatedPlateNoCriteria = tmp.AllocatedPlateNoCriteria
		,@CarrierNumberValue = tmp.[CarrierNumberValue]
		,@CarrierNumberValueCriteria = tmp.[CarrierNumberValueCriteria]
		,@userId = tmp.[UserId]
		,@PageName = tmp.[PageName]
		,@TripProfit = tmp.[TripProfit]
		,@TripProfitPerCent = tmp.[TripProfitPerCent]
		,@PaymentAdvanceAmount = tmp.[PaymentAdvanceAmount]
		,@PaymentRequestDate = tmp.[PaymentRequestDate]
		,@PaymentRequestStatus = tmp.[PaymentRequestStatus]
		,@BillingStatus = tmp.[BillingStatus]
		,@BillingCreditedAmount = tmp.[BillingCreditedAmount]
		,@BillingCreditedAmountStatus = tmp.[BillingCreditedAmountStatus]
		,@BillingCreditedAmountDate = tmp.[BillingCreditedAmountDate]
		,@BalanceAmount = tmp.[BalanceAmount]
		,@BalAmtStatus = tmp.[BalAmtStatus]
		,@BalanceAmountDate = tmp.[BalanceAmountDate]
		,@TripProfitCriteria = tmp.[TripProfitCriteria]
		,@TripProfitPerCentCriteria = tmp.[TripProfitPerCentCriteria]
		,@PaymentAdvanceAmountCriteria = tmp.[PaymentAdvanceAmountCriteria]
		,@PaymentRequestDateCriteria = tmp.[PaymentRequestDateCriteria]
		,@PaymentRequestStatusCriteria = tmp.[PaymentRequestStatusCriteria]
		,@BillingStatusCriteria = tmp.[BillingStatusCriteria]
		,@BillingCreditedAmountCriteria = tmp.[BillingCreditedAmountCriteria]
		,@BillingCreditedAmountStatusCriteria = tmp.[BillingCreditedAmountStatusCriteria]
		,@BillingCreditedAmountDateCriteria = tmp.[BillingCreditedAmountDateCriteria]
		,@BalanceAmountCriteria = tmp.[BalanceAmountCriteria]
		,@BalAmtStatusCriteria = tmp.[BalAmtStatusCriteria]
		,@BalanceAmountDateCriteria = tmp.[BalanceAmountDateCriteria]
		,@OrderAttentionNeededFilter = tmp.[OrderAttentionNeededFilter]
		,@PageControlName = tmp.[PageControlName]
        ,@Shift = tmp.[Shift]
        ,@ShiftCriteria = tmp.ShiftCriteria

		 ,@ReceivedCapacityPalettes = tmp.[ReceivedCapacityPalettes]
        ,@ReceivedCapacityPalettesCriteria = tmp.ReceivedCapacityPalettesCriteria


		,@TotalPrice = tmp.TotalPrice
	    ,@TotalPriceCriteria = tmp.TotalPriceCriteria

	FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[PageIndex] INT
			,[PageSize] INT
			,[OrderBy] NVARCHAR(2000)
			,[SalesOrderNumber] NVARCHAR(150)
			,[SalesOrderNumberCriteria] NVARCHAR(50)
			,[DriverName] NVARCHAR(150)
			,[DriverNameCriteria] NVARCHAR(50)
			,[PlateNumber] NVARCHAR(150)
			,[PlateNumberCriteria] NVARCHAR(50)
			,[TripCost] NVARCHAR(150)
			,[TripCostCriteria] NVARCHAR(50)
			,[TripRevenue] NVARCHAR(150)
			,[TripRevenueCriteria] NVARCHAR(50)
			,[PlateNumberData] NVARCHAR(150)
			,[PlateNumberDataCriteria] NVARCHAR(50)
			,[DeliveryLocationName] NVARCHAR(150)
			,[DeliveryLocationNameCriteria] NVARCHAR(50)
			,[CarrierNumberValue] NVARCHAR(150)
			,[CarrierNumberValueCriteria] NVARCHAR(50)
			,[OrderNumber] NVARCHAR(150)
			,[OrderNumberCriteria] NVARCHAR(50)
			,[PurchaseOrderNumber] NVARCHAR(150)
			,[PurchaseOrderNumberCriteria] NVARCHAR(50)
			,[EnquiryAutoNumber] NVARCHAR(150)
			,[EnquiryAutoNumberCriteria] NVARCHAR(50)
			,[BranchPlant] NVARCHAR(150)
			,[BranchPlantCriteria] NVARCHAR(50)
			,[BranchPlantCode] NVARCHAR(150)
			,[BranchPlantCodeCriteria] NVARCHAR(50)
			,[ShortName] NVARCHAR(150)
			,[ShortNameCriteria] NVARCHAR(150)
			,[BranchPlantName] NVARCHAR(150)
			,[BranchPlantNameCriteria] NVARCHAR(50)
			,[DeliveryLocation] NVARCHAR(150)
			,[DeliveryLocationCriteria] NVARCHAR(50)
			,[SchedulingDate] NVARCHAR(150)
			,[SchedulingDateCriteria] NVARCHAR(50)
			,[OrderType] NVARCHAR(50)
			,[OrderTypeCriteria] NVARCHAR(250)
			,[Gratis] NVARCHAR(150)
			,[GratisCriteria] NVARCHAR(50)
			,[Status] NVARCHAR(150)
			,[StatusCriteria] NVARCHAR(50)
			,SupplierName NVARCHAR(150)
			,SupplierNameCriteria NVARCHAR(50)
			,[PickShift] NVARCHAR(50)
			,[PickShiftCriteria] NVARCHAR(50)
			,[RoleMasterId] BIGINT
			,[OrderDate] NVARCHAR(150)
			,[OrderDateCriteria] NVARCHAR(50)
			,[OrderEndDate] nvarchar(150)
			,[OrderEndDateCriteria] nvarchar(50)

			,[PickupDateDate] NVARCHAR(150)
			,[PickupDateCriteria] NVARCHAR(50)
			,[PickupDateEndDate] nvarchar(150)
			,[PickupDateEndDateCriteria] nvarchar(50)
					,ApprovedBy NVARCHAR(150)
			,ApprovedByCriteria NVARCHAR(50)
			,[PromisedDate] NVARCHAR(150)
			,[PromisedDateCriteria] NVARCHAR(50)
			,[PromisedEndDate] nvarchar(150)
			,[PromisedEndDateCriteria] nvarchar(50)

			,[CollectedDate] NVARCHAR(150)
			,[CollectedDateCriteria] NVARCHAR(50)
			,[DeliveredDate] NVARCHAR(150)
			,[DeliveredCriteria] NVARCHAR(50)
			,[EnquiryDate] NVARCHAR(150)
			,[EnquiryDateCriteria] NVARCHAR(150)

			,[EnquiryEndDate] NVARCHAR(150)
			,[EnquiryEndDateCriteria] NVARCHAR(150)

			,[PlanCollectionDate] NVARCHAR(150)
			,[PlanCollectionDateCriteria] NVARCHAR(50)


			,[PlanCollectionEndDate] NVARCHAR(150)
			,[PlanCollectionEndDateCriteria] NVARCHAR(50)

			,[PlanDeliveryDate] NVARCHAR(150)
			,[PlanDeliveryDateCriteria] NVARCHAR(50)

			,[PlanDeliveryEndDate] NVARCHAR(150)
			,[PlanDeliveryEndDateCriteria] NVARCHAR(50)

			,[LoadNumber] NVARCHAR(150)
			,[LoadNumberCriteria] NVARCHAR(50)
			,[PickUpDate] NVARCHAR(150)
			
			,ConfirmedPickUpDate NVARCHAR(150)
			,ConfirmedPickUpDateCriteria NVARCHAR(150)
			,[CompanyNameValue] NVARCHAR(150)
			,[CompanyNameValueCriteria] NVARCHAR(50)
			,[ShortCompanyName] nvarchar(150)
			,[ShortCompanyNameCriteria] nvarchar(50)
			,[TruckSize] NVARCHAR(150)
			,[TruckSizeCriteria] NVARCHAR(50)
			,[UserName] NVARCHAR(150)
			,[UserNameCriteria] NVARCHAR(50)
			,[ProductCode] NVARCHAR(500)
			,[ProductSearchCriteria] NVARCHAR(100)
			,[Empties] NVARCHAR(150)
			,[CultureId] BIGINT
			,[EmptiesCriteria] NVARCHAR(150)
			,[ReceivedCapacityPalates] NVARCHAR(150)
			,[ReceivedCapacityPalatesCriteria] NVARCHAR(150)
			,[ProductCodeData] NVARCHAR(150)
			,[ProductCodeCriteria] NVARCHAR(50)
			,[ProductName] NVARCHAR(150)
			,[ProductNameCriteria] NVARCHAR(50)
			,[ProductQuantity] NVARCHAR(150)
			,[ProductQuantityCriteria] NVARCHAR(50)
			,Description1 NVARCHAR(50)
			,Description1Criteria NVARCHAR(50)
			,Description2 NVARCHAR(50)
			,Description2Criteria NVARCHAR(50)
			,[CarrierNumber] NVARCHAR(50)
			,[CarrierNumberCriteria] NVARCHAR(150)
			,[Province] NVARCHAR(150)
			,[ProvinceCriteria] NVARCHAR(50)
			,[OrderedBy] NVARCHAR(150)
			,[OrderedByCriteria] NVARCHAR(50)
			,StatusForChangeInPickShift NVARCHAR(150)
			,StatusForChangeInPickShiftCriteria NVARCHAR(50)
			,[IsRPMPresent] NVARCHAR(150)
			,[IsRPMPresentCriteria] NVARCHAR(50)
			,[TruckOutTime] NVARCHAR(150)
			,[TruckOutTimeCriteria] NVARCHAR(50)
			,[AllocatedPlateNo] NVARCHAR(150)
			,[AllocatedPlateNoCriteria] NVARCHAR(50)
			,[TripProfit] NVARCHAR(150)
			,[TripProfitPerCent] NVARCHAR(150)
			,[PaymentAdvanceAmount] NVARCHAR(150)
			,[PaymentRequestDate] NVARCHAR(150)
			,[PaymentRequestStatus] NVARCHAR(150)
			,[BillingStatus] NVARCHAR(150)
			,[BillingCreditedAmount] NVARCHAR(150)
			,[BillingCreditedAmountStatus] NVARCHAR(150)
			,[BillingCreditedAmountDate] NVARCHAR(150)
			,[BalanceAmount] NVARCHAR(150)
			,[BalAmtStatus] NVARCHAR(150)
			,[BalanceAmountDate] NVARCHAR(150)
			,[TripProfitCriteria] NVARCHAR(50)
			,[TripProfitPerCentCriteria] NVARCHAR(50)
			,[PaymentAdvanceAmountCriteria] NVARCHAR(50)
			,[PaymentRequestDateCriteria] NVARCHAR(50)
			,[PaymentRequestStatusCriteria] NVARCHAR(50)
			,[BillingStatusCriteria] NVARCHAR(50)
			,[BillingCreditedAmountCriteria] NVARCHAR(50)
			,[BillingCreditedAmountStatusCriteria] NVARCHAR(50)
			,[BillingCreditedAmountDateCriteria] NVARCHAR(50)
			,[BalanceAmountCriteria] NVARCHAR(50)
			,[BalAmtStatusCriteria] NVARCHAR(50)
			,[BalanceAmountDateCriteria] NVARCHAR(50)
			,[UserId] BIGINT
			,[LoginId] BIGINT
			,[PageName] NVARCHAR(50)
			,[OrderAttentionNeededFilter] NVARCHAR(10)
			,[PageControlName] NVARCHAR(250)
            ,[Shift] NVARCHAR(150)
	        ,ShiftCriteria NVARCHAR(50)

			            ,[ReceivedCapacityPalettes] NVARCHAR(150)
	        ,ReceivedCapacityPalettesCriteria NVARCHAR(50)

			  ,TotalPrice NVARCHAR(50)

	        ,TotalPriceCriteria NVARCHAR(50)
			) tmp

	IF (RTRIM(@orderBy) = '')
	BEGIN
		SET @orderBy = 'PraposedTimeOfAction desc'
	END

	IF (RTRIM(@whereClause) = '')
	BEGIN
		SET @whereClause = '1=1'
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

	IF @SalesOrderNumber != ''
	BEGIN
		IF @SalesOrderNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''%' + @SalesOrderNumber + '%'''
		END

		IF @SalesOrderNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber NOT LIKE ''%' + @SalesOrderNumber + '%'''
		END

		IF @SalesOrderNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''' + @SalesOrderNumber + '%'''
		END

		IF @SalesOrderNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''%' + @SalesOrderNumber + ''''
		END

		IF @SalesOrderNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber =  ''' + @SalesOrderNumber + ''''
		END

		IF @SalesOrderNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber <>  ''' + @SalesOrderNumber + ''''
		END
	END






	IF @DriverName != ''
	BEGIN
		IF @DriverNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName LIKE ''%' + @DriverName + '%'''
		END

		IF @DriverNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName NOT LIKE ''%' + @DriverName + '%'''
		END

		IF @DriverNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName LIKE ''' + @DriverName + '%'''
		END

		IF @DriverNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName LIKE ''%' + @DriverName + ''''
		END

		IF @DriverNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName =  ''' + @DriverName + ''''
		END

		IF @DriverNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and DriverName <>  ''' + @DriverName + ''''
		END
	END

	IF @PlateNumber != ''
	BEGIN
		IF @PlateNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber LIKE ''%' + @PlateNumber + '%'''
		END

		IF @PlateNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber NOT LIKE ''%' + @PlateNumber + '%'''
		END

		IF @PlateNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber LIKE ''' + @PlateNumber + '%'''
		END

		IF @PlateNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber LIKE ''%' + @PlateNumber + ''''
		END

		IF @PlateNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber =  ''' + @PlateNumber + ''''
		END

		IF @PlateNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumber <>  ''' + @PlateNumber + ''''
		END
	END

	IF @OrderNumber != ''
	BEGIN
		IF @OrderNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber LIKE ''%' + @OrderNumber + '%'''
		END

		IF @OrderNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber NOT LIKE ''%' + @OrderNumber + '%'''
		END

		IF @OrderNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber LIKE ''' + @OrderNumber + '%'''
		END

		IF @OrderNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber LIKE ''%' + @OrderNumber + ''''
		END

		IF @OrderNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber =  ''' + @OrderNumber + ''''
		END

		IF @OrderNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderNumber <>  ''' + @OrderNumber + ''''
		END
	END


		IF @ReceivedCapacityPalettes != ''
	BEGIN
		IF @ReceivedCapacityPalettesCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes LIKE ''%' + @ReceivedCapacityPalettes + '%'''
		END

		IF @ReceivedCapacityPalettesCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes NOT LIKE ''%' + @ReceivedCapacityPalettes + '%'''
		END

		IF @ReceivedCapacityPalettesCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes LIKE ''' + @ReceivedCapacityPalettes + '%'''
		END

		IF @ReceivedCapacityPalettesCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes LIKE ''%' + @ReceivedCapacityPalettes + ''''
		END

		IF @ReceivedCapacityPalettesCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes =  ''' + @ReceivedCapacityPalettes + ''''
		END

		IF @ReceivedCapacityPalettesCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and ReceivedCapacityPalettes <>  ''' + @ReceivedCapacityPalettes + ''''
		END
	END



	IF @PlateNumberData != ''
	BEGIN
		IF @PlateNumberDataCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @PlateNumberData + '%'''
		END

		IF @PlateNumberDataCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData NOT LIKE ''%' + @PlateNumberData + '%'''
		END

		IF @PlateNumberDataCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''' + @PlateNumberData + '%'''
		END

		IF @PlateNumberDataCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @PlateNumberData + ''''
		END

		IF @PlateNumberDataCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData =  ''' + @PlateNumberData + ''''
		END

		IF @PlateNumberDataCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData <>  ''' + @PlateNumberData + ''''
		END
	END

	IF @DeliveryLocationName != ''
	BEGIN
		IF @DeliveryLocationNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName LIKE ''%' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName NOT LIKE ''%' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName LIKE ''' + @DeliveryLocationName + '%'''
		END

		IF @DeliveryLocationNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName LIKE ''%' + @DeliveryLocationName + ''''
		END

		IF @DeliveryLocationNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName =  ''' + @DeliveryLocationName + ''''
		END

		IF @DeliveryLocationNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and LocationName <>  ''' + @DeliveryLocationName + ''''
		END
	END

	IF @Empties != ''
	BEGIN
		SET @whereClause = @whereClause + ' and (case when (c.ActualEmpties < 0) then ''C'' else ''W'' end) =  ''' + @Empties + ''''
	END

	IF @statusForChangeInPickShift != ''
	BEGIN
		SET @whereClause = @whereClause + ' and (case when  PraposedTimeOfAction != ExpectedTimeOfAction or PraposedShift != ExpectedShift then ''1'' else ''0'' end) =  ''' + @statusForChangeInPickShift + ''''
	END

	IF @ReceivedCapacityPalates != ''
	BEGIN
		SET @whereClause = @whereClause + 
			' and (case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) < 0) then ''0'' else ''1'' end) =  ''' + 
			@ReceivedCapacityPalates + ''''
	END

	IF @PurchaseOrderNumber != ''
	BEGIN
		IF @PurchaseOrderNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''%' + @PurchaseOrderNumber + '%'''
		END

		IF @PurchaseOrderNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber NOT LIKE ''%' + @PurchaseOrderNumber + '%'''
		END

		IF @PurchaseOrderNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''' + @PurchaseOrderNumber + '%'''
		END

		IF @PurchaseOrderNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''%' + @PurchaseOrderNumber + ''''
		END

		IF @PurchaseOrderNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber =  ''' + @PurchaseOrderNumber + ''''
		END

		IF @PurchaseOrderNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and PurchaseOrderNumber <>  ''' + @PurchaseOrderNumber + ''''
		END
	END

	IF @CarrierNumberValue != ''
	BEGIN
		IF @CarrierNumberValueCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''%' + @CarrierNumberValue + '%'''
		END

		IF @CarrierNumberValueCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue NOT LIKE ''%' + @CarrierNumberValue + '%'''
		END

		IF @CarrierNumberValueCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''' + @CarrierNumberValue + '%'''
		END

		IF @CarrierNumberValueCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''%' + @CarrierNumberValue + ''''
		END

		IF @CarrierNumberValueCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue =  ''' + @CarrierNumberValue + ''''
		END

		IF @CarrierNumberValueCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and CarrierNumberValue <>  ''' + @CarrierNumberValue + ''''
		END
	END



	---------------------------------Payment-------------------------------
	IF @TripProfit != ''
	BEGIN
		IF @TripProfitCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfit = ''' + @TripProfit + ''''
		END
		ELSE IF @TripProfitCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfit > ''' + @TripProfit + ''''
		END
		ELSE IF @TripProfitCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfit < ''' + @TripProfit + ''''
		END
	END

	IF @TripProfitPerCent != ''
	BEGIN
		IF @TripProfitPerCentCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfitPerCent = ''' + @TripProfitPerCent + ''''
		END
		ELSE IF @TripProfitPerCentCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfitPerCent > ''' + @TripProfitPerCent + ''''
		END
		ELSE IF @TripProfitPerCentCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and TripProfitPerCent < ''' + @TripProfitPerCent + ''''
		END
	END

	IF @PaymentAdvanceAmount != ''
	BEGIN
		IF @PaymentAdvanceAmountCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentAdvanceAmount = ''' + @PaymentAdvanceAmount + ''''
		END
		ELSE IF @PaymentAdvanceAmountCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentAdvanceAmount > ''' + @PaymentAdvanceAmount + ''''
		END
		ELSE IF @PaymentAdvanceAmountCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentAdvanceAmount < ''' + @PaymentAdvanceAmount + ''''
		END
	END

	IF @BillingCreditedAmount != ''
	BEGIN
		IF @BillingCreditedAmountCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmount = ''' + @BillingCreditedAmount + ''''
		END
		ELSE IF @BillingCreditedAmountCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmount > ''' + @BillingCreditedAmount + ''''
		END
		ELSE IF @BillingCreditedAmountCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmount < ''' + @BillingCreditedAmount + ''''
		END
	END

	IF @BalanceAmount != ''
	BEGIN
		IF @BalanceAmountCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BalanceAmountCriteria = ''' + @BalanceAmount + ''''
		END
		ELSE IF @BalanceAmountCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and BalanceAmountCriteria > ''' + @BalanceAmount + ''''
		END
		ELSE IF @BalanceAmountCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and BalanceAmountCriteria < ''' + @BalanceAmount + ''''
		END
	END

	-------------------------Date Section
	IF @PaymentRequestDate != ''
	BEGIN
		IF @PaymentRequestDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PaymentRequestDate,103) = CONVERT(date,''' + @PaymentRequestDate + ''',103)'
		END
		ELSE IF @PaymentRequestDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PaymentRequestDate,103) > DATEADD(DAY,-1,CONVERT(date,''' + @PaymentRequestDate + ''',103))'
		END
		ELSE IF @PaymentRequestDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PaymentRequestDate,103) < CONVERT(date,''' + @PaymentRequestDate + ''',103)'
		END
	END

	IF @BillingCreditedAmountDate != ''
	BEGIN
		IF @BillingCreditedAmountDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BillingCreditedAmountDate,103) = CONVERT(date,''' + @BillingCreditedAmountDate + ''',103)'
		END
		ELSE IF @BillingCreditedAmountDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BillingCreditedAmountDate,103) > DATEADD(DAY,-1,CONVERT(date,''' + @BillingCreditedAmountDate + ''',103))'
		END
		ELSE IF @BillingCreditedAmountDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BillingCreditedAmountDate,103) < CONVERT(date,''' + @BillingCreditedAmountDate + ''',103)'
		END
	END

	IF @BalanceAmountDate != ''
	BEGIN
		IF @BalanceAmountDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BalanceAmountDate,103) = CONVERT(date,''' + @BalanceAmountDate + ''',103)'
		END
		ELSE IF @BalanceAmountDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BalanceAmountDate,103) > DATEADD(DAY,-1,CONVERT(date,''' + @BalanceAmountDate + ''',103))'
		END
		ELSE IF @BalanceAmountDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,BalanceAmountDate,103) < CONVERT(date,''' + @BalanceAmountDate + ''',103)'
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
			SET @whereClause = @whereClause + ' and CONVERT(date,EnquiryDate,103) > CONVERT(date,''' + @EnquiryDate + ''',103)'
		END
		ELSE IF @EnquiryDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,EnquiryDate,103) < CONVERT(date,''' + @EnquiryDate + ''',103)'
		END
	END

	----------------------------------------Status Section--------------------------------
	IF @PaymentRequestStatus != ''
	BEGIN
		IF @PaymentRequestStatusCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus LIKE ''%' + @PaymentRequestStatus + '%'''
		END

		IF @PaymentRequestStatusCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus NOT LIKE ''%' + @PaymentRequestStatus + '%'''
		END

		IF @PaymentRequestStatusCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus LIKE ''' + @PaymentRequestStatus + '%'''
		END

		IF @PaymentRequestStatusCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus LIKE ''%' + @PaymentRequestStatus + ''''
		END

		IF @PaymentRequestStatusCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus =  ''' + @PaymentRequestStatus + ''''
		END

		IF @PaymentRequestStatusCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and PaymentRequestStatus <>  ''' + @PaymentRequestStatus + ''''
		END
	END

	IF @BillingStatus != ''
	BEGIN
		IF @BillingStatusCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus LIKE ''%' + @BillingStatus + '%'''
		END

		IF @BillingStatusCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus NOT LIKE ''%' + @BillingStatus + '%'''
		END

		IF @BillingStatusCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus LIKE ''' + @BillingStatus + '%'''
		END

		IF @BillingStatusCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus LIKE ''%' + @BillingStatus + ''''
		END

		IF @BillingStatusCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus =  ''' + @BillingStatus + ''''
		END

		IF @BillingStatusCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingStatus <>  ''' + @BillingStatus + ''''
		END
	END

	IF @BillingCreditedAmountStatus != ''
	BEGIN
		IF @BillingCreditedAmountStatusCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus LIKE ''%' + @BillingCreditedAmountStatus + '%'''
		END

		IF @BillingCreditedAmountStatusCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus NOT LIKE ''%' + @BillingCreditedAmountStatus + '%'''
		END

		IF @BillingCreditedAmountStatusCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus LIKE ''' + @BillingCreditedAmountStatus + '%'''
		END

		IF @BillingCreditedAmountStatusCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus LIKE ''%' + @BillingCreditedAmountStatus + ''''
		END

		IF @BillingCreditedAmountStatusCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus =  ''' + @BillingCreditedAmountStatus + ''''
		END

		IF @BillingCreditedAmountStatusCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and BillingCreditedAmountStatus <>  ''' + @BillingCreditedAmountStatus + ''''
		END
	END

	IF @BalAmtStatus != ''
	BEGIN
		IF @BalAmtStatusCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus LIKE ''%' + @BalAmtStatus + '%'''
		END

		IF @BalAmtStatusCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus NOT LIKE ''%' + @BalAmtStatus + '%'''
		END

		IF @BalAmtStatusCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus LIKE ''' + @BalAmtStatus + '%'''
		END

		IF @BalAmtStatusCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus LIKE ''%' + @BalAmtStatus + ''''
		END

		IF @BalAmtStatusCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus =  ''' + @BalAmtStatus + ''''
		END

		IF @BalAmtStatusCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and BalAmtStatus <>  ''' + @BalAmtStatus + ''''
		END
	END

	---------------------------------END-----------------------------------
	IF @TripCost != ''
	BEGIN
		IF @TripCostCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and TripCost = ''' + @TripCost + ''''
		END
		ELSE IF @TripCostCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and TripCost > ''' + @TripCost + ''''
		END
		ELSE IF @TripCostCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and TripCost < ''' + @TripCost + ''''
		END
	END

	IF @TripRevenue != ''
	BEGIN
		IF @TripRevenueCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and TripRevenue = ''' + @TripRevenue + ''''
		END
		ELSE IF @TripRevenueCriteria = '>'
		BEGIN
			SET @whereClause = @whereClause + ' and TripRevenue > ''' + @TripRevenue + ''''
		END
		ELSE IF @TripRevenueCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and TripRevenue < ''' + @TripRevenue + ''''
		END
	END

	IF @ShortName != ''
	BEGIN
		IF @ShortNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber] ) LIKE ''%' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber] ) NOT LIKE ''%' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber] ) LIKE ''' + @ShortName + '%'''
		END

		IF @ShortNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber] ) LIKE ''%' + @ShortName + ''''
		END

		IF @ShortNameCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber]) =  ''' + @ShortName + ''''
		END

		IF @ShortNameCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and (select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber]) <>  ''' + @ShortName + ''''
		END
	END

	IF @EnquiryAutoNumber != ''
	BEGIN
		IF @EnquiryAutoNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''%' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    NOT LIKE ''%' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''' + @EnquiryAutoNumber + '%'''
		END

		IF @EnquiryAutoNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''%' + @EnquiryAutoNumber + ''''
		END

		IF @EnquiryAutoNumberCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    =  ''' + @EnquiryAutoNumber + ''''
		END

		IF @EnquiryAutoNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    <>  ''' + @EnquiryAutoNumber + ''''
		END
	END



	IF @SupplierName != ''
	BEGIN
		IF @SupplierNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    LIKE ''%' + @SupplierName + '%'''
		END

		IF @SupplierNameCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    NOT LIKE ''%' + @SupplierName + '%'''
		END

		IF @SupplierNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    LIKE ''' + @SupplierName + '%'''
		END

		IF @SupplierNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    LIKE ''%' + @SupplierName + ''''
		END

		IF @SupplierNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    =  ''' + @SupplierName + ''''
		END

		IF @SupplierNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and SupplierName    <>  ''' + @SupplierName + ''''
		END
	END

	IF @BranchPlant != ''
	BEGIN
		IF @BranchPlantCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId NOT LIKE ''%' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId LIKE ''' + @BranchPlant + '%'''
		END

		IF @BranchPlantCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlant + ''''
		END

		IF @BranchPlantCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId =  ''' + @BranchPlant + ''''
		END

		IF @BranchPlantCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and StockLocationId <>  ''' + @BranchPlant + ''''
		END
	END

	IF @BranchPlantCode != ''
	BEGIN
		IF @BranchPlantCodeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''%' + @BranchPlantCode + '%'''
		END

		IF @BranchPlantCodeCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode NOT LIKE ''%' + @BranchPlantCode + '%'''
		END

		IF @BranchPlantCodeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''' + @BranchPlantCode + '%'''
		END

		IF @BranchPlantCodeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''%' + @BranchPlantCode + ''''
		END

		IF @BranchPlantCodeCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode =  ''' + @BranchPlantCode + ''''
		END

		IF @BranchPlantCodeCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantCode <>  ''' + @BranchPlantCode + ''''
		END
	END

	IF @BranchPlantName != ''
	BEGIN
		IF @BranchPlantNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName LIKE ''%' + @BranchPlantName + '%'''
		END

		IF @BranchPlantNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName NOT LIKE ''%' + @BranchPlantName + '%'''
		END

		IF @BranchPlantNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName LIKE ''' + @BranchPlantName + '%'''
		END

		IF @BranchPlantNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName LIKE ''%' + @BranchPlantName + ''''
		END

		IF @BranchPlantNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName =  ''' + @BranchPlantName + ''''
		END

		IF @BranchPlantNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and BranchPlantName <>  ''' + @BranchPlantName + ''''
		END
	END

		IF @ApprovedBy != ''
	BEGIN
		IF @ApprovedByCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy LIKE ''%' + @ApprovedBy + '%'''
		END

		IF @ApprovedByCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy NOT LIKE ''%' + @ApprovedBy + '%'''
		END

		IF @ApprovedByCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy LIKE ''' + @ApprovedBy + '%'''
		END

		IF @ApprovedByCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy LIKE ''%' + @ApprovedBy + ''''
		END

		IF @ApprovedByCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy =  ''' + @ApprovedBy + ''''
		END

		IF @ApprovedByCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and ApprovedBy <>  ''' + @ApprovedBy + ''''
		END
	END



	IF @LoadNumber != ''
	BEGIN
		IF @LoadNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and LoadNumber LIKE ''%' + @LoadNumber + '%'''
		END

		IF @LoadNumberCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and LoadNumber NOT LIKE ''%' + @LoadNumber + '%'''
		END

		IF @LoadNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LoadNumber LIKE ''' + @LoadNumber + '%'''
		END

		IF @LoadNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and LoadNumber LIKE ''%' + @LoadNumber + ''''
		END

		IF @LoadNumberCriteria = '='
		BEGIN
			IF @LoadNumber = '0'
			BEGIN
				SET @whereClause = @whereClause + ' and LoadNumber is null '
			END
			ELSE
			BEGIN
				SET @whereClause = @whereClause + ' and LoadNumber =  ''' + @LoadNumber + ''''
			END
		END

		IF @LoadNumberCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and LoadNumber <>  ''' + @LoadNumber + ''''
		END
	END



	IF @DeliveryLocation != ''
	BEGIN
		IF @DeliveryLocationCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode NOT LIKE ''%' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''' + @DeliveryLocation + '%'''
		END

		IF @DeliveryLocationCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocation + ''''
		END

		IF @DeliveryLocationCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode =  ''' + @DeliveryLocation + ''''
		END

		IF @DeliveryLocationCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and DeliveryLocationCode <>  ''' + @DeliveryLocation + ''''
		END
	END

	IF @Status != ''
	BEGIN
		IF @StatusCriteria = '='
		BEGIN
			--SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''
			--SET @whereClause = @whereClause + ' and CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'
			SET @whereClause = @whereClause + ' and CurrentState in (select Statusid from RoleWiseStatus where resourcekey in (select  resourcekey from resources where resourceValue=N''' + @Status + 
				''' and PageName=''status'') and Roleid=' + CONVERT(NVARCHAR(10), @roleId) + ')'
		END
		IF @StatusCriteria = 'in'
		BEGIN
			--SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''
			--SET @whereClause = @whereClause + ' and CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'
			SET @whereClause = @whereClause + ' and CurrentState in (select Statusid from RoleWiseStatus where resourcekey in (select  resourcekey from resources where resourceValue IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] (N''' + CONVERT(NVARCHAR(500), @Status) + ''')) and PageName=''status'') and Roleid=' + CONVERT(NVARCHAR(10), @roleId) + ')'
		END

	END

	IF @PickShift != ''
	BEGIN
		IF @PickShiftCriteria = 'eq'
		BEGIN
			--SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''
			--SET @whereClause = @whereClause + ' and CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'
			SET @whereClause = @whereClause + 
				' and (case when (Select Name from lookup where lookupid=om.ExpectedShift) IS NOT NULL then (Select Name from lookup where lookupid=om.ExpectedShift) else (Select Name from lookup where lookupid=om.PraposedShift) END) = ''' 
				+ @PickShift + ''''
		END
	END

	IF @Gratis != ''
	BEGIN
		IF @GratisCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @Gratis + '%'''
		END

		IF @GratisCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder NOT LIKE ''%' + @Gratis + '%'''
		END

		IF @GratisCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''' + @Gratis + '%'''
		END

		IF @GratisCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @Gratis + ''''
		END

		IF @GratisCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder =  ''' + @Gratis + ''''
		END

		IF @GratisCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and AssociatedOrder <>  ''' + @Gratis + ''''
		END
	END

	IF @SchedulingDate != ''
	BEGIN
		IF @SchedulingDateCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''%' + @SchedulingDate + '%'''
		END

		IF @SchedulingDateCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery NOT LIKE ''%' + @SchedulingDate + '%'''
		END

		IF @SchedulingDateCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''' + @SchedulingDate + '%'''
		END

		IF @SchedulingDateCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''%' + @SchedulingDate + ''''
		END

		IF @SchedulingDateCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ExpectedTimeOfDelivery,103) =  ''' + CONVERT(VARCHAR(11), @SchedulingDate, 103) + ''''
		END

		IF @SchedulingDateCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery <>  ''' + @SchedulingDate + ''''
		END
	END

	IF @OrderDate != ''
	BEGIN
		IF @OrderEndDate != ''
		BEGIN
			if @OrderDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End
			SET @whereClause = @whereClause + ' and CONVERT(date,OrderDate,103) ' +@OrderDateCriteria+ ' CONVERT(date,''' + @OrderDate + ''',103) '+@AndOrCondition+' CONVERT(date,OrderDate,103) ' +@OrderEndDateCriteria+ ' CONVERT(date,''' + @OrderEndDate + ''',103)'
		END
		ELSE IF @OrderDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,OrderDate,103) > DATEADD(DAY,-1,CONVERT(date,''' + @OrderDate + ''',103))'
		END
		ELSE IF @OrderDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,OrderDate,103) < CONVERT(date,''' + @OrderDate + ''',103)'
		END
	END


	IF @PromisedDate != ''
	BEGIN
		IF @PromisedEndDate  != ''
		BEGIN
			if @PromisedDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,ExpectedTimeOfDelivery,103) '+@PromisedDateCriteria+' CONVERT(date,''' + @PromisedDate + ''',103) '+@AndOrCondition+' CONVERT(date,ExpectedTimeOfDelivery,103) '+@PromisedEndDateCriteria+' CONVERT(date,''' + @PromisedEndDate + ''',103)'
		END
		ELSE IF @PromisedDateCriteria  = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,ExpectedTimeOfDelivery,103) > DATEADD(DAY,-1,CONVERT(date,''' + @PromisedDate + ''',103))'
		END
		ELSE IF @PromisedDateCriteria  = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,ExpectedTimeOfDelivery,103) < CONVERT(date,''' + @PromisedDate + ''',103)'
		END
	END



		IF @PickupDateDate != ''
	BEGIN
		IF @PickupDateEndDate != ''
		BEGIN
			if @PickupDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			

			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) ' +@PickupDateCriteria+ ' CONVERT(date,''' + @PickupDateDate + ''',103) ' +@AndOrCondition+ ' CONVERT(date,PickDateTime,103) ' +@PickupDateEndDateCriteria+ ' CONVERT(date,''' + @PickupDateEndDate + ''',103)'

						

		END
		ELSE IF @PickUpDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) > DATEADD(DAY,-1,CONVERT(date,''' + @PickupDateDate + ''',103))'
		END
		ELSE IF @PickUpDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PickDateTime,103) < CONVERT(date,''' + @PickupDateDate + ''',103)'
		END
	END



	IF @CollectedDate != ''
	BEGIN
		IF @CollectedDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CollectedDate,103) = CONVERT(date,''' + @CollectedDate + ''',103)'
		END
		ELSE IF @CollectedDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CollectedDate,103) > CONVERT(date,''' + @CollectedDate + ''',103)'
		END
		ELSE IF @CollectedDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CollectedDate,103) < CONVERT(date,''' + @CollectedDate + ''',103)'
		END
	END

	IF @DeliveredDate != ''
	BEGIN
		IF @DeliveredCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,DeliveredDate,103) = CONVERT(date,''' + @DeliveredDate + ''',103)'
		END
		ELSE IF @DeliveredCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,DeliveredDate,103) > CONVERT(date,''' + @DeliveredDate + ''',103)'
		END
		ELSE IF @DeliveredCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,DeliveredDate,103) < CONVERT(date,''' + @DeliveredDate + ''',103)'
		END
	END

	-------------------------------------------------------------------------------------------------
	IF @PlanCollectionDate != ''
	BEGIN
		IF @PlanCollectionEndDate != ''
		BEGIN
			if @PlanCollectionDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,PlanCollectionDate,103) '+@PlanCollectionDateCriteria+' CONVERT(date,''' + @PlanCollectionDate + ''',103) '+@AndOrCondition+' CONVERT(date,PlanCollectionDate,103) '+@PlanCollectionEndDateCriteria+' CONVERT(date,''' + @PlanCollectionEndDate + ''',103)'
		END
		ELSE IF @PlanCollectionDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PlanCollectionDate,103) > CONVERT(date,''' + @PlanCollectionDate + ''',103)'
		END
		ELSE IF @PlanCollectionDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PlanCollectionDate,103) < CONVERT(date,''' + @PlanCollectionDate + ''',103)'
		END
	END

	IF @PlanDeliveryDate != ''
	BEGIN
		IF @PlanDeliveryEndDate != ''
		BEGIN
			if @PlanDeliveryDateCriteria = '>='
				Begin
					Set @AndOrCondition = 'And'
				End
			else
				Begin
					Set @AndOrCondition = 'Or'
				End

			SET @whereClause = @whereClause + ' and CONVERT(date,PlanDeliveryDate,103) '+@PlanDeliveryDateCriteria+' CONVERT(date,''' + @PlanDeliveryDate + ''',103) '+@AndOrCondition+' CONVERT(date,PlanDeliveryDate,103) '+@PlanDeliveryEndDateCriteria+' CONVERT(date,''' + @PlanDeliveryEndDate + ''',103)'
		END
		ELSE IF @PlanDeliveryDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PlanDeliveryDate,103) > CONVERT(date,''' + @PlanDeliveryDate + ''',103)'
		END
		ELSE IF @PlanDeliveryDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,PlanDeliveryDate,103) < CONVERT(date,''' + @PlanDeliveryDate + ''',103)'
		END
	END


	IF @ConfirmedPickUpDate != ''
	BEGIN
		IF @ConfirmedPickUpDateCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''%' + @ConfirmedPickUpDate + '%'''
		END

		IF @ConfirmedPickUpDateCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfAction NOT LIKE ''%' + @ConfirmedPickUpDate + '%'''
		END

		IF @ConfirmedPickUpDateCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''' + @ConfirmedPickUpDate + '%'''
		END

		IF @ConfirmedPickUpDateCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''%' + @ConfirmedPickUpDate + ''''
		END

		IF @ConfirmedPickUpDateCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ExpectedTimeOfAction,103) =  ''' + CONVERT(VARCHAR(11), @ConfirmedPickUpDate, 103) + ''''
		END

		IF @ConfirmedPickUpDateCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and ExpectedTimeOfAction <>  ''' + @ConfirmedPickUpDate + ''''
		END
	END

	IF @CompanyNameValue != ''
	BEGIN
		IF @CompanyNameValueCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName NOT LIKE ''%' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName LIKE ''' + @CompanyNameValue + '%'''
		END

		IF @CompanyNameValueCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyNameValue + ''''
		END

		IF @CompanyNameValueCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName =  ''' + @CompanyNameValue + ''''
		END

		IF @CompanyNameValueCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and CompanyName <>  ''' + @CompanyNameValue + ''''
		END
	END


	IF @ShortCompanyName !=''
BEGIN

  IF @ShortCompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShortCompanyName LIKE ''%' + @ShortCompanyName + '%'''
  END
  IF @ShortCompanyNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShortCompanyName NOT LIKE ''%' + @ShortCompanyName + '%'''
  END
  IF @ShortCompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShortCompanyName LIKE ''' + @ShortCompanyName + '%'''
  END
  IF @ShortCompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShortCompanyName LIKE ''%' + @ShortCompanyName + ''''
  END          
  IF @ShortCompanyNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ShortCompanyName =  ''' +@ShortCompanyName+ ''''
  END
  IF @ShortCompanyNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ShortCompanyName <>  ''' +@ShortCompanyName+ ''''
  END
END

	IF @UserName != ''
	BEGIN
		IF @UserNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and UserName LIKE ''%' + @UserName + '%'''
		END

		IF @UserNameCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and UserName NOT LIKE ''%' + @UserName + '%'''
		END

		IF @UserNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and UserName LIKE ''' + @UserName + '%'''
		END

		IF @UserNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and UserName LIKE ''%' + @UserName + ''''
		END

		IF @UserNameCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and UserName =  ''' + @UserName + ''''
		END

		IF @UserNameCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and UserName <>  ''' + @UserName + ''''
		END
	END

	IF @ProductCode != ''
	BEGIN
		IF @ProductSearchCriteria = 'Include'
		BEGIN
			SET @whereClause = @whereClause + 'and OrderId in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + 
				''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + ''')))'
		END
		ELSE
		BEGIN
			SET @whereClause = @whereClause + 'and OrderId not in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + 
				''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] (''' + CONVERT(NVARCHAR(500), @ProductCode) + ''')))'
		END
	END

	IF @TruckSize != ''
	BEGIN
		IF @TruckSizeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize NOT LIKE ''%' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize LIKE ''' + @TruckSize + '%'''
		END

		IF @TruckSizeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + ''''
		END

		IF @TruckSizeCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize =  ''' + @TruckSize + ''''
		END

		IF @TruckSizeCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckSize <>  ''' + @TruckSize + ''''
		END
	END

	IF @ProductCodeData != ''
	BEGIN
		IF @ProductCodeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCodeData + '%'''
		END

		IF @ProductCodeCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode NOT LIKE ''%' + @ProductCodeData + '%'''
		END

		IF @ProductCodeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode LIKE ''' + @ProductCodeData + '%'''
		END

		IF @ProductCodeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCodeData + ''''
		END

		IF @ProductCodeCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode =  ''' + @ProductCodeData + ''''
		END

		IF @ProductCodeCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductCode <>  ''' + @ProductCodeData + ''''
		END
	END

	IF @ProductName != ''
	BEGIN
		IF @ProductNameCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName LIKE ''%' + @ProductName + '%'''
		END

		IF @ProductNameCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName NOT LIKE ''%' + @ProductName + '%'''
		END

		IF @ProductNameCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName LIKE ''' + @ProductName + '%'''
		END

		IF @ProductNameCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName LIKE ''%' + @ProductName + ''''
		END

		IF @ProductNameCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName =  ''' + @ProductName + ''''
		END

		IF @ProductNameCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductName <>  ''' + @ProductName + ''''
		END
	END

	IF @ProductQuantity != ''
	BEGIN
		IF @ProductQuantityCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''%' + @ProductQuantity + '%'''
		END

		IF @ProductQuantityCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity NOT LIKE ''%' + @ProductQuantity + '%'''
		END

		IF @ProductQuantityCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''' + @ProductQuantity + '%'''
		END

		IF @ProductQuantityCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''%' + @ProductQuantity + ''''
		END

		IF @ProductQuantityCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity =  ''' + @ProductQuantity + ''''
		END

		IF @ProductQuantityCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and ProductQuantity <>  ''' + @ProductQuantity + ''''
		END
	END

	IF @Description1 != ''
	BEGIN
		IF @Description1Criteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 LIKE ''%' + @Description1 + '%'''
		END

		IF @Description1Criteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 NOT LIKE ''%' + @Description1 + '%'''
		END

		IF @Description1Criteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 LIKE ''' + @Description1 + '%'''
		END

		IF @Description1Criteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 LIKE ''%' + @Description1 + ''''
		END

		IF @Description1Criteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 =  ''' + @Description1 + ''''
		END

		IF @Description1Criteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and Description1 <>  ''' + @Description1 + ''''
		END
	END

	IF @Description2 != ''
	BEGIN
		IF @Description2Criteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 LIKE ''%' + @Description2 + '%'''
		END

		IF @Description2Criteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 NOT LIKE ''%' + @Description2 + '%'''
		END

		IF @Description2Criteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 LIKE ''' + @Description2 + '%'''
		END

		IF @Description2Criteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 LIKE ''%' + @Description2 + ''''
		END

		IF @Description2Criteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 =  ''' + @Description2 + ''''
		END

		IF @Description2Criteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and Description2 <>  ''' + @Description2 + ''''
		END
	END

	IF @Province != ''
	BEGIN
		IF @ProvinceCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and Province LIKE ''%' + @Province + '%'''
		END

		IF @ProvinceCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and Province NOT LIKE ''%' + @Province + '%'''
		END

		IF @ProvinceCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Province LIKE ''' + @Province + '%'''
		END

		IF @ProvinceCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Province LIKE ''%' + @Province + ''''
		END

		IF @ProvinceCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and Province =  ''' + @Province + ''''
		END

		IF @ProvinceCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and Province <>  ''' + @Province + ''''
		END
	END

	IF @TruckOutTime != ''
	BEGIN
		IF @TruckOutTimeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''%' + @TruckOutTime + '%'''
		END

		IF @TruckOutTimeCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime NOT LIKE ''%' + @TruckOutTime + '%'''
		END

		IF @TruckOutTimeCriteria = 'default'
		BEGIN
			SET @whereClause = @whereClause + ' and ' + @TruckOutTime + ''
		END

		IF @TruckOutTimeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''' + @TruckOutTime + '%'''
		END

		IF @TruckOutTimeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''%' + @TruckOutTime + ''''
		END

		IF @TruckOutTimeCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime =  ''' + @TruckOutTime + ''''
		END

		IF @TruckOutTimeCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and TruckOutDateTime <>  ''' + @TruckOutTime + ''''
		END
	END

	IF @AllocatedPlateNo != ''
	BEGIN
		IF @AllocatedPlateNoCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @AllocatedPlateNo + '%'''
		END

		IF @AllocatedPlateNoCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData NOT LIKE ''%' + @AllocatedPlateNo + '%'''
		END

		IF @AllocatedPlateNoCriteria = 'default'
		BEGIN
			SET @whereClause = @whereClause + ' and ' + @AllocatedPlateNo + ''
		END

		IF @AllocatedPlateNoCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''' + @AllocatedPlateNo + '%'''
		END

		IF @AllocatedPlateNoCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @AllocatedPlateNo + ''''
		END

		IF @AllocatedPlateNoCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData =  ''' + @AllocatedPlateNo + ''''
		END

		IF @AllocatedPlateNoCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and PlateNumberData <>  ''' + @AllocatedPlateNo + ''''
		END
	END

	IF @Shift != ''
	BEGIN
		IF @ShiftCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) LIKE ''%' + @Shift + '%'''
		END

		IF @ShiftCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) NOT LIKE ''%' + @Shift + 
				'%'''
		END

		IF @ShiftCriteria = 'default'
		BEGIN
			SET @whereClause = @whereClause + ' and ' + @Shift + ''
		END

		IF @ShiftCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) LIKE ''' + @Shift + '%'''
		END

		IF @ShiftCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) LIKE ''%' + @Shift + ''''
		END

		IF @ShiftCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) =  ''' + @Shift + ''''
		END

		IF @ShiftCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and (CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end) <>  ''' + @Shift + ''''
		END
	END

	    IF @TotalPrice != ''
	BEGIN
		IF @TotalPriceCriteria = 'contains'
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice LIKE N''%' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'notcontains'
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice NOT LIKE N''%' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'startswith'
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice LIKE N''' + @TotalPrice + '%'''
		END

		IF @TotalPriceCriteria = 'endswith'
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice LIKE N''%' + @TotalPrice + ''''
		END

		IF @TotalPriceCriteria = '='
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice =  N''' + @TotalPrice + ''''
		END

		IF @TotalPriceCriteria = '<>'
		BEGIN
			SET @PaginationClause = @PaginationClause + ' and TotalPrice <>  N''' + @TotalPrice + ''''
		END
	END



	IF @OrderedBy != ''
	BEGIN
		IF @OrderedByCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy LIKE ''%' + @OrderedBy + '%'''
		END

		IF @OrderedByCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy NOT LIKE ''%' + @OrderedBy + '%'''
		END

		IF @OrderedByCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy LIKE ''' + @OrderedBy + '%'''
		END

		IF @OrderedByCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy LIKE ''%' + @OrderedBy + ''''
		END

		IF @OrderedByCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy =  ''' + @OrderedBy + ''''
		END

		IF @OrderedByCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderedBy <>  ''' + @OrderedBy + ''''
		END
	END

	IF @CarrierNumber != ''
	BEGIN
		IF @CarrierNumberCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) LIKE ''%' 
				+ @CarrierNumber + '%'''
		END

		IF @CarrierNumberCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) NOT LIKE ''%' 
				+ @CarrierNumber + '%'''
		END

		IF @CarrierNumberCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) LIKE ''' 
				+ @CarrierNumber + '%'''
		END

		IF @CarrierNumberCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) LIKE ''%' 
				+ @CarrierNumber + ''''
		END

		IF @CarrierNumberCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) =  ''' 
				+ @CarrierNumber + ''''
		END

		IF @CarrierNumberCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + 
				' and (Select CompanyMnemonic From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=txtp.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (txtp.StockLocationId)and TruckSizeId= txtp.TruckSizeId)) and CompanyType=28) <>  ''' 
				+ @CarrierNumber + ''''
		END
	END

	IF @OrderType != ''
	BEGIN
		IF @OrderTypeCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType LIKE ''%' + @OrderType + '%'''
		END

		IF @OrderTypeCriteria = 'doesnotcontain'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType NOT LIKE ''%' + @OrderType + '%'''
		END

		IF @OrderTypeCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType LIKE ''' + @OrderType + '%'''
		END

		IF @OrderTypeCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType LIKE ''%' + @OrderType + ''''
		END

		IF @OrderTypeCriteria = 'eq'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType =  ''' + @OrderType + ''''
		END

		IF @OrderTypeCriteria = 'neq'
		BEGIN
			SET @whereClause = @whereClause + ' and OrderType <>  ''' + @OrderType + ''''
		END
	END

	IF @IsRPMPresent != ''
	BEGIN
		IF (@IsRPMPresent = '1')
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryId IN (select EnquiryId from ReturnPakageMaterial )'
		END
		ELSE
		BEGIN
			SET @whereClause = @whereClause + ' and EnquiryId NOT IN (select EnquiryId from ReturnPakageMaterial )'
		END
	END

	--if @roleId=3
	--BEGIN
	--Print @roleId
	--IF @OrderType = 'Gratis Order'
	--  BEGIN
	--  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
	--  END
	--Else
	--  BEGIN
	--  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
	--  END
	--END
	IF @roleId IN (4, 14, 15)
	BEGIN
		PRINT @roleId

		--IF @OrderType = 'Gratis Order'
		--  BEGIN
		--  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
		--  END
		--Else
		--  BEGIN
		--  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
		--  END

		SET @whereClause = @whereClause + ' and  (SoldTo in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @userId) + 
			') or OrderCompanyId in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @userId) + '))'
	END

	IF @roleId = 7 
	BEGIN
		DECLARE @checkParentId BIGINT

		SET @checkParentId = (
				SELECT ISNULL(ParentId, 0)
				FROM LOGIN
				WHERE LoginId = '' + CONVERT(NVARCHAR(10), @LoginId) + ''
				)

		IF @checkParentId = 0
		BEGIN
			PRINT '1'

			--	SET @whereClause = @whereClause + 'and (select top 1 carriernumber from [dbo].route where destinationid=txtp.ShipTo and 	
			--TruckSizeId=txtp.TruckSizeId) =(' + CONVERT(NVARCHAR(10), @userId)+')'
			-- SET @whereClause = @whereClause + 'and CarrierNumber =(' + CONVERT(NVARCHAR(10), @userId)+')'
			--  SET @whereClause = @whereClause + 'and (' + CONVERT(NVARCHAR(10), @userId)+')=txtp.CarrierNumber '
			DECLARE @companyid BIGINT

			SELECT @companyid = c.CompanyId
			FROM Company c
			LEFT JOIN LOGIN l ON l.ReferenceId = c.CompanyId
			WHERE c.CompanyType = 28 AND c.IsActive = 1 AND l.LoginId = @userId

			SET @whereClause = @whereClause + 'and (select top 1 os.carriernumber from [dbo].[order] os where os.orderid=txtp.OrderId) =(' + CONVERT(NVARCHAR(10), @companyid) + ')'
		END
		ELSE
		BEGIN
			PRINT '2'

			SET @whereClause = @whereClause + ' and StockLocationId in (select DimensionValue from UserDimensionMapping where UserId=' + CONVERT(NVARCHAR(10), @LoginId) + 
				') and  (select top 1 carriernumber from [dbo].route where destinationid=txtp.ShipTo and TruckSizeId=txtp.TruckSizeId)=' + CONVERT(NVARCHAR(10), @userId) + ''
		END
				--IF @OrderType != 'SO'
				--	Begin 		
				--		SET @whereClause = @whereClause + 'and OrderType in (''ST'')'
				--	End
				--ELSE
				--	BEGIN
				--		SET @whereClause = @whereClause + 'and OrderType in (''SO'')'
				--	END
	END

	If @roleId = 2
		Begin
			DECLARE @parentcompanyid BIGINT

			SELECT @parentcompanyid = c.CompanyId
			FROM Company c
			LEFT JOIN LOGIN l ON l.ReferenceId = c.CompanyId
			WHERE c.CompanyType = 28 AND c.IsActive = 1 AND l.LoginId = @userId

			SET @whereClause = @whereClause + 'and carriernumber = (' + CONVERT(NVARCHAR(10), @parentcompanyid) + ')'
		End



	IF (@roleId = 7 OR @roleId = 2 OR @roleId = 5 OR @roleId = 6 OR @roleId = 3 OR @roleId = 4 OR @roleId = 1)
	BEGIN
		SET @whereClause = @whereClause + 'and SalesOrderNumber !=''-'' and   SalesOrderNumber is not null ' + (
				SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause](@LoginId, @PageName, @PageControlName)
				) + ''

		IF (@roleId = 7 OR @roleId = 5)
		BEGIN
			IF @TruckOutTimeCriteria != '' OR @AllocatedPlateNoCriteria != ''
			BEGIN
				IF @TruckOutTimeCriteria != 'default' AND @AllocatedPlateNoCriteria != 'default'
				BEGIN
					SET @whereClause = @whereClause + 'and Currentstate !=1105'
				END
			END
			ELSE
			BEGIN
				SET @whereClause = @whereClause + 'and Currentstate !=1105'
			END

			DECLARE @settingValue NVARCHAR(50)

			SET @settingValue = (
					SELECT SettingValue
					FROM SettingMaster
					WHERE SettingParameter = 'OrderShownToCarrier' AND IsActive = 1
					)

			IF @settingValue = 1
			BEGIN
				SET @whereClause = @whereClause + ' and om.PraposedTimeOfAction is not null and PraposedShift is not null'
			END
		END
	END

	IF (@OrderAttentionNeededFilter = '1')
	BEGIN
		SET @whereClause = @whereClause + 'and IsLate = ''-1'''
	END

	IF @IsExportToExcel != '0'
	BEGIN
		SET @PaginationClause = '1=1'
	END
	ELSE
	BEGIN
		SET @PaginationClause = '' + (
				SELECT [dbo].[fn_GetPaginationString](@PageSize, @PageIndex)
				) + ''
	END

	--SET @orderBy = 'Convert(date,ExpectedTimeOfActionValue) desc, ExpectedShift desc'
	SET @OrderBy = 'ISNULL(OrderDate,ISNULL(ExpectedTimeOfActionValue,ModifiedDate))'

	PRINT @whereClause

	SET @sql = 
		'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array],*,(SELECT Cast ((select ''true'' AS [@json:Array],OrderProductId,OrderId,ProductCode,ProductType,
ItemType, ItemName	,ProductQuantity,	ItemPricesPerUnit,	ItemPrices,
	DepositeAmountPerUnit	,ItemTotalDepositeAmount	,UOM,	ItemTax,	AssociatedOrder	,UsedQuantityInOrder
	,ProductAvailableQuantity,Remarks from OrderProductView  opv where opv.orderid=tmp.OrderId
  FOR XML path(''OrderProductList''),ELEMENTS) AS xml)),
  
     (select cast ((SELECT ''true'' AS [@json:Array], [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
      ,[ItemId]
      ,[ItemName]
      ,[PrimaryUnitOfMeasure]
      ,[ProductType]
      ,[ProductQuantity]
      ,[StockInQuantity]
      ,[ItemShortCode]
      ,[ItemType]
  FROM [dbo].[ReturnPakageMaterialView] rpm
   WHERE rpm.EnquiryId = tmp.EnquiryId  
 FOR XML path(''ReturnPakageMaterialList''),ELEMENTS) AS xml)) from 
		(Select ROW_NUMBER() OVER (ORDER BY ' 
		+ @OrderBy + ' desc) as [rownumber] ,*  from ((Select 

		(Select Count(OrderId) FROM [dbo].[OrderGridView] txtp WHERE ' + @whereClause + 
		' ) [TotalCount]

	,[InvoiceNumber]
	,[TripCost]
   ,[TripRevenue]
   ,TripProfit
   ,TruckInDataTime
,TruckOutDataTime
	  ,TripProfitPerCent
	  ,PaymentAdvanceAmount
	  ,PaymentRequestDate
	  ,PaymentRequestStatus
	  ,BillingStatus
      ,BillingCreditedAmount
      ,BillingCreditedAmountStatus
      ,BillingCreditedAmountDate
	  ,BalanceAmount
	  ,BalAmtStatus
	  ,BalanceAmountDate
	  ,[OrderId]
	  ,[EnquiryId]
      ,[OrderType]
      ,ModifiedDate
      ,[OrderNumber]
	  ,[ApprovedBy]
      ,[HoldStatus]
      --,[TotalPrice]
	  ,format([TotalPrice], N''C'', (select SettingValue from SettingMaster where SettingParameter = ''CurrencyCultureCode'')) AS TotalPrice
      ,[SalesOrderNumber]
      ,[SOGratisNumber]
      ,[PurchaseOrderNumber]
      ,[ProposedShift]
      ,CASE when ISNULL(ProposedShift,'''') = '''' then '''' else (select ShiftName from Shifts where ShiftCode = ProposedShift) end Shift
      ,[ProposedTimeOfAction]
      ,[StatusForChangeInPickShift]
      ,[OrderDate]
	  ,LocationName as DeliveryLocationName
      ,[LocationName]
      ,[DeliveryLocation]
	  ,[SupplierName]
	  ,[SupplierCode]
      ,[CompanyName]
	  ,ShortCompanyName
      ,[CompanyMnemonic]
      ,[UserName]
      ,[ExpectedTimeOfDelivery]
      ,[RequestDate]
      ,[ReceivedCapacityPalettes]
      ,[Capacity]
      ,[IsRPMPresent]
      ,[EnquiryAutoNumber]
      ,[GratisCode]
      ,[Province]
      ,[OrderedBy]
      ,[LoadNumber]
      ,[Description1]
      ,[Description2]'




SET @sql3=',[CarrierNumberValue]
      ,[Field1]
      ,[Remarks]
      ,[CurrentState]
      ,(SELECT top 1 [ResourceValue] FROM [dbo].[RoleWiseStatusView] where [RoleId]=' 
		+ CONVERT(NVARCHAR(10), @roleId) + ' and [StatusId]=CurrentState and [CultureId]=' + CONVERT(NVARCHAR(10), @CultureId) + 
		') AS [Status]


	  ,(SELECT top 1 [Class] FROM [dbo].[RoleWiseStatusView] where [RoleId]=' + CONVERT(NVARCHAR(10), @roleId) + 
		' and [StatusId]=CurrentState) AS ''Class''

--,(select   Top 1 ShortName   from   Profile  where ReferenceId=[CarrierNumber])  as ShortName
      ,[ShipTo]     
	  ,[OrderCompanyId]
      ,[SoldTo]
      ,[ReceivedCapacityPalettesCheck]
      ,[PrimaryAddressId]
      ,[SecondaryAddressId]
      ,[PrimaryAddress]
      ,[SecondaryAddress]



	  ,(select top 1 Note from Notes  where ObjectId = [OrderId] and ObjectType = 1221 and EXISTS (select RoleId from NotesRoleWiseConfiguration where Notes.RoleId=NotesRoleWiseConfiguration.RoleId and ViewNotesByRoleId = ' 
		+ CONVERT(NVARCHAR(10), @roleId) + 
		' and ObjectType = 1221)) as Note
      --,[StockLocationId]
      ,[BranchPlantName]
	  ,[BranchPlantCode]
      ,[DeliveryLocationBranchName]
      --,(Select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode=StockLocationId) as DeliveryLocationId'


	SET @sql1 = 
		'    ,[Empties]
		,(Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = [OrderGridViewNew].EnquiryId) > 0 then ''1'' else ''0'' end) as RPMValue
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[AssociatedOrder]
      ,[PreviousState]
	  ,isnull([TruckCapacityWeight],0) as [TruckCapacityWeight]
      ,[TruckSizeId]
      ,[TruckSize]
      ,[Email]
      ,[PlateNumberData]
	  ,DeliveryPersonName
      ,[PlateNumber]
      ,[PreviousPlateNumber]
      ,[DriverName]
	  ,[IsCompleted]
	  ,[DeliveredDate]
	  ,[CollectedDate]
	  ,[EnquiryDate]
	  ,[PlanCollectionDate]
	  ,[PlanDeliveryDate]
	  ,IsLate
      ,[ProfileId]
      ,[TruckInPlateNumber]
      ,[TruckOutPlateNumber]
      ,[TruckInDateTime]
      ,[TruckOutDateTime]
      ,[CarrierNumber]
	  ,[CarrierCode]
      ,[TruckRemark]
      ,[ExpectedShift]
      ,[ExpectedTimeOfAction]
      ,ExpectedTimeOfActionValue
      ,[DeliveryPersonnelId]
	   --,RevisedRequestedDate
	   ,PickDateTime
	   ,ExpectedTimeOfDeliveryFromOM
	   ,PickDateTimeFromOM
	   ,ExpectedTimeOfDeliveryValue
	,PickDateTimeValue
	,IsSelfCollect
	,TruckInDeatilsId



	,TruckInOrderId 
	,ShipToCode

  FROM [dbo].[OrderGridViewNew] ))txtp  WHERE ' 
		+ @whereClause + ' )tmp Where ' + @PaginationClause + ' FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'

	PRINT @whereClause
	PRINT @sql
	print @sql3
	PRINT @sql1

	EXEC (@sql +@sql3+ @sql1)
END
