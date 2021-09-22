-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Tuesday, September 19, 2017
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.Rules table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_InsertAndUpdateAllocationRules] --'<Rules><RuleId>0</RuleId><RuleType>2</RuleType><RuleName>''Allocation ==1111026 for  ( ''{Item.SKUCode}'' == ''65105011'')''</RuleName><RuleText>if ''{Company.CompanyMnemonic}'' ==''1111026'' &amp; ( ''{Item.SKUCode}'' == ''65105011'') Then {Rule.Result} = literal(''{780}'')</RuleText><SKUCode>65105011</SKUCode><CompanyType>1111026</CompanyType><Remarks>ItemAllocation</Remarks><ShipTo>0</ShipTo><SequenceNumber>0</SequenceNumber><FromDate>2019-07-01T00:00:00</FromDate><ToDate>2019-07-01T00:00:00</ToDate><CreatedBy>0</CreatedBy><CreatedDate>2019-07-01T18:06:47.3952565+05:30</CreatedDate><IsActive>1</IsActive><SequenceNo>0</SequenceNo><AddOrDelete>Y</AddOrDelete><Description>PROM125</Description></Rules>'
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


        
        Select * Into #temp  FROM OPENXML(@intpointer,'Rules',2)
        WITH
        (
		[RuleId] [bigint] ,
        [RuleType] [bigint] ,
		[RuleText] [nvarchar](max) ,
		[RuleName] [nvarchar](max) ,
		[SKUCode]  [nvarchar](max) ,
		[CompanyType] [nvarchar](200) ,
		[Remarks] [nvarchar](max) ,
		[AddOrDelete] [nvarchar](max) ,
		[ShipTo] [bigint] ,
		[SequenceNumber] [bigint] ,
		[FromDate] [datetime] ,
		[ToDate] [datetime] ,
		[CreatedBy] [bigint] ,
		[CreatedDate] [datetime] ,
		[ModifiedBy] [bigint] ,
		[ModifiedDate] [datetime] ,
		[IsActive] [bit] ,
		[SequenceNo] [bigint] ,
		[Description] [nvarchar](500) 
        )tmp
        
		
		
		Update Rules set IsActive=0,ModifiedDate=GETDATE() where RuleId in (select RuleId from #temp t)


		
CREATE TABLE #TempTable
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    code nvarchar(50)
)
DECLARE @stringId VARCHAR(100);
INSERT INTO #TempTable (code)
SELECT * FROM [dbo].[fnSplitValues] ((select top 1 [SKUCode] from #temp))

DECLARE @ID int

SELECT @ID =1 

WHILE @ID <= (SELECT COUNT(code) FROM #TempTable)

-- while some condition is true, then do the following
--actions between the BEGIN and END

BEGIN

Update Rules set IsActive=0,ModifiedDate=GETDATE() where RuleId in (
	   select r.RuleId from Rules r join #temp t on r.RuleType=t.RuleType and (SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (r.[RuleId],'CompanyMnemonic'))=t.CompanyType  where 
	   (', ' + (SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (r.[RuleId],'SKUCode')) + ',' LIKE '%, ' + (SELECT code FROM #TempTable WHERE Id = @ID) + ',%') and t.AddOrDelete = 'N')

	   


		Update Rules set IsActive=0,ModifiedDate=GETDATE() where RuleId in (
		select r.RuleId from Rules r join #temp t on r.RuleType=t.RuleType and (SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (r.[RuleId],'CompanyMnemonic'))=t.CompanyType  where 
	    (', ' + (SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (r.[RuleId],'SKUCode')) + ',' LIKE '%, ' + (SELECT code FROM #TempTable WHERE Id = @ID) + ',%') and t.AddOrDelete = 'Y'
	    and Convert(date,GETDATE()) between isnull(t.FromDate,Convert(date,GETDATE())) and isnull(t.ToDate,Convert(date,GETDATE())))


SET @ID = @ID + 1

END
Drop table #TempTable


		INSERT INTO	[Rules]
        (
         [RuleType]
		,[RuleText]
		,[RuleName]
		,[Remarks]

		
		,[FromDate]
		,[ToDate]
		,[CreatedBy]
		,[CreatedDate]
		,[ModifiedBy]
		,[ModifiedDate]
		,[IsActive]
		,[Enable]
		,IsResponseRequired
		,SequenceNumber
		,[Field1]
        )

        SELECT
         tmp.[RuleType]
		,tmp.[RuleText]
	,tmp.[RuleName]
		,tmp.[Remarks]
	
		
		,tmp.[FromDate]
		,tmp.[ToDate]
		,tmp.[CreatedBy]
		,tmp.[CreatedDate]
		,tmp.[ModifiedBy]
		,tmp.[ModifiedDate]
		,tmp.[IsActive]
		,1
		,1
		,1
		,tmp.[Description]
		
		from #temp tmp where tmp.AddOrDelete != 'N'

        DECLARE @Rules bigint
	    SET @Rules = @@IDENTITY
        
		Declare @companyType nvarchar(200)
		SET @companyType=(select top 1 #temp.[CompanyType] from #temp)
		INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster 
		where EventCode='Allocation' and IsActive=1),'Allocation',(Select top 1 CompanyId from Company where CompanyMnemonic=@companyType),'Company',1,1,GETDATE() 

        --Add child table insert procedure when required.
    
    SELECT @Rules as RulesId FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
