

CREATE PROCEDURE [dbo].[SSP_TruckInList] --'<Json><ServicesAction>GetTruckInList</ServicesAction><StockLocationCode>6411,6414,6416,6418,6410</StockLocationCode><CarrierId>1022</CarrierId></Json>'
@xmlDoc xml 
AS 
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
		Declare @PlateNumber nvarchar(50)
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
			[StockLocationCode] nvarchar(100),
			[CarrierId] bigint
        )

        
        
        DECLARE @TruckInDeatilsId BIGINT
		DECLARE @StockLocationCode nvarchar(max)
		DECLARE @CarrierId bigint


		SELECT @StockLocationCode=tmp.[StockLocationCode], @CarrierId = tmp.[CarrierId] from #tempTruckInDeatils tmp

if(@CarrierId=0)
begin   

	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	SELECT CAST((SELECT 'true' AS [@json:Array],[TruckInDeatilsId],[PlateNumber],[TruckId],[DriverName],[DriverId],[TruckInDataTime],[TruckOutDataTime],[StockLocationCode],[IsActive]
	,(select ISNULL(LicenseNumber,'-') from [Login] where LoginId = TruckInDeatils.DriverId) As LicenseNumber
	,(select [CompanyName]+' ('+ISNULL([CompanyMnemonic],'-')+')' from Company where CompanyId = TruckInDeatils.CarrierId) As CarrierName
	,ISNULL((select ISNULL(tio.IsLoadedInTruck,0) from TruckInOrder tio where tio.TruckInDeatilsId = TruckInDeatils.TruckInDeatilsId),0) AS IsLoaded
	,Truckid
	from TruckInDeatils where 
	--This added to get the trucks for only assigned StockLocation
	StockLocationCode = @StockLocationCode and
	--StockLocationCode in (SELECT ID FROM [dbo].[fnSplitValuesForNvarchar] (@StockLocationCode )) and 
	--CarrierId = @CarrierId  and 
	[TruckOutDataTime] is NULL

	FOR XML path('TruckInDeatilsList'),ELEMENTS,ROOT('Json')) AS XML)

end 
	else
begin

		--SELECT * into #tempStockLocations from (
		--	SELECT ID As TcStockLocation FROM [dbo].[fnSplitValuesForNvarchar] (@StockLocationCode )
		--) tmp1

		--SELECT * into #tempStockLocationsNew from (
		--	SELECT ID As GtStockLocation FROM [dbo].[fnSplitValuesForNvarchar] ( (select StockLocationCode from TruckInDeatils where [TruckOutDataTime] is NULL) )
		--) tmp1

		--select * from #tempStockLocations where #tempStockLocations.TcStockLocation in (select #tempStockLocationsNew.GtStockLocation from #tempStockLocationsNew)
		

	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	SELECT CAST((SELECT 'true' AS [@json:Array],[TruckInDeatilsId],[PlateNumber],[TruckId],[DriverName],[DriverId],[TruckInDataTime],[TruckOutDataTime],[StockLocationCode],[IsActive]
	,(select ISNULL(LicenseNumber,'-') from [Login] where LoginId = TruckInDeatils.DriverId) As LicenseNumber
	,(select [CompanyName]+' ('+ISNULL([CompanyMnemonic],'-')+')' from Company where CompanyId = TruckInDeatils.CarrierId) As CarrierName
	,ISNULL((select ISNULL(tio.IsLoadedInTruck,0) from TruckInOrder tio where tio.TruckInDeatilsId = TruckInDeatils.TruckInDeatilsId),0) AS IsLoaded
	,Truckid
	from TruckInDeatils where 
	--StockLocationCode in (SELECT ID FROM [dbo].[fnSplitValuesForNvarchar] (@StockLocationCode )) and 
	--StockLocationCode = (isnull((SELECT STUFF((select ',' +#tempStockLocations.TcStockLocation from #tempStockLocations where #tempStockLocations.TcStockLocation in (select #tempStockLocationsNew.GtStockLocation from #tempStockLocationsNew) FOR XML PATH('')),1, 1, '')),0)) and
	CarrierId = @CarrierId  and 
	 [TruckOutDataTime] is NULL

	FOR XML path('TruckInDeatilsList'),ELEMENTS,ROOT('Json')) AS XML)

	--drop table #tempStockLocations;
	--drop table #tempStockLocationsNew;

end


  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
