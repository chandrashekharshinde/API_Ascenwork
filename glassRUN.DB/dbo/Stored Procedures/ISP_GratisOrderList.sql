CREATE PROCEDURE [dbo].[ISP_GratisOrderList] 
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


   select *
    into #tmpGratisOrderList
    FROM OPENXML(@intpointer,'Json/GratisOrderList',2)
        WITH
        (
			[GratisOrderId]	bigint,
			[OrderId]	bigint,
			[JDEOrderNumber]	bigint,
			[AssociatedOrderNumber]	bigint,
			[ShipTo]	bigint,
			[ShipToCode]	bigint,
			[TruckSizeId]	bigint,
			[TruckSize]	nvarchar(50),
			[ItemId]	bigint,
			[ItemCode] nvarchar(50),
			[Quantity]	decimal,
			[UOM]	bigint,
			[FromDate]	datetime,
			[ToDate]	datetime,
			[IsConsumed]	bit,
			[IsActive]	bit,
			[CreatedBy]	bigint,
			[UpdatedBy]	bigint,
			[IPAddress]	nvarchar(20)
        )tmp
		

		insert into GratisOrder(
		--OrderId,
		--JDEOrderNumber,6
		--AssociatedOrderNumber,
		ShipTo,
		TruckSizeId,
		ItemId,
		Quantity,
		UOM,
		FromDate,
		ToDate,
		IsConsumed,
		IsActive,
		CreatedBy,
		CreatedDate,
		IPAddress
		)
		select
		--tmp.OrderId,
		--tmp.JDEOrderNumber,
		--tmp.AssociatedOrderNumber,
		tmp.ShipTo,
		tmp.TruckSizeId,
		tmp.ItemId,
		tmp.Quantity,
		tmp.UOM,
		tmp.FromDate,
		tmp.ToDate,
		tmp.IsConsumed,
		tmp.IsActive,
		tmp.CreatedBy,
		GETDATE(),
		tmp.IPAddress 
		
		from #tmpGratisOrderList tmp

	
        --Add child table insert procedure when required.
    
    SELECT 1
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
