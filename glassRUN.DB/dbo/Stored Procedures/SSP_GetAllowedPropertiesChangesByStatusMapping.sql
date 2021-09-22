CREATE PROCEDURE [dbo].[SSP_GetAllowedPropertiesChangesByStatusMapping] --'<Json><ServicesAction>GetAllCollectionLocationList</ServicesAction><AllowedProperties><OrderId>12759</OrderId><StatusCode>520</StatusCode></AllowedProperties><AllowedProperties><OrderId>12761</OrderId><StatusCode>520</StatusCode></AllowedProperties><AllowedProperties><OrderId>12760</OrderId><StatusCode>100</StatusCode></AllowedProperties></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @NumberOfOrder int



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT * INTO #tmpAllowedProperties
FROM OPENXML(@intpointer,'Json/AllowedProperties',2)
 WITH
 (
 [OrderId] bigint,
[StatusCode] bigint
 ) tmp

Set @NumberOfOrder=(SELECT count(*) From #tmpAllowedProperties);

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  * from (select  
distinct  ROW_NUMBER() OVER(PARTITION BY gc.PropertyName ORDER BY gc.PropertyName ASC) AS RowRank,
ISNULL(gc.IsReasonCode,0) as IsReasonCode,[DataBindingSource],[DataUpdateSource],[ReasonCodeCategory],[ReasonCodeEventName],[FunctionName], LOWER(gc.PropertyName) as PropertyName,gc.PropertyType,gc.GridColumnId,o.OrderNumber,apc.StatusCode
from [dbo].[AllowedPropertiesChangesByStatusMapping] apc join GridColumn gc on apc.GridColumnId=gc.GridColumnId 

JOIN [Order] o on o.CurrentState=apc.StatusCode
where apc.Isactive=1 and gc.IsActive=1 and o.OrderId in (SELECT tmp.[OrderId] From #tmpAllowedProperties tmp) 
and   apc.StatusCode in (SELECT tmp.[StatusCode] From #tmpAllowedProperties tmp) 
and ISNULL(gc.IsEditable,0)=1) as AllowedProperties Where RowRank=@NumberOfOrder
FOR XML path('AllowedPropertiesList'),ELEMENTS,ROOT('Json')) AS XML)


END
