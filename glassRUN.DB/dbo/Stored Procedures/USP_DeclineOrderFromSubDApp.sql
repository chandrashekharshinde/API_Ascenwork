
CREATE PROCEDURE [dbo].[USP_DeclineOrderFromSubDApp] 
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[EnquiryId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [EnquiryId] bigint
   )tmp
 
  update [Enquiry] set CurrentState = 999 where EnquiryId IN (@enquiryId)


  SELECT @enquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS
   

END