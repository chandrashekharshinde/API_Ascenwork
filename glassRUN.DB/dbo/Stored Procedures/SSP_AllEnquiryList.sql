CREATE PROCEDURE [dbo].[SSP_AllEnquiryList] 
AS
BEGIN

SELECT CAST((SELECT [EnquiryId]
      ,[EnquiryAutoNumber]
     
      ,[RequestDate]
     
      ,[PrimaryAddress]
      ,[SecondaryAddress]
      ,[OrderProposedETD]
      ,[Remarks]
      ,[PreviousState]
      ,[CurrentState]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
  FROM [Enquiry] WHERE IsActive = 1
	FOR XML RAW('EnquiryList'),ELEMENTS,ROOT('Enquiry')) AS XML)
END
