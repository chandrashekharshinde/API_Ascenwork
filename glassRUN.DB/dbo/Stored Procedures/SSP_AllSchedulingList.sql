CREATE PROCEDURE [dbo].[SSP_AllSchedulingList] --''
@FunctionName nvarchar(500)

AS

BEGIN


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT 'true' AS [@json:Array]  ,
		[SchedulingId]
		,[FunctionName]
      ,[IsContinuous]
      ,[SchedulingDate]
      ,[SchedulingTime]
      ,[Freq]
      ,[FreqInterval]
	   ,[IsSpecificTime]
	    ,[SpecificTime]
		  ,[SpecificDay]
		  ,[IsSpecificDay]
		    ,[NextSchedulingTime]
			
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].[Scheduling] where (FunctionName = ISNULL(@FunctionName,'') or ISNULL(@FunctionName,'') = '') and isactive=1  and GETDATE()  >  isNULL( NextSchedulingTime, '2017/01/01') 
 FOR XML PATH('SchedulingList'),ELEMENTS,ROOT('Json')) AS XML)
END
