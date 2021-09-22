CREATE PROCEDURE [dbo].[USP_UpdateEnquiryCurrentStockPositionByEnquiryId] --'<Json><ServicesAction>UpdateStatusInEnquiry</ServicesAction><EnquiryId>213</EnquiryId><SchedulingDate>11/11/2017</SchedulingDate><IsRecievingLocationCapacityExceed>0</IsRecievingLocationCapacityExceed></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc




select * into #tmpEnquiry
FROM OPENXML(@intpointer,'Json/Enquiry',2)
			WITH
			(
			[EnquiryId] bigint,
			[CurrentState] bigint
			
			)tmp



select * into #tmpEnquiryProduct
FROM OPENXML(@intpointer,'Json/Enquiry/Item',2)
			WITH
			(
			[EnquiryProductId] bigint,
			[CurrentStockPosition] bigint
			
           
			)tmp





			update Enquiry  set   CurrentState=#tmpEnquiry.CurrentState 
			 from Enquiry e join #tmpEnquiry  on e.EnquiryId = #tmpEnquiry.EnquiryId
			 where e.EnquiryId is not  null



			 update EnquiryProduct  set  CurrentStockPosition =#tmpEnquiryProduct.CurrentStockPosition 
			 from  EnquiryProduct ep    join #tmpEnquiryProduct 
			 on ep.EnquiryProductId= #tmpEnquiryProduct.EnquiryProductId
			 where ep.EnquiryProductId is not null 



			SELECT #tmpEnquiry.[EnquiryId] as EnquiryId   from   #tmpEnquiry  FOR XML RAW('Json'),ELEMENTS

END
