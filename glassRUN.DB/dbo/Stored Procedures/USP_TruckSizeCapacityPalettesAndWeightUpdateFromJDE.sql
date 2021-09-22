CREATE  PROCEDURE [dbo].[USP_TruckSizeCapacityPalettesAndWeightUpdateFromJDE] --''

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

			SELECT * INTO #tmpTruckSize
			FROM OPENXML(@intpointer,'Json/TruckSizeList',2)
			 WITH
             (
		
			TruckSize nvarchar(500),
			TruckCapacityPalettes bigint,
			TruckCapacityWeight bigint
				
			 ) tmp

			 

	

PRINT N'Update TruckCapacityPalettes'


UPDATE  dbo.TruckSize

SET TruckCapacityPalettes =#tmpTruckSize.[TruckCapacityPalettes],
TruckCapacityWeight =#tmpTruckSize.[TruckCapacityWeight]
 FROM #tmpTruckSize 
	 left join TruckSize  TS  ON   #tmpTruckSize.[TruckSize]=ts.TruckSize
	 WHERE ts.TruckSizeId  is not  null


           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_TruckSizeCapacityPalettesAndWeightUpdateFromJDE'
