CREATE PROCEDURE [dbo].[SSP_GetAllCFRReportingDetails]
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
     
	 SELECT [Date]
      ,[Month]
      ,[Week]
      ,[BranchPlant]
      ,[Area]
      ,[Customer]
      ,[Carrier]
	  ,[ConfirmedDriver] As DriverName
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[Remarks]
      ,[ItemCode]
      ,[ItemName]
      ,[ProductQuantity]
      ,[RevisedQuantity]
      ,[CasesNotAvailable] as 'Cases Not Available'
      ,[PA_Percentage] as '%PA'
      ,[ReasonCodePreferToCSPortal]  as 'Reason Code (Prefer to CS portal)'
      ,[CasesNotDeliverInFull]  as 'Cases not deliver IN FULL'
      ,[ReasonCodePreferToCustomerFeedback] as 'Reason Code (Prefer to customer feedback)'
	  ,[ReasonCodePreferToCustomerFeedback] As Feedback
      ,[IF_Percentage] As '%IF'
      , convert(varchar, [OrderDate] , 22)As [OrderDate]
      ,CONVERT(VARCHAR, [ApprovalDate], 22) As [ApprovalDate]
      ,CONVERT(VARCHAR(250), [RequestDate], 103) As [RequestDate]
      ,CONVERT(VARCHAR(250), [PromisedDate], 103) As [PromisedDate]
      ,[ReasonCodeWarehousePortal] as 'Reason Code (Prefer to CS / Wareshouse portal)'
      ,CONVERT(VARCHAR(250), [ETD], 103) As [ETD]
      ,CONVERT(VARCHAR, [ActualDeliveryDate], 22) As [ActualDeliveryDate]
      ,CONVERT(VARCHAR, [ETA], 22) As [ETA]
      ,[CasesNotDeliveryOnTime] as 'Cases not delivery on time (Not on Time)'
      ,[OT_Percentage] AS '%OT'
      ,[ReasonCode]
      ,CONVERT(VARCHAR(250), [ActualReceiveDate], 103) As [ActualReceiveDate]
      ,[CFR_Percentage]  as '%CFR'
      ,[ConfirmedTruckPlate] As 'Confirmed Truck Plate #'
      ,[ConfirmedDriver] As 'Confirmed Driver'
      ,[TruckInTruckOutPlateNumber] As 'Truck-in Plate #'
      ,[TruckInTruckOutDriver] As 'Truck-in Driver'
	  ,[TruckInTruckOutPlateNumber] As 'Truck-in Plate #'
      ,[TruckInTruckOutDriver] As 'Truck-out Driver'
      ,CONVERT(VARCHAR, [TruckInDataTime], 22) As 'Truck-in time'
     ,CONVERT(VARCHAR, [TruckOutDataTime], 22) As 'Truck-out time'
  FROM [glassRUN-VBL_CFR]..CFRReport where convert(date,ApprovalDate) between  convert(date,@fromDate) and convert(date,@toDate)

  exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
	END
