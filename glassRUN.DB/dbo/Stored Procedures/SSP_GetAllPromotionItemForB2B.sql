Create PROCEDURE [dbo].[SSP_GetAllPromotionItemForB2B] --'<Json><CompanyId>10001</CompanyId></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
DECLARE @intPointer INT;
-- ISSUE QUERY
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@companyId = tmp.CompanyId

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint
			)tmp;


;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
 * from (Select  i.ItemId,i.ItemName,i.ItemCode,i.ItemOwner,CompanyId from Item i inner join ItemSupplier isupp on i.ItemId=isupp.ItemId
where CompanyId= @companyId and i.IsActive=1

Union

select   i.ItemId,i.ItemName,i.ItemCode,i.ItemOwner,0 as CompanyId from Item i 
where ItemOwner=@companyId and IsActive=1) tmp
	  FOR XML PATH('PromotionFocItemList'),ELEMENTS,ROOT('Json')) AS XML)

END




