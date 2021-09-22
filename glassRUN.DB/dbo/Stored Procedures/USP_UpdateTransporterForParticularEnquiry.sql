CREATE PROCEDURE [dbo].[USP_UpdateTransporterForParticularEnquiry] --'<Json><ServicesAction>UpdateBranchPlant</ServicesAction><EnquiryDetailList><BranchPlantName>326</BranchPlantName><EnquiryId>1174,1175</EnquiryId></EnquiryDetailList></Json>'
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
Declare @TransporterName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[EnquiryId],
    @TransporterName = tmp.[TransporterName]
   
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,
   [TransporterName] nvarchar(150)
   )tmp
  

	Declare @CarrierId bigint
	Declare @CarrierCode nvarchar(50)
	Declare @CarrierName nvarchar(500)

	select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyMnemonic = @TransporterName

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
  SELECT @TransporterName as TransporterName FOR XML RAW('Json'),ELEMENTS
   

END