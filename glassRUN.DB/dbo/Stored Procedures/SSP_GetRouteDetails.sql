-- =============================================
-- Author:		Abhijit Kharat
-- Create date: 20 jan 2020
-- Description:	<Description,,>
-- exec [dbo].[SSP_GetRouteDetails] 1,1,242,'',302,'',5
-- exec [dbo].[SSP_GetRouteDetails] 0,0,0,'',0,'6410',0
-- exec [dbo].[SSP_GetRouteDetails] 0,0,0,0,5
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetRouteDetails]
(
 @RouteId INT = 0,
 @CompanyId INT = 0,
 @OriginId INT = 0,
 @OriginCode VARCHAR(100),
 @DestinationId INT = 0,
 @DestinationCode VARCHAR(100),
 @TruckSizeId INT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	  DECLARE @ErrMsg nvarchar(2048)
	  DECLARE @ErrSeverity int;
	  DECLARE @intPointer int;
	  SET @ErrSeverity = 15;
  
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @ParameterDef NVARCHAR(500)
 
    SET @ParameterDef ='@RouteId INT,
						@CompanyId INT,
						@OriginId INT,      @OriginCode VARCHAR(100),
						@DestinationId INT, @DestinationCode VARCHAR(100),
						@TruckSizeId INT'
	BEGIN TRY	
    SET @SQL =  'SELECT  ROU.RouteId              
				,ROU.CompanyId  ,COM.CompanyName,com.CompanyMnemonic          
				,ROU.RouteNumber                                        
				,ROU.OriginId,lo.LocationCode OriginCode,lo.LocationName OriginName            
				,ROU.DestinationId ,ld.LocationCode DestinationCode,ld.LocationName DestinationName        
				,ROU.TruckSizeId, ts.TruckSize, ts.TruckCapacityPalettes,TruckCapacityWeight          
				,ROU.CarrierNumber,Car.CompanyMnemonic as CarrierCode,Car.CompanyName as CarrierName
				,ROU.PalletInclusionGroup                                                                                 
				,ROU.IsActive  FROM Route ROU WITH (NOLOCK)
				INNER JOIN Company COM ON COM.CompanyId = ROU.CompanyId
				INNER JOIN Company Car on Rou.CarrierNumber = car.CompanyId
				INNER JOIN Location ld on rou.Destinationid = ld.LocationID
				INNER JOIN Location lo on rou.OriginId = lo.LocationId
				INNER JOIN TruckSize ts on rou.TruckSizeId = ts.TruckSizeID WHERE 1=1 ' 

	IF @RouteId IS NOT NULL AND @RouteId <> 0 
	SET @SQL = @SQL+ ' AND ROU.RouteId = @RouteId'

	IF @CompanyId IS NOT NULL AND @CompanyId <> 0 
	SET @SQL = @SQL+ ' AND ROU.CompanyId = @CompanyId'

	IF @OriginId IS NOT NULL AND @OriginId <> 0 
	SET @SQL = @SQL+ ' AND ROU.OriginId = @OriginId'

	IF @OriginCode IS NOT NULL AND @OriginCode <> '' 
	SET @SQL = @SQL+ ' AND lo.LocationCode = @OriginCode'

	IF @DestinationId IS NOT NULL AND @DestinationId <> 0 
	SET @SQL = @SQL+ ' AND ROU.DestinationId = @DestinationId'

	IF @DestinationCode IS NOT NULL AND @DestinationCode <> '' 
	SET @SQL = @SQL+ ' AND ld.LocationCode = @DestinationCode'

	IF @TruckSizeId IS NOT NULL AND @TruckSizeId <> 0 
	SET @SQL = @SQL+ ' AND ROU.TruckSizeId = @TruckSizeId'

	
	EXEC sp_Executesql @SQL,  @ParameterDef, @RouteId=@RouteId,
											 @CompanyId=@CompanyId,
											 @OriginId=@OriginId,          @OriginCode=@OriginCode,
											 @DestinationId=@DestinationId,@DestinationCode=@DestinationCode,
											 @TruckSizeId=@TruckSizeId

  END TRY
  BEGIN CATCH
    SELECT
      @ErrMsg = ERROR_MESSAGE();
    RAISERROR (@ErrMsg, @ErrSeverity, 1);
    RETURN;
  END CATCH

END

