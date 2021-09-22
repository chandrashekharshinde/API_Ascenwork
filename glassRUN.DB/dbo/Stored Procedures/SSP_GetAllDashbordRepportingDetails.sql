CREATE PROCEDURE [dbo].[SSP_GetAllDashbordRepportingDetails] --'<Json><ServicesAction>DownloadDashboardReport</ServicesAction><FromDate>20/08/2018</FromDate><ToDate>20/08/2018</ToDate></Json>'
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 
 declare @fromDate nvarchar(50);
declare @toDate nvarchar(50);
Declare @ShipTo nvarchar(500)

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

   SELECT @fromDate = tmp.[FromDate],
	@toDate = tmp.[ToDate],
	@ShipTo=tmp.ShipTo
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[FromDate] nvarchar(50),
			[ToDate] nvarchar(50),
			ShipTo nvarchar(500)
			)tmp;

Print 'hii'
Set @fromDate=isnull(@fromDate,'')
if @fromDate=''
Begin

Set @fromDate='1900-01-01'
End
Print 'hii2'
Set @ToDate=isnull(@ToDate,'')
if @ToDate=''

Begin
Set @ToDate=getdate()
End
Print 'hii3'
if @fromDate = @ToDate
begin
Print @ToDate

set @ToDate = DATEADD(day, 1, Convert(datetime, @ToDate,103));

end
Print 'hii4'

if @ShipTo is null
Begin
	SET @ShipTo=''
	
End

SET @fromDate = CONVERT(datetime,@fromDate,103)
SET @toDate = CONVERT(datetime,@toDate,103)
Print @fromDate
Print @toDate
     Select  datepart(DAY, OrderDate) as Date,   
	 datepart(MM, OrderDate) as Month, 
	 datepart(WK, OrderDate) as Week, 
  BranchPlant, 
  Area,
  Customer,
  Carrier,
  DriverName,
  SalesOrderNumber,
  ItemName,
  ProductQuantity,  
  Floor(ISNULL(RevisedQuantity,ProductQuantity)) as RevisedQuantity,
 -- Case when RevisedQuantity > ProductQuantity then '0' else Floor(ISNULL(RevisedQuantity,0)) end as RevisedQuantity,
  Floor(ISNULL((ProductQuantity-RevisedQuantity),0)) as 'Cases Not Available',
 Floor((ISNULL(RevisedQuantity,ProductQuantity)/ProductQuantity*100)) as '%PA', 
 Case when RevisedQuantity IS NOT NULL then ReasonCodePreferToCSPortal ELSE NULL end  as 'Reason Code (Prefer to CS portal)',
Case when CustomerFeedbackCasesnotDeliveryOnTime is null then Floor(ISNULL(ReturnQuantity,0)) else '0' end  as 'Cases not deliver IN FULL',
 CustomerFeedback as 'Reason Code (Prefer to customer feedback)',
 --Floor(((ISNULL(RevisedQuantity,ProductQuantity)-ReturnQuantity)/ISNULL(RevisedQuantity,ProductQuantity)*100)) as '%IF',
 Case when (Case when CustomerFeedbackCasesnotDeliveryOnTime is null then Floor(ISNULL(ReturnQuantity,0)) else '0' end) = 0 then '100' else Floor(((1-((Case when CustomerFeedbackCasesnotDeliveryOnTime is null then Floor(ISNULL(ReturnQuantity,0)) else '0' end)/ISNULL(RevisedQuantity,ProductQuantity))) * 100)) end as '%IF',
 OrderDate,
 RequestDate,
 PromiseDate,
 ReasonCodeWarehousePortal as 'Reason Code (Prefer to CS / Wareshouse portal)',
 dateadd(DAYOFYEAR, - CONVERT(int,LeadTime), RequestDate) as ETD, 
 ActualDeliveryDate,
 ETA, 
 case when CustomerFeedbackCasesnotDeliveryOnTime is null then Case when Convert(date,convert(datetime,isnull(ETA,'1900-01-01')))<=Convert(date,convert(datetime,RequestDate)) then '0' else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end as 'Cases not delivery on time', 
 --Case when Convert(date,convert(datetime,isnull(ETA,'1900-01-01')))<=Convert(date,convert(datetime,RequestDate)) then '0' else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end as 'Cases not delivery on time',  
 --Case when CustomerFeedbackCasesnotDeliveryOnTime is null then Case when convert(datetime,isnull(ActualDeliveryDate,'1900-01-01'))<=convert(datetime,PromiseDate) then '100' else '0' end else '0' end as '%OT', 
  case when (case when CustomerFeedbackCasesnotDeliveryOnTime is null then Case when Convert(date,convert(datetime,isnull(ETA,'1900-01-01')))<=Convert(date,convert(datetime,RequestDate)) then '0' else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end) >= (ISNULL(RevisedQuantity,ProductQuantity)) then '0' else
 Floor((1-(case when CustomerFeedbackCasesnotDeliveryOnTime is null then Case when Convert(date,convert(datetime,isnull(ETA,'1900-01-01')))<=Convert(date,convert(datetime,RequestDate)) then '0' else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end)/(ISNULL(RevisedQuantity,ProductQuantity)))* 100) end as '%OT',
 CustomerFeedbackCasesnotDeliveryOnTime as ReasonCode,
 ActualReceiveDate
,Convert(Decimal(18,2),(1 - (Floor(ISNULL((ProductQuantity-RevisedQuantity),0)) +  case when CustomerFeedbackCasesnotDeliveryOnTime is null then Case when Convert(date,convert(datetime,isnull(ETA,'1900-01-01')))<=Convert(date,convert(datetime,RequestDate)) then '0' else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end + Case when CustomerFeedbackCasesnotDeliveryOnTime is null then Floor(ISNULL(ReturnQuantity,0)) else '0' end) / ProductQuantity) * 100)  as '%CFR'
,PlateNumber as  'Confirmed Truck Plate #'
,ConfirmedDriver  as 'Confirmed Driver'
,TruckInPlateNumber as 'Truck-in Plate #'
,TruckInDriver  as 'Truck-in Driver'
,TruckOutPlateNumber as 'Truck-out Plate #'
,TruckOutDriver  as 'Truck-out Driver'
,TruckInDateTime as 'Truck-in time'
,TruckOutDateTime as 'Truck-out time'
  from 
(select ROW_NUMBER() OVER (ORDER BY ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,o.OrderId,o.SalesOrderNumber,
(select ItemName from Item where ItemCode=op.ProductCode) as ItemName,op.ProductCode
,Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
then (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
else op.ProductQuantity  end as ProductQuantity,

Case when 
(Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
then op.ProductQuantity  end) > (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
then (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
else op.ProductQuantity  end) then '0' else (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
then op.ProductQuantity  end) end as RevisedQuantity,

(select EnquiryDate from Enquiry where EnquiryId=o.EnquiryId) as OrderDate,(select top 1 DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) as BranchPlant
,(select top 1 CompanyName from Company where CompanyId=o.SoldTo) as Customer ,(select top 1 CompanyMnemonic from Company where CompanyId=o.CarrierNumber) as Carrier,
(select top 1 RequestDate from Enquiry where EnquiryId=o.EnquiryId) as PromiseDate,
(select ReasonName from ReasonCode where ReasonCodeId in (select top 1 ReasonCodeId from ReasonCodeObjectMapping where EventName='ConfirmPickDate' order by CreatedDate desc)) as ReasonCodeWarehousePortal,
(select ReasonName from ReasonCode where ReasonCodeId in (2)) as ReasonCodePreferToCSPortal,
op.ReturnQuantity,
(Select Name from lookup where lookupid in (select feedbackid from OrderFeedback where OrderId = o.orderid and OrderProductId = op.OrderproductId 
and  feedbackId in (select LookUpId from LookUp where LookUpId in (1204,1205,1206,1207,1208,1209,1210,1211,1212)))) as CustomerFeedback,
--(select top 1 OrderProposedETD from Enquiry where EnquiryId=o.EnquiryId) as RequestDate,
(select ActualReceiveDate from OrderFeedback where OrderId = o.orderid and OrderProductId = op.OrderproductId) as ActualReceiveDate,
(select Convert(datetime, DATEADD(DAY, convert (int,(Select Field8 from Enquiry where EnquiryId=o.EnquiryId)), Convert(date,(select EnquiryDate from Enquiry where EnquiryId=o.EnquiryId))))) as RequestDate,
(select top 1 PraposedTimeOfAction  from OrderMovement where OrderId=o.OrderId) as ETD
,(Select Field8 from Enquiry where EnquiryId=o.EnquiryId) as LeadTime
,(Select DATEADD(DAY, convert (int,(Select Field8 from Enquiry where EnquiryId=o.EnquiryId)), (Select top 1 TruckOutTime from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)))) as ETA
,NULL as Casesnotdeliveryontime
,(Select top 1 TruckOutTime from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)) as ActualDeliveryDate
,(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select top 1 DeliveryPersonnelId from OrderMovement where OrderId=o.OrderId and LocationType=1))) as DriverName
,(Select Name from lookup where lookupid in (select feedbackid from OrderFeedback where OrderId = o.orderid and OrderProductId = op.OrderproductId 
and  feedbackId in (select LookUpId from LookUp where LookUpId in (1201)))) as CustomerFeedbackCasesnotDeliveryOnTime,
(select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) as Area,
(SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckIn'  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckInPlateNumber,	 
	 (SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckOut'  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckOutPlateNumber,
	 (SELECT top 1 TruckPlateNumber FROM orderlogistics WHERE ordermovementid IN (SELECT OrderMovementId FROM OrderMovement WHERE OrderId=o.OrderId AND LocationType=1)) AS PlateNumber,
	 (select TruckInTime from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)) as TruckInDateTime,
	 (select TruckOutTime from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)) as TruckOutDateTime
,(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select top 1 DeliveryPersonnelId  from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckIn'  ORDER BY OrderLogistichistoryId DESC))) as TruckInDriver
  ,(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select top 1 DeliveryPersonnelId  from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'TruckOut'  ORDER BY OrderLogistichistoryId DESC))) as TruckOutDriver
  ,(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select top 1 DeliveryPersonnelId  from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = 'Carrier'  ORDER BY OrderLogistichistoryId DESC))) as ConfirmedDriver
  
	 --,(Select Name from Profile where ProfileId in (select top 1 DeliveryPersonnelId from OrderMovement where OrderId=o.OrderId and LocationType=2)) as ConfirmedDriverName
	 --(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select DeliveryPersonnelId from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)))) as DriverName
 from OrderProduct op join [Order] o on o.OrderId=op.OrderId
where op.ProductCode<>(select SettingValue from SettingMaster where SettingParameter='WoodenPalletCode')
 and op.ProductCode<>65999001 and o.SalesOrderNumber is not null and op.ItemType<>31 and o.CurrentState not in (34) and (o.ShipTO in (@ShipTo) or @ShipTo='') and 1=1  and convert(date,o.orderdate) between  convert(date,@fromDate) and convert(date,@toDate))as tmp
 ORDER BY OrderId desc  


  exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
	END
