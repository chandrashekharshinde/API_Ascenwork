Create PROCEDURE [dbo].[SSP_LoseAssetsInRunList_SelectByCriteria]
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' OrderMovementId',
@Output nvarchar(max) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql = '(select cast ((SELECT Distinct ''true'' AS [@json:Array] ,o.OrderNumber,lr.PlanNumber,lr.ProductCode,
(lr.ProductQuantity -ISnull((Select Sum(op1.ProductQuantity) from 
OrderMovement om1 join OrderProduct op1 on om1.OrderId=op1.OrderId
where om1.PlanNumber=lr.PlanNumber and op1.ProductCode=lr.ProductCode and om1.LocationType=2),0)) as ProductQuantity
from (Select distinct lr.IsActive,lr.PlanNumber,lr.ProductCode,sum(lr.ProductQuantity) over(Partition by lr.PlanNumber,lr.ProductCode) as ProductQuantity
from LoseAssetsInRun lr ) as lr  left join OrderMovement om on lr.PlanNumber=om.PlanNumber and om.LocationType=1
join [Order] o on o.OrderId=om.OrderId
Where lr.IsActive = 1 and  ' + @WhereExpression + '
 FOR XML PATH(''LoseAssetsProductJson''),ELEMENTS)AS XML))'
 


 SET @Output=@sql

 PRINT @Output

 PRINT 'Executed SSP_LoseAssetsInRunList_SelectByCriteria'
