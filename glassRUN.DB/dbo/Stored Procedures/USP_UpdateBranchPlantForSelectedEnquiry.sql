CREATE PROCEDURE [dbo].[USP_UpdateBranchPlantForSelectedEnquiry] --'<Json><ServicesAction>UpdateBranchPlantForSelectedEnquiry</ServicesAction><EnquiryDetailList><BranchPlantName>312</BranchPlantName><EnquiryId>510,509</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId nvarchar(500)
Declare @branchPlantCode nvarchar(50)
Declare @StockLocationName nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[EnquiryId],
    @BranchPlantName = tmp.[BranchPlantName]
   
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] nvarchar(500),
   [BranchPlantName] nvarchar(50)  
           
   )tmp
  

  select @branchPlantCode=LocationCode from [Location] where LocationId=@BranchPlantName

  select @StockLocationName=LocationName from [Location] where LocationId=@BranchPlantName


  print @enquiryId
  print @branchPlantCode
 
  update [Enquiry] set StockLocationId  = @branchPlantCode,CollectionLocationCode = @branchPlantCode  where EnquiryId IN (SELECT * FROM [dbo].[fnSplitValues] (@enquiryId))

  update EnquiryProduct set StockLocationCode = @branchPlantCode, StockLocationName =  @StockLocationName where EnquiryId IN (SELECT * FROM [dbo].[fnSplitValues] (@enquiryId))

	SELECT Row_Number() Over(order by tmp.ID) as rownum,* INTO #EnquiryIds FROM (SELECT ID FROM [dbo].[fnSplitValues] (@enquiryId)) tmp


    declare @rownum bigint
	set @rownum=1
	declare @rowCount bigint

	set @rowCount=(select count(*) From #EnquiryIds)
	while(@rownum<=@rowCount)
	begin
						
		Declare @shipToCode nvarchar(50)
		Declare @truckSizeId bigint
		Declare @LocationId bigint

		select @shipToCode =ShipTo from Enquiry where EnquiryId = (select #EnquiryIds.ID from #EnquiryIds where rownum=@rownum)
		select @truckSizeId =TruckSizeId from Enquiry where EnquiryId = (select #EnquiryIds.ID from #EnquiryIds where rownum=@rownum)
		select @LocationId =LocationId from Location where LocationId = @BranchPlantName
			Print @shipToCode
	Print @LocationId
	Print @truckSizeId
		if((select COUNT(*) from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId ) = 1)
		BEGIN

			Declare @CarrierId bigint
			Declare @CarrierCode nvarchar(50)
			Declare @CarrierName nvarchar(500)

			select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyId in (select CarrierNumber from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId)

			update [Enquiry] set CarrierId  = @CarrierId,CarrierCode = @CarrierCode, CarrierName = @CarrierName  where EnquiryId IN ((select #EnquiryIds.ID from #EnquiryIds where rownum=@rownum))

		END
		ELSE
		BEGIN
			update [Enquiry] set CarrierId  = NULL,CarrierCode = NULL, CarrierName = NULL  where EnquiryId IN ((select #EnquiryIds.ID from #EnquiryIds where rownum=@rownum))
		END

		set @rownum=@rownum+1
	end

	drop table #EnquiryIds


  SELECT @BranchPlantName as BranchPlantName FOR XML RAW('Json'),ELEMENTS
   

END
