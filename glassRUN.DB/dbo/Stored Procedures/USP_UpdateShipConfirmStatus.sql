CREATE PROCEDURE [dbo].[USP_UpdateShipConfirmStatus] --'<Json><TotalCount>47</TotalCount><RowNum>10</RowNum><SalesOrderNumber>SO1374222610</SalesOrderNumber><ShipTo>V9-TAP HOA THU TAM-TRAN THI MINH NGUYET</ShipTo><DeliveryLocation>V9-TAP HOA THU ...</DeliveryLocation><SoldTo>V9-TAP HOA THU ...</SoldTo><CarrierNumber>368</CarrierNumber><ReceivedCapacityPalettes>-2</ReceivedCapacityPalettes><Capacity>18</Capacity><TruckSize>10T (9.86 / 10)</TruckSize><TruckSizeData> (9.86 / 10)T</TruckSizeData><TruckCapacityWeight>10</TruckCapacityWeight><TruckSizeValue>10T</TruckSizeValue><ExpectedTimeOfDelivery>22/11/2017</ExpectedTimeOfDelivery><CurrentState>5</CurrentState><Status>Plate Number Updated</Status><PickingDate>2017-11-22T12:00:00</PickingDate><PlateNumber>32131654</PlateNumber><BranchPlant>6439</BranchPlant><OrderDate>2017-11-21T14:22:10.57</OrderDate><Remarks>ghjghj</Remarks></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @SalesOrderNumber nvarchar(500)
Declare @Remarks nvarchar(500)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @SalesOrderNumber = tmp.[SalesOrderNumber],
	  @Remarks=tmp.Remarks
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SalesOrderNumber] nvarchar(500),
			[Remarks] nvarchar(500)
			
           
			)tmp



		

			update [Order] set CurrentState  = 6,Field4=@Remarks where SalesOrderNumber = @SalesOrderNumber

			SELECT @SalesOrderNumber as SalesOrderNumber FOR XML RAW('Json'),ELEMENTS

END
