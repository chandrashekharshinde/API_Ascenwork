
CREATE PROCEDURE [dbo].[SSP_LoadGratisOrder_ByOrderId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>729</OrderId><RoleId>3</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @orderId nvarchar(100)
declare @roleId BIGINT
declare @CultureId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId],
       @roleId = tmp.[RoleId],
       @CultureId = tmp.[CultureId]
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [OrderId] bigint,
    [RoleId] bigint,
    [CultureId] bigint
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
select cast ((SELECT  'true' AS [@json:Array] ,
	OrderId,
	ProductCode,
	ProductQuantity,
	i.ItemName,
	i.ItemId,
	i.ItemCode,
	--(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as PrimaryUnitOfMeasure,
	--(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM,
	--(SELECT [dbo].[fn_LookupValueById] (umo.[RelatedUOM])) as [RelatedUOM],
	 op.CreatedDate,op.IsActive,  ISNULL(op.AssociatedOrder,0) as AssociatedOrder,
	ISNULL(op.ItemType,0) as ItemType
	from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
	--left join UnitOfMeasure umo on I.ItemId=umo.ItemId  
	-- and i.PrimaryUnitOfMeasure=umo.UOM  
	-- and umo.RelatedUOM=16
	WHERE op.IsActive = 1-- AND op.OrderId = o.OrderId  
     and  op.OrderId = @orderId-- OR @orderId = ''
FOR XML path('OrderProductsList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END

