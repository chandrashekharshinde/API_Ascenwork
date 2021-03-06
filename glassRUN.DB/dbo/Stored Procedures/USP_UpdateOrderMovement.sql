Create PROCEDURE [dbo].[USP_UpdateOrderMovement]

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

Declare @orderId bigint
Declare @settingValue nvarchar(10)


			SELECT * INTO #tmpOrderMovement
			FROM OPENXML(@intpointer,'OrderMovement',2)
			 WITH
             (
			OrderId BIGINT,
			[LocationType] BIGINT,
			[ActualDriverName] nvarchar(200),
			[ActualPlateNumber] nvarchar(200)
			 ) tmp


		  update OrderMovement set [ActualDriverName]=tmp.[ActualDriverName],[ActualPlateNumber]=tmp.[ActualPlateNumber] from #tmpOrderMovement tmp where OrderMovement.OrderId=tmp.OrderId and OrderMovement.LocationType =tmp.LocationType
			
           SELECT OrderId from #tmpOrderMovement 
	   
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

