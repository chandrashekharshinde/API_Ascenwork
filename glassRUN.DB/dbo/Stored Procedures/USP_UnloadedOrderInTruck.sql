CREATE PROCEDURE [dbo].[USP_UnloadedOrderInTruck]--'<Json><UserId>0</UserId><OrderId>0</OrderId><ServicesAction>CreateLog</ServicesAction><LogDescription>Empties Limit</LogDescription><LogDate>17/10/2017 13:41</LogDate></Json>'
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




	Select * into #tempTruckInTruckInOrder FROM OPENXML(@intpointer,'Json/OrderList',2)
        WITH
        (
		
		 [TruckInOrderId] bigint 
		
        )



		delete TruckInOrder  where TruckInOrderId = (Select  #tempTruckInTruckInOrder.TruckInOrderId from  #tempTruckInTruckInOrder)

        DECLARE @TruckInDeatilsId BIGINT



    Select  #tempTruckInTruckInOrder.TruckInOrderId from  #tempTruckInTruckInOrder FOR XML RAW('Json'),ELEMENTS
		
		
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END