Create PROCEDURE [dbo].[SSP_UnitOfMeasure]--'SupplierLOBId = 2 AND  Version <> '''''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' UnitOfMeasureId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'UnitOfMeasureId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , UnitOfMeasureId,ItemId ,UOM ,RelatedUOM,
UOMStructure,ConversionFactor, ConversionFactorSecondaryToPrimary
FROM dbo.UnitOfMeasure 
WHERE   IsActive = 1  and ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
FOR XML PATH(''UnitOfMeasureList''),ELEMENTS)AS XML))'


SET @Output=@sql


PRINT 'Executed SSP_ResourceData'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
