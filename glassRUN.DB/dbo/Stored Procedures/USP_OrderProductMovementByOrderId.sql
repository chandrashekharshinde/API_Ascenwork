CREATE PROCEDURE [dbo].[USP_OrderProductMovementByOrderId] --'<Json><ServicesAction>SaveEmailContent</ServicesAction><OrderList><OrderId>7584</OrderId></OrderList></Json>'
@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max)
	DECLARE @ErrMsg NVARCHAR(max)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            Declare @OrderId bigint
			Declare @CollectionOrderMovementId bigint
			Declare @DeliveryOrderMovementid bigint

		
			Select 
			@OrderId=tmp.OrderId
            FROM OPENXML(@intpointer,'Json/OrderList',2)
			WITH
			(
			[OrderId] BIGINT
            )tmp


select @CollectionOrderMovementId=OrderMovementId from [OrderMovement] where OrderId=@OrderId and LocationType=1
select @DeliveryOrderMovementid=OrderMovementId from [OrderMovement] where OrderId=@OrderId and LocationType=2

--------------------------------Collection----------------------------------------
if exists (select OrderMovementId from [OrderMovement] where OrderId=@OrderId and LocationType=1)
 BEGIN
INSERT INTO [dbo].[OrderProductMovement]
           ([OrderId]
           ,[OrderProductId]
           ,[LineNumber]
           ,[OrderMovementId]
           ,[PlannedQuantity]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[OrderProductMovementGuid])

		   select [OrderId]
		   ,[OrderProductId]
		   ,[LineNumber]
		   ,@CollectionOrderMovementId as [OrderMovementId]
           ,ProductQuantity as [PlannedQuantity]
           ,[IsActive]
           ,[CreatedBy]
           ,GETDATE()
           ,NEWID() as [OrderProductMovementGuid] from OrderProduct where IsActive=1 and OrderId=@OrderId 
		   and OrderProductId not in (Select opm.OrderProductId from [dbo].[OrderProductMovement] opm where opm.OrderId=@OrderId 
		   and opm.OrderMovementId=@CollectionOrderMovementId)

		   -------------------------------------------Update Collection------------------------------

		   UPDATE dbo.[OrderProductMovement]
		   SET [PlannedQuantity]=op.ProductQuantity,[LineNumber]=op.LineNumber,[IsActive]=op.IsActive,[UpdatedDate]=GETDATE()
		   FROM [dbo].[OrderProduct] op where op.OrderProductId=dbo.[OrderProductMovement].OrderProductId 
		   and dbo.[OrderProductMovement].OrderMovementId=@CollectionOrderMovementId and op.OrderId=@OrderId 
		   and dbo.[OrderProductMovement].OrderId=@OrderId

END
-------------------------------------------Delivery-----------------------------------------------
if exists (select OrderMovementId from [OrderMovement] where OrderId=@OrderId and LocationType=2)
 BEGIN
INSERT INTO [dbo].[OrderProductMovement]
           ([OrderId]
           ,[OrderProductId]
           ,[LineNumber]
           ,[OrderMovementId]
           ,[PlannedQuantity]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[OrderProductMovementGuid])

		   select [OrderId]
		   ,[OrderProductId]
		   ,[LineNumber]
		   ,@DeliveryOrderMovementid as [OrderMovementId]
           ,ProductQuantity as [PlannedQuantity]
           ,[IsActive]
           ,[CreatedBy]
           ,GETDATE()
           ,NEWID() as [OrderProductMovementGuid] from OrderProduct where IsActive=1 and OrderId=@OrderId
		   and OrderProductId not in (Select opm.OrderProductId from [dbo].[OrderProductMovement] opm where opm.OrderId=@OrderId 
		   and opm.OrderMovementId=@DeliveryOrderMovementid)


		   		   -------------------------------------------Update Delivery------------------------------
		   UPDATE dbo.[OrderProductMovement]
		   SET [PlannedQuantity]=op.ProductQuantity,[LineNumber]=op.LineNumber,[IsActive]=op.IsActive,[UpdatedDate]=GETDATE()
		   FROM [dbo].[OrderProduct] op where op.OrderProductId=dbo.[OrderProductMovement].OrderProductId 
		   and dbo.[OrderProductMovement].OrderMovementId=@DeliveryOrderMovementid 
		   and op.OrderId=@OrderId and dbo.[OrderProductMovement].OrderId=@OrderId
END

        SELECT @OrderId as OrderId FOR XML RAW('Json'),ELEMENTS
        exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailContent'