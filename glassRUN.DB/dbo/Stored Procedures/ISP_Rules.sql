
CREATE PROCEDURE [dbo].[ISP_Rules] --'<Json><RuleId>0</RuleId><ServicesAction>InsertRule</ServicesAction><RuleType>5</RuleType><RuleText>If  ''{DeliveryLocation.Area}'' == ''HC4'' &amp; ''{TruckSize.TruckSize}'' == ''10'' Then 8</RuleText><CompanyType></CompanyType><Remarks>AreaPalettesCount</Remarks><ShipTo></ShipTo><SequenceNumber>1</SequenceNumber><FromDate></FromDate><ToDate></ToDate><CreatedBy>12</CreatedBy><ModifiedBy>12</ModifiedBy><IsActive>1</IsActive><SequenceNo>1</SequenceNo></Json>'
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
			
			Declare @RuleTextValue nvarchar(max)
			Declare @RuleType nvarchar(100)

			SET @RuleTextValue = (Select tmp.[RuleText] FROM OPENXML(@intpointer,'Json',2) WITH ([RuleText] nvarchar(max))tmp)
			SET @RuleType = (Select tmp.[RuleType] FROM OPENXML(@intpointer,'Json',2) WITH ([RuleType] nvarchar(max))tmp)

			print @RuleTextValue

			DECLARE @RuleId bigint
			DECLARE @existingcount bigint
			set @existingcount=(Select COUNT(*) from Rules where IsActive=1 and LEFT(RuleText, CHARINDEX('Then', RuleText) - 1) = LEFT(@RuleTextValue, CHARINDEX('Then', @RuleTextValue) - 1) and RuleType = @RuleType)




		If( @existingcount = 0)
			Begin 

							INSERT INTO	[Rules]
						    (
						   [RuleType]
						  ,[RuleText]  
						  ,[RuleName]   
						  ,[Remarks]
						  ,[SequenceNumber]
						  ,[FromDate]
						  ,[ToDate]
						  ,[IsResponseRequired]
						  ,[ResponseProperty]
						  ,[Enable]
						  ,[CreatedBy]
						  ,[CreatedDate]
						  ,[IsActive]
						 
						    )

						    SELECT
						    	
						    	tmp.[RuleType],
								tmp.[RuleText],	
								tmp.[RuleName], 		
								isnull(tmp.[Remarks],tmp.[RuleName]),
								tmp.[SequenceNumber],
								Case When tmp.[FromDate] = '' then DATEADD(DAY, -1, GETDATE()) else tmp.[FromDate] end,
								Case When tmp.[ToDate] = '' then DATEADD(year,50,GETDATE()) else tmp.[ToDate] end,
							  tmp.[IsResponseRequired],
								tmp.[ResponseProperty],
								tmp.[Enable],
								tmp.[CreatedBy],
								GETDATE(),
								tmp.[IsActive]
						        FROM OPENXML(@intpointer,'Json',2)
						    WITH
						    (
						        [RuleType] bigint,
						    	[RuleText] nvarchar(max),        	
								[RuleName] nvarchar(max), 
						    	[Remarks] nvarchar(max),
						    
						    	[SequenceNumber] bigint,
								[FromDate] datetime,
								[ToDate] datetime,
								[IsResponseRequired] bit,
								[Enable] bit,
								[ResponseProperty] nvarchar(max),
						    	[CreatedBy] bigint,
								[CreatedDate] datetime,
						    	[IsActive] bit
						    )tmp
						    
						    
						    SET @RuleId = @@IDENTITY

			End
		Else
			Begin  
							Set @RuleId = -1
			End
			
			


        
        


    SELECT @RuleId as RuleId FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
