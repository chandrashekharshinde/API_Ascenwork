CREATE PROCEDURE [dbo].[USP_UpdatePalletInclusionGroup]

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

            DECLARE @PageId BIGINT
            
            UPDATE dbo.[Route] SET
			[PalletInclusionGroup]=case when tmp.[PalletInclusionGroup]='0' then null else tmp.[PalletInclusionGroup] end
            FROM OPENXML(@intpointer,'Json/TruckSizeList',2)
			WITH
			(
            [DestinationId] bigint,
			[TruckSizeId] bigint,
           	[CarrierNumber] bigint,
			[PalletInclusionGroup] nvarchar(500)
            )tmp where [Route].DestinationId=tmp.DestinationId and [Route].TruckSizeId=tmp.TruckSizeId 

            SELECT  @PageId

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END