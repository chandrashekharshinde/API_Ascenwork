-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
Create PROCEDURE [dbo].[ISP_WaveDefinition] --'<Json><ServicesAction>SaveWaveDefination</ServicesAction><WaveDefinitionList><WaveDefinitionId>0</WaveDefinitionId><WaveDateTime>07:00 am</WaveDateTime><CreatedBy>8</CreatedBy><WaveDefinitionDetailList><WaveDefinitionIdGUID>8f8130e1-94f8-442c-adc0-a62752c277e4</WaveDefinitionIdGUID><WaveDefinitionId>0</WaveDefinitionId><TruckSizeId>17</TruckSizeId><TruckSize>H11</TruckSize><IsActive>true</IsActive></WaveDefinitionDetailList><WaveDefinitionDetailList><WaveDefinitionIdGUID>f1a15eb8-306d-4154-8978-8cc182ead4cc</WaveDefinitionIdGUID><WaveDefinitionId>0</WaveDefinitionId><TruckSizeId>26</TruckSizeId><TruckSize>H27</TruckSize><IsActive>true</IsActive></WaveDefinitionDetailList><WaveDefinitionDetailList><WaveDefinitionIdGUID>35436ad6-6b01-4d0f-bf84-b19aefce4ef4</WaveDefinitionIdGUID><WaveDefinitionId>0</WaveDefinitionId><TruckSizeId>40</TruckSizeId><TruckSize>T10</TruckSize><IsActive>true</IsActive></WaveDefinitionDetailList><IsActive>true</IsActive></WaveDefinitionList></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max) 
	DECLARE @ErrMsg NVARCHAR(max) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @EmailEventId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        INSERT INTO	WaveDefinition
        (
			[WaveDateTime]
			,[RuleText]
			,[RuleType]
			  ,[IsActive]
			  ,[CreatedBy]
			  ,[CreatedDate]
			 
        )

        SELECT
        	tmp.[WaveDateTime],
        	tmp.[RuleText],
        	tmp.[RuleType],        	
        	tmp.[IsActive],
        	tmp.[CreatedBy],
			GETDATE()
            FROM OPENXML(@intpointer,'Json/WaveDefinitionList',2)
        WITH
        (
            [WaveDateTime] datetime,           
            [RuleText] nvarchar(max),
            [RuleType] nvarchar(max),           
            [IsActive] bit,
            [CreatedBy] bigint,
			[CreatedDate] datetime
        )tmp
        
        DECLARE @WaveDefinition bigint
	    SET @WaveDefinition = @@IDENTITY
        
		--SET @EmailEventId=(SELECT EmailEventId FROM dbo.EmailContent WHERE EmailContentId=@EmailContent)


		INSERT INTO [dbo].WaveDefinitionDetails
           (WaveDefinitionId
           ,TruckSizeId          
		   ,[IsActive]
		   ,CreatedBy
		   ,CreatedDate)
     SELECT
        	@WaveDefinition,
        	tmp.TruckSizeId,        	
			tmp.[IsActive]
			,1
			,GETDATE()
            FROM OPENXML(@intpointer,'Json/WaveDefinitionList/WaveDefinitionDetailList',2)
			WITH
        (
            WaveDefinitionId bigint,
            TruckSizeId bigint,           
		   [IsActive] BIT,
		   CreatedBy bigint,
		   CreatedDate datetime
        )tmp

		 DECLARE @WaveDefinitionDetails bigint
	    SET @WaveDefinitionDetails = @@IDENTITY
      
			    SELECT @WaveDefinitionDetails as WaveDefinitionDetails FOR XML RAW('Json'),ELEMENTS

    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
