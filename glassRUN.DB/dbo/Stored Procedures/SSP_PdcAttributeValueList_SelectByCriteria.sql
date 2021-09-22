Create PROCEDURE [dbo].[SSP_PdcAttributeValueList_SelectByCriteria]
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' PdcAttributeValueId',
@Output nvarchar(2000) output


AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'PdcAttributeValueId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  ,
 PdcAttributeValueId,
 PdcInformationId,
 PdcInformationGuid,
 QuestionVariableMappingId,
 QuestionMasterId,
 Variable,
 Value,
  SectionId

  FROM dbo.PdcAttributeValue
 WHERE  ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
  FOR XML PATH(''PdcAttributeValueList''),ELEMENTS)AS XML))'
 

  SET @Output = @sql


 PRINT 'Executed SSP_PdcAttributeValueList_SelectByCriteria'
