CREATE PROCEDURE [dbo].[ISP_InsertInEventNotification] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><SalesOrderNumber>18016808</SalesOrderNumber><RoleId>3</RoleId></Json>'

@currentState bigint,
@orderId bigint



AS
BEGIN
	if (@currentState = 101  and  not exists(select *From EventNotification  where objectid=@orderId  and EventCode='Collected') )
	BEGIN

	INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
	
			SELECT (select top 1  EventMasterId  From EventMaster  em where  em.EventCode= 'Collected' ), 'Collected',@orderId, 'Order', 1, GETDATE(), 1

	

	END
	ELSE if(@currentState = 103   and  not exists(select *From EventNotification  where objectid=@orderId  and EventCode='Delivered'))

	BEGIN 
		INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			SELECT (select top 1  EventMasterId  From EventMaster  em where  em.EventCode= 'Delivered' ), 'Delivered',@orderId, 'Order', 1, GETDATE(), 1
	END	
	ELSE if(@currentState = 1029   and  not exists(select *From EventNotification  where objectid=@orderId  and EventCode='Deployed'))

	BEGIN 
		INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			SELECT (select top 1  EventMasterId  From EventMaster  em where  em.EventCode= 'Deployed' ), 'Deployed',@orderId, 'Order', 1, GETDATE(), 1
	END	
	ELSE if(@currentState = 999   and  not exists(select *From EventNotification  where objectid=@orderId  and EventCode='Cancelled'))

	BEGIN 
		INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			SELECT (select top 1  EventMasterId  From EventMaster  em where  em.EventCode= 'Cancelled' ), 'Cancelled',@orderId, 'Order', 1, GETDATE(), 1
	END			 
	
	
END