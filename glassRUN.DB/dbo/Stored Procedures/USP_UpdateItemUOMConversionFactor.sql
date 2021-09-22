CREATE PROCEDURE [dbo].[USP_UpdateItemUOMConversionFactor] --'<Json><ServicesAction>UpdateShipToNameAndStatus</ServicesAction><ShipToList><DeliveryLocationId>1047</DeliveryLocationId><rownumber>1</rownumber><TotalCount>655</TotalCount><CompanyName>Larue - MKT</CompanyName><CompanyMnemonic>52476482</CompanyMnemonic><DeliveryLocationName>Larue - MKT</DeliveryLocationName><DisplayName>fghgjh</DisplayName><DeliveryLocationCode>52476482</DeliveryLocationCode><Area>HC1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1045</DeliveryLocationId><rownumber>2</rownumber><TotalCount>655</TotalCount><CompanyName>Heineken - MKT</CompanyName><CompanyMnemonic>52036482</CompanyMnemonic><DeliveryLocationName>Heineken - MKT</DeliveryLocationName><DisplayName>fghghhgfhg</DisplayName><DeliveryLocationCode>52036482</DeliveryLocationCode><Area>HCM</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1043</DeliveryLocationId><rownumber>3</rownumber><TotalCount>655</TotalCount><CompanyName>QN44-CONG TY TNHH THYNA MINH</CompanyName><CompanyMnemonic>1111692</CompanyMnemonic><DeliveryLocationName>QN44-CONG TY TNHH THYNA MINH</DeliveryLocationName><DisplayName>QN44-CONG TY TNHH THYNA MINH</DisplayName><DeliveryLocationCode>1111692</DeliveryLocationCode><Area>C4</Area><IsActive>false</IsActive></ShipToList><ShipToList><DeliveryLocationId>1042</DeliveryLocationId><rownumber>4</rownumber><TotalCount>655</TotalCount><CompanyName>Strongbow - E4</CompanyName><CompanyMnemonic>51416433</CompanyMnemonic><DeliveryLocationName>Strongbow - E4</DeliveryLocationName><DisplayName>fdsdfgfggsffg</DisplayName><DeliveryLocationCode>51416433</DeliveryLocationCode><Area>E1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1041</DeliveryLocationId><rownumber>5</rownumber><TotalCount>655</TotalCount><CompanyName>AP20-CONG TY TNHH MTV HONG THAI KHANG</CompanyName><CompanyMnemonic>1111690</CompanyMnemonic><DeliveryLocationName>AP20-CONG TY TNHH MTV HONG THAI KHANG</DeliveryLocationName><DisplayName>AP20-CONG TY TNHH MTV HONG THAI KHANG</DisplayName><DeliveryLocationCode>1111690</DeliveryLocationCode><Area>S3</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1040</DeliveryLocationId><rownumber>6</rownumber><TotalCount>655</TotalCount><CompanyName>Larue Special- QN</CompanyName><CompanyMnemonic>52526441</CompanyMnemonic><DeliveryLocationName>Larue Special- QN</DeliveryLocationName><DisplayName>Larue Special- QN</DisplayName><DeliveryLocationCode>52526441</DeliveryLocationCode><Area>C1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1039</DeliveryLocationId><rownumber>7</rownumber><TotalCount>655</TotalCount><CompanyName>Heineken Vietnam Brewery Limited</CompanyName><CompanyMnemonic>7</CompanyMnemonic><DeliveryLocationName>Heineken Vietnam Brewery Limited</DeliveryLocationName><DisplayName>Heineken Vietnam Brewery Limited</DisplayName><DeliveryLocationCode>7</DeliveryLocationCode><Area>HC1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1038</DeliveryLocationId><rownumber>8</rownumber><TotalCount>655</TotalCount><CompanyName>Desperados - C2</CompanyName><CompanyMnemonic>53546431</CompanyMnemonic><DeliveryLocationName>Desperados - C2</DeliveryLocationName><DisplayName>Desperados - C2</DisplayName><DeliveryLocationCode>53546431</DeliveryLocationCode><Area>E1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1037</DeliveryLocationId><rownumber>9</rownumber><TotalCount>655</TotalCount><CompanyName>Strongbow - C2</CompanyName><CompanyMnemonic>51416431</CompanyMnemonic><DeliveryLocationName>Strongbow - C2</DeliveryLocationName><DisplayName>Strongbow - C2</DisplayName><DeliveryLocationCode>51416431</DeliveryLocationCode><Area>E1</Area><IsActive>true</IsActive></ShipToList><ShipToList><DeliveryLocationId>1033</DeliveryLocationId><rownumber>10</rownumber><TotalCount>655</TotalCount><CompanyName>AP19-HO KINH DOANH PHAM THUY LINH</CompanyName><CompanyMnemonic>1111687</CompanyMnemonic><DeliveryLocationName>AP19-HO KINH DOANH PHAM THUY LINH</DeliveryLocationName><DisplayName>AP19-HO KINH DOANH PHAM THUY LINH</DisplayName><DeliveryLocationCode>1111687</DeliveryLocationCode><Area>S3</Area><IsActive>true</IsActive></ShipToList></Json>'

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

			
           
			SELECT * INTO #tmpUnitOfMeasure
			FROM OPENXML(@intpointer,'Json/UnitOfMeasureList',2)
			 WITH
             (
			 [UnitOfMeasureId] int,
			 [ItemId] int,
			 [UOM] int,
			 [RelatedUOM] Int,
			 [UOMStructure] nvarchar(50),
			 [ConversionFactor] nvarchar(50),
			 [ConversionFactorSecondaryToPrimary] nvarchar(50),
			 [IsActive] bit
			 ) tmp

			

		   UPDATE UnitOfMeasure 
		   SET 
		   UnitOfMeasure.UOM = #tmpUnitOfMeasure.UOM,
		   UnitOfMeasure.RelatedUOM = #tmpUnitOfMeasure.RelatedUOM,
		   UnitOfMeasure.ConversionFactor = #tmpUnitOfMeasure.ConversionFactor,
		   UnitOfMeasure.IsActive = #tmpUnitOfMeasure.IsActive,
		   UnitOfMeasure.UpdatedDate = GETDATE()
		   FROM #tmpUnitOfMeasure WHERE dbo.UnitOfMeasure.UnitOfMeasureId = #tmpUnitOfMeasure.UnitOfMeasureId 


		   INSERT INTO UnitOfMeasure  (
		   [ItemId],
		   [UOM],
		   [RelatedUOM],
		   [UOMStructure],
		   [ConversionFactor],
		   [ConversionFactorSecondaryToPrimary],
		   [IsActive]
		   )
     SELECT  	#tmpUnitOfMeasure.[ItemId], 
	        	#tmpUnitOfMeasure.[UOM], 	
		        #tmpUnitOfMeasure.[RelatedUOM],
            	NULL,
		    	#tmpUnitOfMeasure.[ConversionFactor],
		    	NULL,
				#tmpUnitOfMeasure.[IsActive]
                FROM #tmpUnitOfMeasure
                WHERE #tmpUnitOfMeasure.UnitOfMeasureId=0

				
        SELECT 1 as UnitOfMeasureId FOR XML RAW('Json'),ELEMENTS
        exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_UpdateShipToNameAndStatus'
