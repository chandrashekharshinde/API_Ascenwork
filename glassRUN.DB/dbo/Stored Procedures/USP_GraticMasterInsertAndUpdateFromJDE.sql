CREATE  PROCEDURE [dbo].[USP_GraticMasterInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpCompany
			FROM OPENXML(@intpointer,'Json/GratisList',2)
			 WITH
             (
		
			CompanyName nvarchar(500),			        
			CompanyMnemonic nvarchar(200),
			CompanyType  nvarchar(200),
			LocationType  nvarchar(200),
			Area  nvarchar(200),
			TaxId  nvarchar(250)
			
			 ) tmp

			 

			 select * from  #tmpCompany

PRINT N'Insert Company'

		INSERT INTO [dbo].[Company]
           ([CompanyName]
           ,[CompanyMnemonic]
		   ,[CompanyType]
		   ,TaxId
		   ,ParentCompany
		   , CountryId
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate
		  ,Field10
          )
    SELECT
			 #tmpCompany.CompanyName
			 , #tmpCompany.CompanyMnemonic
			 ,#tmpCompany.CompanyType
			  ,#tmpCompany.TaxId
			 ,4
			 ,1
			 ,1
			 ,1
			 ,GETDATE()
			,'G'
     FROM #tmpCompany LEFT JOIN dbo.Company c ON   #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic
	  	
	  	  WHERE c.CompanyId IS null


PRINT N'Update Company'


UPDATE  dbo.Company

SET CompanyName =#tmpCompany.[CompanyName],
TaxId =#tmpCompany.[TaxId],
CompanyType =#tmpCompany.[CompanyType],
Field10 ='G'
FROM #tmpCompany  LEFT JOIN dbo.Company c ON  #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic  WHERE c.CompanyId  IS not  null





------------------------------------


			
PRINT N'Insert DeliveryLocation'

		INSERT INTO [dbo].[Location]
           ([LocationName]
		     ,[LocationCode]
           ,[CompanyID]
		   ,[LocationType]
		   ,[Area]
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate
		  
          )
    SELECT
			 #tmpCompany.CompanyName
			 ,  #tmpCompany.CompanyMnemonic
			 ,c.CompanyId
			 ,#tmpCompany.LocationType
			 ,#tmpCompany.Area
			 ,1
			 ,1
			 ,GETDATE()
			
     FROM #tmpCompany 
	 left join Location  Dl   ON   #tmpCompany.[CompanyMnemonic]=Dl.LocationCode
	 left join Company  c   ON   #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic
	 WHERE dl.LocationCode is null and c.CompanyId is not null    


PRINT N'Update DeliveryLocation'


UPDATE  dbo.Location

SET LocationName =#tmpCompany.[CompanyName],
LocationType =#tmpCompany.[LocationType],
Area =#tmpCompany.[Area]
from  #tmpCompany 
 left join Location  Dl   ON   #tmpCompany.[CompanyMnemonic]=DL.LocationCode
	 left join Company  c   ON   #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic
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

PRINT 'Successfully created procedure   sp GraticMasterInsertAndUpdateFromJDE'
