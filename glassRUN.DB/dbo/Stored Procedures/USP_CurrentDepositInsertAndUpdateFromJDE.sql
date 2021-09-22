Create  PROCEDURE [dbo].[USP_CurrentDepositInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpCurrentDeposit
			FROM OPENXML(@intpointer,'Json/CurrentDepositList',2)
			 WITH
             (
		
			ItemLongCode nvarchar(500),
			ItemGroup nvarchar(500),
			CustomerNumber  nvarchar(500),
			CustomerGroup nvarchar(500),
			Amount float
				
			 ) tmp

			 

	 select * from  #tmpCurrentDeposit


print N'delete current deposit'
 

 delete from CurrentDeposit 

PRINT N'Insert current'

		INSERT INTO [dbo].[CurrentDeposit]
           ([ItemLongCode]
		     ,[ItemGroup]
           ,[CustomerNumber]
		   ,[CustomerGroup]
		   ,[Amount]
		  
          )
    SELECT
			#tmpCurrentDeposit.[ItemLongCode]
		     ,#tmpCurrentDeposit.[ItemGroup]
           ,#tmpCurrentDeposit.[CustomerNumber]
		   ,#tmpCurrentDeposit.[CustomerGroup]
		   ,#tmpCurrentDeposit.[Amount]
			
     FROM #tmpCurrentDeposit 



	 drop table  #tmpCurrentDeposit
	

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
