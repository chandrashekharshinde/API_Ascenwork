Create PROCEDURE [dbo].[USP_PlateNumberDriverMapping] --''

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
DECLARE @PlateNumberDriverMappingId bigint
UPDATE dbo.[PlateNumberDriverMapping] SET
@PlateNumberDriverMappingId=tmp.PlateNumberDriverMappingId,
PlateNumber=tmp.PlateNumber ,
DriverId=tmp.DriverId 


FROM OPENXML(@intpointer,'Json/PlateNumberDriverMappingList',2)
WITH
(
PlateNumberDriverMappingId bigint, 
PlateNumber nvarchar(50), 
DriverId bigint


)tmp WHERE PlateNumberDriverMapping.PlateNumberDriverMappingId=tmp.PlateNumberDriverMappingId
SELECT @PlateNumberDriverMappingId as PlateNumberDriverMappingId FOR XML RAW('Json'),ELEMENTS
exec sp_xml_removedocument @intPointer
END TRY
BEGIN CATCH
SELECT @ErrMsg = ERROR_MESSAGE();
RAISERROR(@ErrMsg, @ErrSeverity, 1);
RETURN; 
END CATCH
END
