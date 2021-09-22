CREATE  PROCEDURE [dbo].[USP_RouteInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpRoute
			FROM OPENXML(@intpointer,'Json/RouteList',2)
			 WITH
             (
		
			RouteNumber nvarchar(500),
			OriginCode  nvarchar(500) ,
			DestinationCode  nvarchar(500) ,	
			TruckSizeCode nvarchar(500),
			CarrierNumberCode nvarchar(500)

			 ) tmp

			 

			 select * from  #tmpRoute
			 
			 
			 delete from Route

PRINT N'Insert Route'

		INSERT INTO [dbo].[Route]
           ([RouteNumber]
		   ,CompanyId
		    ,[OriginId]
			,[DestinationId]
			,[TruckSizeId]
			,[CarrierNumber]
			,IsActive
			,CreatedBy
		   
          )
    SELECT
			 #tmpRoute.[RouteNumber]
			 ,(select  top 1  CompanyId  From Company  where CompanyType=23)
			 , odl.LocationId
			,ddl.LocationId
			,(select top 1 TruckSizeId from TruckSize  ts where ts.TruckSize = #tmpRoute.[TruckSizeCode])
			 ,(select top 1 CompanyId from Company  c where c.CompanyMnemonic = #tmpRoute.[CarrierNumberCode])
			 ,1
			 ,1
     FROM #tmpRoute 
	 left join Route  r  ON   #tmpRoute.[RouteNumber]=r.RouteNumber
	 left join  Location oDl on   #tmpRoute.[OriginCode] =odl.LocationCode
	 left  join  Location dDl on   #tmpRoute.[DestinationCode] =dDl.LocationCode
	
	 WHERE r.RouteId is null  and odl.LocationId is not null and ddl.LocationId is not null

PRINT N'Update Route'


--UPDATE  dbo.Route

--SET OriginId = odl.DeliveryLocationId,
--DestinationId =ddl.DeliveryLocationId,
--TruckSizeId =(select top 1 TruckSizeId from TruckSize  ts where ts.TruckSize = #tmpRoute.[TruckSizeCode]),
--CarrierNumber =(select top 1 CompanyId from Company  c where c.CompanyMnemonic = #tmpRoute.[CarrierNumberCode])
-- FROM #tmpRoute 
--	 left join Route  r  ON   #tmpRoute.[RouteNumber]=r.RouteNumber
--	  left join  DeliveryLocation oDl on   #tmpRoute.[OriginCode] =odl.DeliveryLocationCode
--	 left  join  DeliveryLocation dDl on   #tmpRoute.[DestinationCode] =dDl.DeliveryLocationCode
--	 WHERE r.RouteId is not  null and odl.DeliveryLocationId is not null and ddl.DeliveryLocationId is not null


		

		drop table #tmpRoute
			
        	
           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_TruckSize'