CREATE PROCEDURE [dbo].[DSP_Enquiry]


@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @enquiryId bigint
Declare @userId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryId = tmp.[EnquiryId],@userId=tmp.[UserId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint,
			[UserId] bigint
           
			)tmp ;
Update
	[Enquiry]
    SET IsActive=0,ModifiedDate=GETDATE(),ModifiedBy=@userId
WHERE

	[EnquiryId] = @enquiryId


	update [Enquiry] SET CurrentState = (select LookUpId from LookUp where Code='Deleted') Where EnquiryId=@enquiryId

	 SELECT EnquiryId as EnquiryId,EnquiryAutoNumber as EnquiryAutoNumber,CurrentState,IsActive from Enquiry where EnquiryId=@EnquiryId FOR XML RAW('Json'),ELEMENTS

END
