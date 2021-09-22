CREATE PROCEDURE [dbo].[SSP_GetAllPromotionListForB2B] --'<Json><CompanyId>10001</CompanyId></Json>'

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
	   ProDetail.[PromotionFocItemDetailId]
      ,ProDetail.[ItemCode]
      ,ProDetail.[ItemQuanity]
      ,ProDetail.[FocItemCode]
      ,ProDetail.[FocItemQuantity]
      ,ProDetail.[Region]
	  ,FORMAT(ProDetail.[FromDate], 'dd-MMM-yyyy') As [FromDate]
      ,FORMAT(ProDetail.[ToDate], 'dd-MMM-yyyy') As [ToDate]      
      ,ProDetail.[PromotionIdentifier]
      ,ProDetail.[SystemPromotionIdentifier]
      ,ProDetail.[CompanyId]
      ,ProDetail.[IsActive]
      ,ProDetail.[CreatedBy]
      ,ProDetail.[CreatedDate]
      ,ProDetail.[UpdatedBy]
      ,ProDetail.[UpdatedDate]
	  ,isnull(ProDetail.IsShowCarousel,'0')IsShowCarousel
	  ,ProDetail.[ItemUnitOfMeasure] as NormalitemUoM
	  ,ProDetail.[FocItemUnitOfMeasure] as FocItemUoM
	  ,(select cast ((SELECT 'true' AS [@json:Array] , Promapping.CustomerId,
		Promapping.CustomerCode,
		Promapping.SystemPromotionIdentifier,
		Promapping.CompanyId,
		Promapping.IsActive,
		Promapping.CreatedBy 
		from PromotionCustomerMapping Promapping
		where Promapping.CompanyId=ProDetail.[CompanyId] and Promapping.IsActive=1
		and Promapping.SystemPromotionIdentifier=ProDetail.[SystemPromotionIdentifier] 
        FOR XML path('PromotionCustomerMappingList'),ELEMENTS) AS xml)),
		(select cast ((SELECT 'true' AS [@json:Array] ,ShowCaseDetail.SystemPromotionIdentifier as PromotionCode
		,ShowCaseDetail.CultureId	
		,ShowCaseDetail.ProductName	
		,'' as Base64Photo
		,isnull(ShowCaseDetail.SmallImage,'') as ImageUrl
		,ShowCaseDetail.Description as CarouselDescription	
		from showcase ShowCaseDetail
		where  ShowCaseDetail.IsActive=1
		and ShowCaseDetail.SystemPromotionIdentifier=ProDetail.[SystemPromotionIdentifier] 
        FOR XML path('ShowCaseCarouselList'),ELEMENTS) AS xml))
	 from [PromotionFocItemDetail] ProDetail
	 where CompanyId = @companyId
	  FOR XML PATH('PromotionFocItemList'),ELEMENTS,ROOT('Json')) AS XML)

END