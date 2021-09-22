
CREATE PROCEDURE [dbo].[SSP_GetTemplateFormDetailByOrderId] --'<Json><ServicesAction>GetLorryReceiptDetailByOrderId</ServicesAction><OrderId>77827</OrderId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @orderId bigint
declare @templateFormId bigint



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId],
@templateFormId =tmp.[TemplateFormId]
   
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [OrderId] bigint ,
	TemplateFormId bigint
    
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((select tfd.OrderId ,
tfd.TemplateFormId,

   (select cast ((  
  select    'true' AS [@json:Array]  , ControlName  , ControlValue ,LabelName   from  TemplateFormsData  where     ControlName not like '%submit%' and  OrderId=tfd.OrderId  and TemplateFormId=tfd.TemplateFormId 
 FOR XML path('TemplateFormsDataList'),ELEMENTS) AS xml))
 from 
TemplateFormsData   tfd  where  OrderId=@orderId   and TemplateFormId=@templateFormId   group by  OrderId  ,TemplateFormId  
 FOR XML path('TemplateFormsData'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END