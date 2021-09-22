Create PROCEDURE [dbo].[SSP_OrderActivity_ByOrderActivityId] --1
@OrderActivityId BIGINT
AS
BEGIN

	SELECT  [OrderActivityId]
      ,[CompanyType]
      ,[OrderType]
      ,[CompanyID]
      ,[ModeOfDelivery]
      ,[ProcessCategory]
      ,[LastStageId]
      ,[ProcessName]
      ,[NextStageId]
      ,[RuleId]
      ,[NotificationId]
      ,[Remarks]
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
	FROM [dbo].[OrderActivity]
	 WHERE (OrderActivityId=@OrderActivityId OR @OrderActivityId=0) AND IsActive=1
	FOR XML RAW('@OrderActivity'),ELEMENTS
	
	
	
END
