CREATE PROCEDURE [dbo].[USP_UpdateBranchPlantForParticularEnquiry] --'<Json><ServicesAction>UpdateBranchPlant</ServicesAction><EnquiryDetailList><BranchPlantName>326</BranchPlantName><EnquiryId>1174,1175</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId bigint
Declare @branchPlantCode nvarchar(50)
Declare @shipToCode nvarchar(50)
Declare @truckSizeId bigint
Declare @LocationId bigint

Declare @StockLocationName nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[EnquiryId],
    @BranchPlantName = tmp.[BranchPlantName]
   
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,
   [BranchPlantName] nvarchar(50)
   )tmp
  

  select @branchPlantCode=LocationCode from [Location] where LocationCode=@BranchPlantName

  select @StockLocationName=LocationName from [Location] where LocationCode=@BranchPlantName

  select @shipToCode =ShipTo from Enquiry where EnquiryId = @enquiryId
  select @truckSizeId =TruckSizeId from Enquiry where EnquiryId = @enquiryId

  select @LocationId =LocationId from Location where LocationCode = @BranchPlantName


  print @enquiryId
  print @branchPlantCode
 
  update [Enquiry] set StockLocationId  = @branchPlantCode,CollectionLocationCode = @branchPlantCode  where EnquiryId IN (@enquiryId)

  update EnquiryProduct set StockLocationCode = @branchPlantCode, StockLocationName =  @StockLocationName where EnquiryId IN (@enquiryId)


  if((select COUNT(*) from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 ) = 1)
  BEGIN
	
	Declare @CarrierId bigint
	Declare @CarrierCode nvarchar(50)
	Declare @CarrierName nvarchar(500)

	select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyId in (select CarrierNumber from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 )

	update [Enquiry] set CarrierId  = @CarrierId,CarrierCode = @CarrierCode, CarrierName = @CarrierName  where EnquiryId IN (@enquiryId)

	--INSERT INTO [dbo].[EventNotification]
 --          ([EventMasterId]
 --          ,[EventCode]
 --          ,[ObjectId]
 --          ,[ObjectType]
 --          ,[IsActive]
 --          ,[CreatedBy]
 --          ,[CreatedDate])
	--	Select (Select top 1 EventMasterId from EventMaster 
	--	where EventCode='OrderAssignedToTransporter' and IsActive=1),'OrderAssignedToTransporter',@enquiryId,'Enquiry',1,1,GETDATE() 

  END
  ELSE
  BEGIN
	update [Enquiry] set CarrierId  = NULL,CarrierCode = NULL, CarrierName = NULL  where EnquiryId IN (@enquiryId)
  END

  SELECT @BranchPlantName as BranchPlantName FOR XML RAW('Json'),ELEMENTS
   

END