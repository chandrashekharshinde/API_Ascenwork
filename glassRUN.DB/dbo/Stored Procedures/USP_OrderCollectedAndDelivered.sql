CREATE PROCEDURE [dbo].[USP_OrderCollectedAndDelivered] --'<Json><rownumber>1</rownumber><TotalCount>87</TotalCount><TripCost>0.00</TripCost><TripRevenue>0.00</TripRevenue><OrderId>77570</OrderId><EnquiryId>12817</EnquiryId><OrderType>SO</OrderType><ModifiedDate>2019-02-04T12:17:35.76</ModifiedDate><OrderNumber>UCILS/033/10654/02</OrderNumber><HoldStatus>-</HoldStatus><TotalPrice>0.00</TotalPrice><SalesOrderNumber>UCILS/033/10654</SalesOrderNumber><SOGratisNumber>UCILS/033/10654</SOGratisNumber><PurchaseOrderNumber>342323</PurchaseOrderNumber><ProposedShift /><ProposedTimeOfAction>12/02/2019</ProposedTimeOfAction><StatusForChangeInPickShift>0</StatusForChangeInPickShift><OrderDate>2019-02-04T12:17:35.76</OrderDate><DeliveryLocationName>Shipper 1 Drop Off 1</DeliveryLocationName><LocationName>Shipper 1 Drop Off 1</LocationName><DeliveryLocation>1017</DeliveryLocation><CompanyName>Shipper 1</CompanyName><CompanyMnemonic /><UserName>OM</UserName><ExpectedTimeOfDelivery>19/02/2019</ExpectedTimeOfDelivery><RequestDate>19/02/2019</RequestDate><ReceivedCapacityPalettes>0</ReceivedCapacityPalettes><Capacity>0</Capacity><IsRPMPresent>0</IsRPMPresent><EnquiryAutoNumber>INQ010938</EnquiryAutoNumber><OrderedBy>8</OrderedBy><Field1 /><CurrentState>525</CurrentState><ShipTo>1017</ShipTo><SoldTo>1366</SoldTo><ReceivedCapacityPalettesCheck>1</ReceivedCapacityPalettesCheck><BranchPlantName>Shipper 1 Pick UP -1</BranchPlantName><BranchPlantCode>1015</BranchPlantCode><DeliveryLocationBranchName>Shipper 1 Pick UP -1</DeliveryLocationBranchName><EmptiesLimit>0</EmptiesLimit><ActualEmpties>0</ActualEmpties><TruckCapacityWeight>1</TruckCapacityWeight><TruckSizeId>152</TruckSizeId><TruckSize>1 MT</TruckSize><DriverName>-</DriverName><IsCompleted>0</IsCompleted><DeliveredDate>2019-02-19T10:42:00</DeliveredDate><CollectedDate>2019-02-12T12:03:00</CollectedDate><ProfileId>0</ProfileId><TruckInPlateNumber /><TruckOutPlateNumber /><TruckInDateTime>1900-01-01T00:00:00</TruckInDateTime><TruckOutDateTime>1900-01-01T00:00:00</TruckOutDateTime><ExpectedShift /><ExpectedTimeOfAction>12/02/2019</ExpectedTimeOfAction><ExpectedTimeOfActionValue>2019-02-12T12:03:00</ExpectedTimeOfActionValue><DeliveryPersonnelId>0</DeliveryPersonnelId><CheckedEnquiry>true</CheckedEnquiry><ActualTimeOfAction>2019-02-27T19:05:21.5472105+05:30</ActualTimeOfAction><NextState>101</NextState></Json>'@xmlDoc xmlASBEGINDECLARE @intPointer INT;Declare @OrderId bigint;Declare @NextState bigint ;declare @ActualTimeOfAction  datetimeEXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT 	   @OrderId = tmp.[OrderId],	    @NextState = tmp.[NextState],		  @ActualTimeOfAction = tmp.[ActualTimeOfAction]	  FROM OPENXML(@intpointer,'Json',2)			WITH			(				[OrderId] bigint,				[NextState]  bigint ,				[ActualTimeOfAction] datetime			)tmp			declare @NextSequence   bigint			declare  @IsUpdated bit						set @IsUpdated =0



					if(@NextState  = 1029   )
					begin
					update  [order]  set CurrentState = @NextState where OrderId=@OrderId

					
					exec [dbo].[ISP_InsertInEventNotification] @NextState,@orderId

					set @IsUpdated =1


					end
					else if(@NextState  = 101   and    exists   ( select  count(*)From  OrderMovement  where OrderId=@OrderId)    and   exists   (  select TransportOperatorId   From  OrderMovement  where  OrderId=@OrderId)  )
					begin
					update  [order]  set CurrentState = @NextState where OrderId=@OrderId

					update OrderMovement  set ActualTimeOfAction=@ActualTimeOfAction  where    OrderId=@OrderId  and LocationType=1


					exec [dbo].[ISP_InsertInEventNotification] @NextState,@orderId

					set @IsUpdated =1


					end
					else if(@NextState  = 103   and    exists   ( select  count(*)From  OrderMovement  where OrderId=@OrderId)    and   exists   (  select TransportOperatorId   From  OrderMovement  where  OrderId=@OrderId) )
					begin

					update  [order]  set CurrentState = @NextState where OrderId=@OrderId
					update OrderMovement  set ActualTimeOfAction=@ActualTimeOfAction  where    OrderId=@OrderId  and LocationType=2

					exec [dbo].[ISP_InsertInEventNotification] @NextState,@orderId


					set @IsUpdated =1

					end 	   SELECT @OrderId as OrderId    , @IsUpdated   as  'IsUpdated'    FOR XML RAW('Json'),ELEMENTSEND