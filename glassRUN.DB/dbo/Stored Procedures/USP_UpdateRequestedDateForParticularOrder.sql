CREATE PROCEDURE [dbo].[USP_UpdateRequestedDateForParticularOrder]
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId bigint
Declare @requestedDate datetime
Declare @pickDateTime datetime


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[OrderId],
    @requestedDate = tmp.[RequestedDate],
   @pickDateTime = tmp.[PickDateTime]
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   [RequestedDate] datetime,
   [PickDateTime] datetime
   )tmp
  

	update [Order] set ExpectedTimeOfDelivery  = @requestedDate,PickDateTime = @pickDateTime where OrderId IN (@enquiryId)



	INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='ChangedPromisedDate' and IsActive=1),'ChangedPromisedDate',OrderId,'Order',1,1,GETDATE() from [Order] Where OrderId=@enquiryId



  SELECT @enquiryId as OrderId FOR XML RAW('Json'),ELEMENTS
   

END