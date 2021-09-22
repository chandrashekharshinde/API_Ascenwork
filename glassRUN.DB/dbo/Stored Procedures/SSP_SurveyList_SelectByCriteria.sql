CREATE PROCEDURE [dbo].[SSP_SurveyList_SelectByCriteria] --'OrderId IN (SELECT OrderId FROM  dbo.[Order] WHERE CustomerId IN (SELECT ReferenceID FROM dbo.UserDetails WHERE  UserID = 10150  AND CurrentState not in (SELECT  [dbo].[fn_LookupIdByValue](''Unscheduled'')))','',gg
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' SurveyFormId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'SurveyFormId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array],  
 [SurveyFormId]
      ,[OrderId]
	  ,[OrderId] as IntOrderId
      ,[Survey]
	  ,[Survey] as IntSurvey
      ,[Comments]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy] From SurveyForm
 WHERE   IsActive = 1 and ' + @WhereExpression + '
 ORDER BY OrderId	 
FOR XML PATH(''SurveyFormInfos''),ELEMENTS)AS XML))'



 SET @Output=@sql

 PRINT @Output

 PRINT 'Executed SSP_SurveyList_SelectByCriteria'
