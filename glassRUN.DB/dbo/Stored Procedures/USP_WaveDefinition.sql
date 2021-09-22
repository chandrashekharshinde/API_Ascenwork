-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
Create PROCEDURE [dbo].[USP_WaveDefinition] --'<Json><ServicesAction>SaveWaveDefination</ServicesAction><WaveDefinitionList><WaveDefinitionId>4</WaveDefinitionId><WaveDateTime>8:28AM</WaveDateTime><RuleText>If  ''{Company.CompanyMnemonic}'' = ''5106698'' &amp; ''{TruckSize.TruckSize}'' = ''H2'' Then  ''true''</RuleText><RuleType>9</RuleType><CreatedBy>8</CreatedBy><WaveDefinitionDetailList><WaveDefinitionDetailsId>9</WaveDefinitionDetailsId><WaveDefinitionId>4</WaveDefinitionId><TruckSizeId>16</TruckSizeId><IsActive>1</IsActive><CreatedBy>1</CreatedBy><CreatedDate>2018-04-10T13:41:09.403</CreatedDate><TruckSize>H10</TruckSize></WaveDefinitionDetailList><WaveDefinitionDetailList><WaveDefinitionDetailsId>10</WaveDefinitionDetailsId><WaveDefinitionId>4</WaveDefinitionId><TruckSizeId>20</TruckSizeId><IsActive>1</IsActive><CreatedBy>1</CreatedBy><CreatedDate>2018-04-10T13:41:09.403</CreatedDate><TruckSize>H15</TruckSize></WaveDefinitionDetailList><IsActive>true</IsActive></WaveDefinitionList></Json>'

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max)
	DECLARE @ErrMsg NVARCHAR(max)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @WaveDefinitionId	 bigint
		
            UPDATE dbo.WaveDefinition SET
			@WaveDefinitionId=tmp.WaveDefinitionId,
        	[WaveDateTime]=tmp.[WaveDateTime] ,        	
        	[RuleText]=tmp.[RuleText] ,        	
        	[IsActive]=tmp.IsActive ,
        	[ModifiedBy]=tmp.[ModifiedBy] ,
        	[ModifiedDate]=tmp.[ModifiedDate]
            FROM OPENXML(@intpointer,'Json/WaveDefinitionList',2)
			WITH
			(
			WaveDefinitionId bigint,
            [WaveDateTime] datetime,      
            [RuleText] nvarchar(max),
            [IsActive] bit,           
            [ModifiedBy] bigint,
            [ModifiedDate] datetime
            )tmp WHERE WaveDefinition.WaveDefinitionId=tmp.WaveDefinitionId


			SELECT * INTO #tmpWaveDefinitionDetails 
			FROM OPENXML(@intpointer,'Json/WaveDefinitionList/WaveDefinitionDetailList',2)
			 WITH
             (
			 WaveDefinitionDetailsId bigint,				
            WaveDefinitionId bigint,     
			TruckSizeId bigint,       
			[IsActive] bit
			 ) tmp

			 SELECT * FROM #tmpWaveDefinitionDetails

			 UPDATE WaveDefinitionDetails SET IsActive=0 WHERE WaveDefinitionId=@WaveDefinitionId


			 UPDATE dbo.WaveDefinitionDetails
			 SET dbo.WaveDefinitionDetails.IsActive=#tmpWaveDefinitionDetails.IsActive
			FROM #tmpWaveDefinitionDetails WHERE dbo.WaveDefinitionDetails.WaveDefinitionDetailsId=#tmpWaveDefinitionDetails.WaveDefinitionDetailsId


			INSERT INTO [dbo].WaveDefinitionDetails  ([WaveDefinitionId],[TruckSizeId],[IsActive],CreatedBy,CreatedDate)
     SELECT  	#tmpWaveDefinitionDetails.[WaveDefinitionId], 	#tmpWaveDefinitionDetails.[TruckSizeId], #tmpWaveDefinitionDetails.[IsActive],1,GETDATE()
            FROM #tmpWaveDefinitionDetails
         WHERE #tmpWaveDefinitionDetails.WaveDefinitionDetailsId=0

			 
			 --DELETE dbo.EmailRecepient WHERE IsActive=0


            SELECT  @WaveDefinitionId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailContent'
