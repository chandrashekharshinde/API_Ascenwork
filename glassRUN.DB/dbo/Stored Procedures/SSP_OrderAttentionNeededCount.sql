
Create PROCEDURE [dbo].[SSP_OrderAttentionNeededCount] --'<Json><ServicesAction>LoadOrderGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>21</PageSize><OrderBy>CompanyName</OrderBy><OrderByCriteria>asc</OrderByCriteria><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><PurchaseOrderNumber></PurchaseOrderNumber><TripCostCriteria>=</TripCostCriteria><TripCost>60000.00</TripCost><TripRevenueCriteria></TripRevenueCriteria><TripRevenue></TripRevenue><CarrierNumberValueCriteria></CarrierNumberValueCriteria><CarrierNumberValue></CarrierNumberValue><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><OrderNumberCriteria></OrderNumberCriteria><OrderNumber></OrderNumber><BranchPlantName></BranchPlantName><BranchPlantNameCriteria></BranchPlantNameCriteria><OrderDate></OrderDate><OrderDateCriteria></OrderDateCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><DeliveryLocationNameCriteria></DeliveryLocationNameCriteria><DeliveryLocationName></DeliveryLocationName><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria></TotalPriceCriteria><TotalPrice></TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><CurrentState></CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>3</RoleMasterId><UserId>8</UserId><LoginId>8</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode><CollectedDate></CollectedDate><CollectedDateCriteria></CollectedDateCriteria><DeliveredCriteria></DeliveredCriteria><DeliveredDate></DeliveredDate></Json>'
(
@xmlDoc XML
)
AS



BEGIN

Declare @sql nvarchar(max)

DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @roleId bigint
Declare @userId bigint
Declare @LoginId bigint
Declare @PageSize INT
Declare @PageName NVARCHAR(150)
declare @OrderType nvarchar(100)
declare @TruckOutTimeCriteria  nvarchar(100)
declare @AllocatedPlateNoCriteria  nvarchar(100)

set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
@roleId = tmp.[RoleMasterId],
@userId = tmp.[UserId],
	 @LoginId = tmp.[LoginId],
   @PageName =tmp.[PageName],
   @OrderType = tmp.[OrderType]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [RoleMasterId] bigint,

   [UserId] bigint,
   [LoginId] bigint,
   [PageName] nvarchar(50),
           [OrderType] nvarchar(100)
   )tmp


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END



if @roleId=3
BEGIN
Print @roleId

IF @OrderType = 'Gratis Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
  END
Else
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
  END

END
 
if @roleId=4
BEGIN
Print @roleId



IF @OrderType = 'Gratis Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
  END
Else
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
  END

SET @whereClause = @whereClause + ' and  SoldTo = (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @userId)+')'
END


If @roleId = 7
Begin 


	Declare @checkParentId bigint
	SET @checkParentId = (Select ISNULL(ParentId,0) from Login where LoginId= '' + CONVERT(NVARCHAR(10), @LoginId)+'' )
	 
	 IF @checkParentId = 0 
	 BEGIN


	 
	 Print '1'
		--	SET @whereClause = @whereClause + 'and (select top 1 carriernumber from [dbo].route where destinationid=txtp.ShipTo and 	
			--TruckSizeId=txtp.TruckSizeId) =(' + CONVERT(NVARCHAR(10), @userId)+')'

	-- SET @whereClause = @whereClause + 'and CarrierNumber =(' + CONVERT(NVARCHAR(10), @userId)+')'
	--  SET @whereClause = @whereClause + 'and (' + CONVERT(NVARCHAR(10), @userId)+')=txtp.CarrierNumber '


	declare @companyid bigint




	select @companyid=c.CompanyId
	from Company  c left join Login l on l.ReferenceId=c.CompanyId 
	where c.CompanyType=28 AND c.IsActive=1 and l.LoginId=@userId


	  	SET @whereClause = @whereClause + 'and (select top 1 os.carriernumber from [dbo].[order] os where os.orderid=txtp.OrderId) =(' + CONVERT(NVARCHAR(10), @companyid)+')'

	 END
	 ELSE
	 BEGIN
	 Print '2'

		SET @whereClause = @whereClause + ' and StockLocationId in (select DimensionValue from UserDimensionMapping where UserId=' + CONVERT(NVARCHAR(10), @LoginId)+') and  (select top 1 carriernumber from [dbo].route where destinationid=txtp.ShipTo and TruckSizeId=txtp.TruckSizeId)=' + CONVERT(NVARCHAR(10), @userId)+''




	 END


	--IF @OrderType != 'SO'
	--	Begin 		
	--		SET @whereClause = @whereClause + 'and OrderType in (''ST'')'
	--	End
	--ELSE
	--	BEGIN
	--		SET @whereClause = @whereClause + 'and OrderType in (''SO'')'
	--	END
End

If (@roleId = 7 Or @roleId = 5 Or @roleId = 6)
BEGIN

SET @whereClause = @whereClause + 'and OrderType not in (''SG'',''S5'',''S6'') and SalesOrderNumber !=''-'' and   SalesOrderNumber is not null '+ (SELECT [dbo].[fn_GetUserAndDimensionAndPageWiseWhereClause] (@LoginId , @PageName)) +''

	If (@roleId = 7 Or @roleId = 5)
		Begin

		if @TruckOutTimeCriteria != '' or @AllocatedPlateNoCriteria != ''
		BEGIN
		
			IF @TruckOutTimeCriteria != 'default' and @AllocatedPlateNoCriteria != 'default'
			BEGIN  
			
			SET @whereClause = @whereClause + 'and Currentstate !=1105'
			END
		END
		ELSE
		BEGIN

       SET @whereClause = @whereClause + 'and Currentstate !=1105'
     END
				Declare @settingValue nvarchar(50)
					SET @settingValue=(Select SettingValue from SettingMaster where SettingParameter='OrderShownToCarrier' and IsActive=1)
				If @settingValue=1
					BEGIN
						SET @whereClause = @whereClause + ' and om.PraposedTimeOfAction is not null and PraposedShift is not null'
					END
		End
END



Print @whereClause


set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((Select COUNT(*) as AttentionNeeded from
 (select case when [PlanDeliveryDate] is NULL then ''1''
    when ISNULL([PlanDeliveryDate] ,'''') >= ISNULL([DeliveredDate],GETDATE()) then ''1''
    else ''-1''
       end as IsLate from (select 

	   ISNULL(om1.ActualTimeOfAction,NUll) as DeliveredDate,
ISNULL(om1.ExpectedTimeOfAction,NUll) as PlanDeliveryDate 

from [Order] o 
left join [dbo].OrderMovement om on o.OrderId = om.OrderId and om.Locationtype=1
left join [dbo].OrderMovement om1 on o.OrderId = om1.OrderId and om1.Locationtype=2

WHERE  o.IsActive = 1  and ' + @whereClause +') as tmp) as tmp1 where tmp1.IsLate = ''-1'' FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


print @whereClause
print @sql

exec (@sql)




END