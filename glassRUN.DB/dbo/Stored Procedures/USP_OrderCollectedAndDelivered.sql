﻿




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

					end 