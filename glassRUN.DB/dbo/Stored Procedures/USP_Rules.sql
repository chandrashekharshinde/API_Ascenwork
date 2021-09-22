
CREATE PROCEDURE [dbo].[USP_Rules] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>239</ItemId><ItemName>bb</ItemName><ItemCode>02</ItemCode><PrimaryUnitOfMeasure>11</PrimaryUnitOfMeasure><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CompanyList><CompanyId>549</CompanyId><CompanyName>AP1-DNTN KIM DAO</CompanyName><CompanyMnemonic>1110139</CompanyMnemonic><CompanyNameAndMnemonic>AP1-DNTN KIM DAO (1110139)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>1600362268</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>0</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><IsSelected>false</IsSelected><SoldTo>549</SoldTo></CompanyList><CompanyList><CompanyId>624</CompanyId><CompanyName>D14 - CONG TY TNHH LINH HUNG</CompanyName><CompanyMnemonic>1111143</CompanyMnemonic><CompanyNameAndMnemonic>D14 - CONG TY TNHH LINH HUNG (1111143)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>0401294332</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>3</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><SoldTo>624</SoldTo></CompanyList></ItemList></Json>'

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
			DECLARE @RuleId bigint

			SET @RuleTextValue = (Select tmp.[RuleText] FROM OPENXML(@intpointer,'Json',2) WITH ([RuleText] nvarchar(max))tmp)
			SET @RuleType = (Select tmp.[RuleType] FROM OPENXML(@intpointer,'Json',2) WITH ([RuleType] nvarchar(max))tmp)
			SET @RuleId = (Select tmp.[RuleId] FROM OPENXML(@intpointer,'Json',2) WITH ([RuleId] nvarchar(max))tmp)
			DECLARE @existingcount bigint
            set @existingcount=(Select COUNT(*) from Rules where IsActive=1 and LEFT(RuleText, CHARINDEX('Then', RuleText) - 1) = LEFT(@RuleTextValue, CHARINDEX('Then', @RuleTextValue) - 1) and RuleType = @RuleType and RuleId <> @RuleId)

		If( @existingcount= 0)
			Begin 

				   UPDATE dbo.Rules SET
					@RuleId=tmp.RuleId,
					[RuleType] = tmp.[RuleType],
					[RuleText] = tmp.[RuleText],

					[Remarks] = isnull(tmp.[Remarks],tmp.[RuleName]),

					[SequenceNumber] = tmp.[SequenceNumber],
					--[FromDate] = Case When tmp.[FromDate] = DATEADD(DAY, -1, GETDATE()) then null else tmp.[FromDate] end,
					--[ToDate] = Case When tmp.[ToDate] = DATEADD(year,50,GETDATE()) then null else tmp.[ToDate] end,
					[FromDate] = Case When tmp.[FromDate] = '' then DATEADD(DAY, -1, GETDATE()) else tmp.[FromDate] end,
					[ToDate] = Case When tmp.[ToDate] = '' then DATEADD(year,50,GETDATE()) else tmp.[ToDate] end,
					[IsActive] = tmp.[IsActive],

					[ModifiedBy] = tmp.[ModifiedBy],
					[ModifiedDate] = GETDATE(),
					[RuleName]=tmp.[RuleName],
					[IsResponseRequired] =tmp.[IsResponseRequired],
					[Enable] =tmp.[Enable],
					[ResponseProperty] =tmp.[ResponseProperty]

				   FROM OPENXML(@intpointer,'Json',2)
					WITH
					(
				   [RuleId] bigint,           
				   [RuleType] bigint,
					[RuleText] nvarchar(max),      
					[RuleName] nvarchar(max),  	
					[CompanyType] nvarchar(max),
					[Remarks] nvarchar(max),
					[ShipTo] bigint,
					[SequenceNumber] bigint,
					[FromDate] datetime,
					[ToDate] datetime,
						[IsResponseRequired] bit,
								[Enable] bit,
								[ResponseProperty] nvarchar(max),
					[IsActive] bit,
					[SequenceNo] bigint,
					[ModifiedBy] bigint

				   )tmp WHERE Rules.RuleId=tmp.RuleId
			End
		Else
			Begin
				Set @RuleId = -1
			ENd

	    SELECT @RuleId as RuleId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
