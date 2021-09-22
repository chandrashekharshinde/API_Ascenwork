
CREATE PROCEDURE [dbo].[USP_EventMaster] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>239</ItemId><ItemName>bb</ItemName><ItemCode>02</ItemCode><PrimaryUnitOfMeasure>11</PrimaryUnitOfMeasure><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CompanyList><CompanyId>549</CompanyId><CompanyName>AP1-DNTN KIM DAO</CompanyName><CompanyMnemonic>1110139</CompanyMnemonic><CompanyNameAndMnemonic>AP1-DNTN KIM DAO (1110139)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>1600362268</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>0</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><IsSelected>false</IsSelected><SoldTo>549</SoldTo></CompanyList><CompanyList><CompanyId>624</CompanyId><CompanyName>D14 - CONG TY TNHH LINH HUNG</CompanyName><CompanyMnemonic>1111143</CompanyMnemonic><CompanyNameAndMnemonic>D14 - CONG TY TNHH LINH HUNG (1111143)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>1</CountryId><TaxId>0401294332</TaxId><CreatedDate>2017-12-03T21:15:46.297</CreatedDate><IsActive>1</IsActive><ItemSoldToMappingId>3</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><SoldTo>624</SoldTo></CompanyList></ItemList></Json>'

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
        DECLARE @EventMasterId bigint
print @EventMasterId;

        UPDATE dbo.EventMaster 
		SET
			@EventMasterId=tmp.EventMasterId,
			[EventCode]=tmp.[EventCode],
			[EventDescription]=tmp.[EventDescription],
			[IsActive]=tmp.[IsActive],
			UpdatedBy=tmp.UpdatedBy,
        	UpdatedDate  =GETDATE()   	
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
		    [EventMasterId] bigint,
			[EventCode] nvarchar(max),
            [EventDescription] nvarchar(50),
        	IsActive bit,
			UpdatedBy bigint
        )tmp 
		WHERE EventMaster.EventMasterId= tmp.EventMasterId

        SELECT @EventMasterId as EventMasterId FOR XML RAW('Json'),ELEMENTS
        exec sp_xml_removedocument @intPointer

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END