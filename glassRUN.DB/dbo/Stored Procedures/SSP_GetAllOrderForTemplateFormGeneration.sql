
CREATE PROCEDURE [dbo].[SSP_GetAllOrderForTemplateFormGeneration] --1

AS
BEGIN


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast(( select  'true' AS [@json:Array], OrderId  ,TemplateFormId   From  TemplateFormsData   where isnull(IsGeneration,0)=0   group by  OrderId  ,TemplateFormId  
FOR XML path('TemplateFormDataList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END