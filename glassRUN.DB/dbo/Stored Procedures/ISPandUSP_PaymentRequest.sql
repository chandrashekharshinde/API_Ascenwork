CREATE PROCEDURE [dbo].[ISPandUSP_PaymentRequest]
@OrderId bigint
AS 
 BEGIN 
Declare @CarrierNumber bigint=0
Declare @OrderNumber nvarchar(100)
Declare @PaymentPlanId bigint
Declare @TripCost decimal(18,4)=0

select @CarrierNumber=convert(bigint,isnull(CarrierNumber,0)),@OrderNumber=OrderNumber from [Order] where OrderId=@OrderId
SELECT @PaymentPlanId=PaymentPlanId FROM PaymentPlanTransporterMapping where TransporterId=@CarrierNumber
select @TripCost=TripCost from OrderTripCost where OrderId=@OrderId and IsActive=1

if(@CarrierNumber != 0 and @TripCost !=0)
begin
INSERT INTO [dbo].[PaymentRequest]
([OrderId]
,[OrderNumber]
,[SlabId]
,[SlabName]
,[AmountUnit]
,[Amount]
,[Status]
,[RequestDate]
,[IsActive]
,[CreatedBy]
,[CreatedDate])
SELECT @OrderId
,@OrderNumber
,[SlabId]
,[SlabName]
,1259
,([Amount]* @TripCost / 100)
,0
,GETDATE()
,1
,1
,GETDATE()
from PaymentSlab where IsActive=1 and PaymentPlanId=@PaymentPlanId and SlabId not in (Select pr.SlabId from [PaymentRequest] pr where pr.OrderId=@OrderId)
END
END