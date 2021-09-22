
CREATE PROCEDURE [dbo].[SSP_UpdateTemplateFormsDataIsGeneration] --'<Json><ServicesAction>GetLorryReceiptDetailByOrderId</ServicesAction><OrderId>77827</OrderId></Json>'

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




   update TemplateFormsData  set  isgeneration=1  where OrderId=@orderId  and TemplateFormId=@templateFormId
 
 
     SELECT 'Success' as ReponseMessage FOR XML RAW('Json'),ELEMENTS


 
END