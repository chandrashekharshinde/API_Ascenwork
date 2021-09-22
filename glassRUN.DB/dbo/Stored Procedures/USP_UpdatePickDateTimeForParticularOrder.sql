CREATE PROCEDURE [dbo].[USP_UpdatePickDateTimeForParticularOrder]
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId bigint
Declare @pickDateTime datetime


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[OrderId],
   @pickDateTime = tmp.[PickDateTime]
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   [PickDateTime] datetime
   )tmp
  

	update [Order] set PickDateTime = @pickDateTime where OrderId IN (@enquiryId)

	INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='ChangedPickupDate' and IsActive=1),'ChangedPickupDate',OrderId,'Order',1,1,GETDATE() from [Order] Where OrderId=@enquiryId

  SELECT @enquiryId as OrderId FOR XML RAW('Json'),ELEMENTS
   

END