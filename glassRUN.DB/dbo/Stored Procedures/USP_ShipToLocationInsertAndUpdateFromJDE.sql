CREATE  PROCEDURE [dbo].[USP_ShipToLocationInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpDeliveryLocation
			FROM OPENXML(@intpointer,'Json/DeliveryLocationList',2)
			 WITH
             (
		
			DeliveryLocationName nvarchar(500),
			DeliveryLocationCode  nvarchar(200),			        
			CompanyMnemonic nvarchar(200),
			LocationType  nvarchar(200),
			Area  nvarchar(200) ,
			Field1 nvarchar(200)
			
			 ) tmp

			 

			 select * from  #tmpDeliveryLocation

PRINT N'Insert DeliveryLocation'

		INSERT INTO [dbo].[Location]
           ([LocationName]
		     ,[LocationCode]
           ,[CompanyID]
		   ,[LocationType]
		   ,[Area]
		   ,[Field1]
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate
		  
          )
    SELECT
			 #tmpDeliveryLocation.DeliveryLocationName
			 , #tmpDeliveryLocation.DeliveryLocationCode
			 ,c.CompanyId
			 ,#tmpDeliveryLocation.LocationType
			 ,#tmpDeliveryLocation.Area
			 ,#tmpDeliveryLocation.[Field1]
			 ,1
			 ,1
			 ,GETDATE()
			
     FROM #tmpDeliveryLocation 
	 left join Location  Dl   ON   #tmpDeliveryLocation.[DeliveryLocationCode]=Dl.LocationCode
	 left join Company  c   ON   #tmpDeliveryLocation.[CompanyMnemonic]=c.CompanyMnemonic
	 WHERE dl.LocationCode is null and c.CompanyId is not null    


PRINT N'Update DeliveryLocation'


UPDATE  dbo.Location

SET LocationName =#tmpDeliveryLocation.[DeliveryLocationName],
LocationType =#tmpDeliveryLocation.[LocationType],
Area =#tmpDeliveryLocation.[Area],
Field1 =#tmpDeliveryLocation.[Field1]
from  #tmpDeliveryLocation 
 left join Location  Dl   ON   #tmpDeliveryLocation.[DeliveryLocationCode]=Dl.LocationCode
	 left join Company  c   ON   #tmpDeliveryLocation.[CompanyMnemonic]=c.CompanyMnemonic
	 WHERE dl.LocationCode is not  null and c.CompanyId is not null    


		


			
        	
           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ItemStock'
