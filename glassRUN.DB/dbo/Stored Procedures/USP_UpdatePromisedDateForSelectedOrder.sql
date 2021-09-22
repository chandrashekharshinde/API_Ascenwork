CREATE PROCEDURE [dbo].[USP_UpdatePromisedDateForSelectedOrder] --'<Json><ServicesAction>UpdateOrderPromisedDate</ServicesAction><OrderDetailList><PromisedDate>26/03/2019</PromisedDate><OrderId>13082</OrderId></OrderDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @OrderId nvarchar(500)
Declare @promisedDate nvarchar(50)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @OrderId = tmp.[OrderId],
    @promisedDate = tmp.[PromisedDate]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] nvarchar(500),
   [PromisedDate] nvarchar(50)  
           
   )tmp
 Print @OrderId
  update [Enquiry] set OrderProposedETD  = convert(datetime,@promisedDate, 103),PromisedDate= convert(datetime,@promisedDate, 103) where EnquiryId IN  (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  

  SELECT @promisedDate as PromisedDate FOR XML RAW('Json'),ELEMENTS
   

END