CREATE  PROCEDURE [dbo].[USP_Route] --'<Json><ServicesAction>SaveRoute</ServicesAction><RouteList><RouteId>22</RouteId><CompanyId>1488</CompanyId><TransPorterId>1485</TransPorterId><OriginId>23643</OriginId><DestinationId>0</DestinationId><TruckSizeId>180</TruckSizeId><IsActive>true</IsActive><CreatedBy>409</CreatedBy></RouteList><RouteList><RouteId>22</RouteId><CompanyId>1488</CompanyId><TransPorterId>1498</TransPorterId><OriginId>23643</OriginId><DestinationId>0</DestinationId><TruckSizeId>180</TruckSizeId><IsActive>true</IsActive><CreatedBy>409</CreatedBy></RouteList></Json>'

@xmlDoc xml

AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	Declare @compnayId bigint;
	Declare @originid bigint;
	Declare @destinationid bigint;
	Declare @trucksizeid bigint;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

			
 SELECT @compnayId = tmp.CompanyId,
	   @originid = tmp.[OriginId],
	   @destinationid = tmp.[DestinationId],
	   @trucksizeid = tmp.[TruckSizeId]
	   
FROM OPENXML(@intpointer,'Json/RouteList',2)
			WITH
			(

				CompanyId  Bigint,
				[RouteId] bigint,
				[OriginId] BigInt,
				[DestinationId] BigInt,
				[TruckSizeId] BigInt,				
				IsActive Bit,
				UpdatedBy  bigint
            )tmp
	
			Print @compnayId
			Print @originid
			Print @destinationid
			Print @trucksizeid
	--update Route set IsActive=0 where CompanyId=@compnayId and OriginId=@originid and DestinationId=@destinationid and TruckSizeId=@trucksizeid



	update Route set IsActive=0,
     [UpdatedDate]=GETDATE()
     FROM OPENXML(@intpointer,'Json/EditedRoutList',2)
	 WITH
	 (
		[RouteId] bigint,
	 	[CreatedBy] bigint
     )tmp where [Route].RouteId =tmp.RouteId



	 UPDATE dbo.[Route] SET
     [CompanyId]=tmp.CompanyId , 
	 
     [OriginId]=tmp.[OriginId] ,
     [DestinationId]=tmp.DestinationId ,
     [TruckSizeId]=tmp.TruckSizeId ,        	
     [IsActive]=tmp.IsActive ,
     [UpdatedBy]=tmp.UpdatedBy ,
     [UpdatedDate]=GETDATE()
     FROM OPENXML(@intpointer,'Json/RouteList',2)
	 WITH
	 (
	 	CompanyId  Bigint,
		[RouteId] bigint,
	 	[OriginId] BigInt,
	 	[DestinationId] BigInt,
	 	[TruckSizeId] BigInt,				
	 	IsActive Bit,
		[CreatedBy] bigint,
	 	UpdatedBy  bigint
     )tmp where [Route].RouteId =tmp.RouteId


  INSERT INTO [dbo].[Route] 
					 (
					[CompanyId],
					[RouteNumber],
					[OriginId],
					[DestinationId],
					[TruckSizeId],
					[CarrierNumber],
					[IsActive],
					[CreatedBy],
					[CreatedDate]
					) 
          SELECT tmp.[companyid], 
		             null,
					 [OriginId],
					 [DestinationId],
					 [TruckSizeId],
                 tmp.[transporterid], 
                 tmp.[isactive], 
                 tmp.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/RouteList', 2) 
                    WITH ( [CompanyId]     BIGINT, 
							[RouteId] bigint,
                           [TransPorterId] BIGINT, 
						   [OriginId]   BIGINT,
						   [DestinationId] BIGINT,
						   [TruckSizeId] BIGINT,
                           [IsActive]      BIT, 
                           [CreatedBy]     NVARCHAR(100) )tmp where tmp.[RouteId]=0


				

		PRINT N'Update Route'


	

	
			
        	
		SELECT 1 as RouteId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
	END

PRINT 'Successfully created procedure dbo.USP_TruckSize'
