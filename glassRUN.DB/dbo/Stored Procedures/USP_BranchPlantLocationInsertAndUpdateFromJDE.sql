CREATE  PROCEDURE [dbo].[USP_BranchPlantLocationInsertAndUpdateFromJDE] --''

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
			LocationType  nvarchar(200)
			
			 ) tmp

			 

			 select * from  #tmpDeliveryLocation

PRINT N'Insert DeliveryLocation'

		INSERT INTO [dbo].[Location]
           ([LocationName]
		     ,[LocationCode]
           ,[CompanyID]
		   ,[LocationType]
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate
		  
          )
    SELECT
			 #tmpDeliveryLocation.DeliveryLocationName
			 , #tmpDeliveryLocation.DeliveryLocationCode
			 ,4
			 ,#tmpDeliveryLocation.LocationType
			 ,1
			 ,1
			 ,GETDATE()
			
     FROM #tmpDeliveryLocation 
	 left join Location  Dl   ON   #tmpDeliveryLocation.[DeliveryLocationCode]=Dl.LocationCode
	 WHERE dl.LocationCode is null 


	 print N'update isactive colum of all branch plant'


	 update Location set IsActive =0 where LocationType=21




PRINT N'Update DeliveryLocation'


UPDATE  dbo.Location

SET LocationName =#tmpDeliveryLocation.[DeliveryLocationName],
LocationType =#tmpDeliveryLocation.[LocationType],
IsActive = 1
from  #tmpDeliveryLocation 
 left join Location  Dl   ON   #tmpDeliveryLocation.[DeliveryLocationCode]=Dl.LocationCode
	
	 WHERE dl.LocationCode is not  null 


		


			
        	
           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure BranchPlantLocation'
