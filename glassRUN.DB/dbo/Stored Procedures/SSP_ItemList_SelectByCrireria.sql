Create PROCEDURE [dbo].[SSP_ItemList_SelectByCrireria]--'SupplierLOBId = 2 AND  Version <> '''''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' ItemId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'ItemId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]	  
      ,I.[ItemShortCode]
      ,I.[PrimaryUnitOfMeasure]
      ,I.[SecondaryUnitOfMeasure]
	  ,(SELECT [dbo].[fn_LookupValueById] (I.[ProductType])) as ProductTypeName
      ,I.[ProductType]
      ,I.[BussinessUnit]
      ,I.[DangerGoods]
      ,I.[Description]
      ,I.[StockInQuantity]
      ,I.[ImageUrl]
      ,I.[PackSize]
     
  FROM [Item] I  
WHERE   IsActive = 1 and ProductType in (select LookUpId from LookUp where LookupCategory in(select LookUpCategoryId from LookUpCategory where Name = ''Returns''))  and ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
FOR XML PATH(''ItemList''),ELEMENTS)AS XML))'


SET @Output=@sql


PRINT 'Executed SSP_ResourceData'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
