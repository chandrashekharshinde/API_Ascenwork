CREATE PROCEDURE [dbo].[SSP_Enquiry_ByEnquiryId] --10
@enquiryId BIGINT
AS
BEGIN

	Select Cast((SELECT [EnquiryId]
      ,[EnquiryAutoNumber]
    
      ,CONVERT(varchar(11),[RequestDate],103) as RequestDate
      ,[PrimaryAddress]
      ,[SecondaryAddress]
	  ,CONVERT(varchar(11),[OrderProposedETD],103) as RequestDate
      ,[Remarks]
      ,[PreviousState]
      ,[CurrentState]
	  ,[TruckSizeId]
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
	  , (select cast ((SELECT   [EnquiryProductId]
      ,[EnquiryId]
      ,[ProductCode]
	  ,(SELECT ItemId FROM dbo.Item WHERE ItemCode=[ProductCode]) AS ItemId
	  ,(SELECT ItemName FROM dbo.Item WHERE ItemCode=[ProductCode]) AS ItemName
	   
	   ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
	   ,(SELECT WeightPerUnit FROM dbo.Item WHERE ItemCode=[ProductCode]) AS WeightPerUnit
      ,ep.[ProductType]
      ,ep.[ProductQuantity]
      ,ep.[Remarks]
      ,ep.[CreatedBy]
      ,ep.[CreatedDate]
      ,ep.[ModifiedBy]
      ,ep.[ModifiedDate]
      ,ep.[IsActive]
      ,ep.[SequenceNo]
		from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
			join UnitOfMeasure umo on I.ItemId=umo.ItemId 
   WHERE ep.IsActive = 1 AND ep.EnquiryId = [Enquiry].EnquiryId and  i.IsActive = 1 and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
 FOR XML RAW('EnquiryProductList'),ELEMENTS) AS xml))
	FROM [dbo].[Enquiry]
	 WHERE (EnquiryId=@enquiryId OR @enquiryId=0) AND IsActive=1
	FOR XML RAW('EnquiryList'),ELEMENTS,ROOT('Enquiry')) AS XML)
	
	
	
END
