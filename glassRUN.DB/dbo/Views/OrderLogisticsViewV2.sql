CREATE VIEW [dbo].[OrderLogisticsViewV2]
AS
	WITH OrderMovement_CTE (OrderId,ExpectedTimeOfDeliveryFromOM, PickDateTimeFromOM,PraposedShift,PraposedTimeOfAction,StatusForChangeInPickShift,PlateNumberData,DeliveryPersonName,PlateNumber,DriverName,ExpectedShift, ExpectedShiftValue,
	 ExpectedTimeOfAction,CollectedDate,DeliveredDate, PlanCollectionDate,PlanDeliveryDate, IsCompleted, DeliveryPersonnelId, [Shift], TruckInDateTime, TruckOutDateTime, SequenceNumber )
AS
(SELECT distinct om.OrderId, om1.PraposedTimeOfAction AS ExpectedTimeOfDeliveryFromOM
,om.PraposedTimeOfAction AS PickDateTimeFromOM
,om.PraposedShift AS PraposedShift
, om.PraposedTimeOfAction AS PraposedTimeOfAction, 
(CASE WHEN om.PraposedTimeOfAction != om.ExpectedTimeOfAction OR  om.PraposedShift != om.ExpectedShift THEN '1' ELSE '0' END) AS StatusForChangeInPickShift
, ol.TruckPlateNumber AS PlateNumberData, /*check*/
 ISNULL(ol.DeliveryPersonName,'-') AS DeliveryPersonName, /*check*/
  ol.TruckPlateNumber AS PlateNumber
  , ISNULL(ol.DeliveryPersonName,'-') as DriverName
  ,(CASE WHEN om.ExpectedShift IS NOT NULL THEN om.ExpectedShift ELSE om.PraposedShift END) AS ExpectedShift, 
  '' AS ExpectedShiftValue,
(CASE WHEN om.ExpectedTimeOfAction IS NOT NULL THEN om.ExpectedTimeOfAction ELSE om.PraposedTimeOfAction END) AS ExpectedTimeOfAction, 
ISNULL(om.ActualTimeOfAction, NULL) AS CollectedDate, 
ISNULL(om1.ActualTimeOfAction,NULL) AS DeliveredDate, 
ISNULL(om.ExpectedTimeOfAction, NULL) AS PlanCollectionDate, 
ISNULL(om1.ExpectedTimeOfAction, NULL) AS PlanDeliveryDate, 
Case when om1.ActualTimeOfAction is null then '0' else '1' end as IsCompleted,
om.DeliveryPersonnelId AS DeliveryPersonnelId /*check*/
,om.ShiftName As [Shift]
,ol.TruckInTime as TruckInDateTime, 
ol.TruckOutTime as TruckOutDateTime,
ol.Sequence as SequenceNumber
from [dbo].OrderMovement om WITH (NOLOCK) 
inner join OrderLogistics ol WITH (NOLOCK)  ON ol.OrderMovementId=om.OrderMovementId AND om.Locationtype = 1 
left JOIN OrderMovement om1 WITH (NOLOCK) on om1.OrderMovementId=ol.OrderMovementId AND om1.Locationtype = 2) 


Select OrderId,ExpectedTimeOfDeliveryFromOM, PickDateTimeFromOM,PraposedShift,PraposedTimeOfAction,StatusForChangeInPickShift,PlateNumberData,DeliveryPersonName,PlateNumber,DriverName,ExpectedShift, ExpectedShiftValue, ExpectedTimeOfAction,CollectedDate,
	 DeliveredDate, PlanCollectionDate,PlanDeliveryDate, IsCompleted, DeliveryPersonnelId, [Shift], TruckInDateTime, TruckOutDateTime, SequenceNumber
 from OrderMovement_CTE