CREATE PROCEDURE [dbo].[SSP_GetSQLCurrentDatetimeAndZone] --'<Rules><RuleId>0</RuleId><RuleType>2</RuleType><RuleName>''Allocation ==1111026 for  ( ''{Item.SKUCode}'' == ''65105011'')''</RuleName><RuleText>if ''{Company.CompanyMnemonic}'' ==''1111026'' &amp; ( ''{Item.SKUCode}'' == ''65105011'') Then {Rule.Result} = literal(''{780}'')</RuleText><SKUCode>65105011</SKUCode><CompanyType>1111026</CompanyType><Remarks>ItemAllocation</Remarks><ShipTo>0</ShipTo><SequenceNumber>0</SequenceNumber><FromDate>2019-07-01T00:00:00</FromDate><ToDate>2019-07-01T00:00:00</ToDate><CreatedBy>0</CreatedBy><CreatedDate>2019-07-01T18:06:47.3952565+05:30</CreatedDate><IsActive>1</IsActive><SequenceNo>0</SequenceNo><AddOrDelete>Y</AddOrDelete><Description>PROM125</Description></Rules>'
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

	DECLARE @tz VARCHAR(50)
EXEC [master].[dbo].[xp_regread]
    'HKEY_LOCAL_MACHINE'
    ,'SYSTEM\CurrentControlSet\Control\TimeZoneInformation'
    ,'TimeZoneKeyName'
    ,@tz OUT;

     SELECT 
    FORMAT (GETDATE(),'yyyy-MM-dd hh:mm:ss') as CurrentDatetime, convert(varchar, getdate(), 126) SyncDateTime, FORMAT(SYSDATETIMEOFFSET(), 'zzz') AS TimeZone,@tz AS TimeZoneName
    , LEFT(PARSENAME(REPLACE(@tz, ' ','.'),3),1) 
    + '' + LEFT(PARSENAME(REPLACE(@tz, ' ','.'),2),1) 
    + '' + LEFT(PARSENAME(REPLACE(@tz, ' ','.'),1),1)   AS TimeZoneShortName 
    FOR XML RAW('Json'),ELEMENTS

    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END