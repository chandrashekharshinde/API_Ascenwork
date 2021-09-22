
CREATE PROCEDURE [dbo].[SSP_GetActivePromotionFocItemForB2B] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint
Declare @Region nvarchar(max)=''
Declare @CustomerCode nvarchar(max)=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
		,@Region=tmp.[Region]
	   ,@CustomerCode=tmp.[CustomerCode]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
			[CustomerCode] nvarchar(max),
			[Region] nvarchar(max)
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , [PromotionFocItemDetailId]
      ,p.[ItemCode]
	  ,(Select I.ItemId from Item I where I.ItemCode=p.[ItemCode]) as ItemId
      ,p.[ItemQuanity]
      ,p.[FocItemCode]
	   ,(Select I.ItemId from Item I where I.ItemCode=p.[FocItemCode]) as FocItemId
      ,p.[FocItemQuantity]
      ,p.[Region]
      ,p.[IsActive]
      ,p.PromotionIdentifier
      ,p.SystemPromotionIdentifier
	  ,p.FromDate
	  ,p.ToDate

  FROM [dbo].[PromotionFocItemDetail] p where p.IsActive=1 
  and p.SystemPromotionIdentifier in (Select pcm.SystemPromotionIdentifier 
  from PromotionCustomerMapping pcm where (pcm.CustomerCode=@CustomerCode or @CustomerCode=''))
    and Convert(date,GETDATE()) between isnull(p.FromDate,dateadd(dd,-360,Convert(date,getdate()))) and isnull(p.ToDate,dateadd(dd,360,Convert(date,getdate())))
  and p.PromotionFocItemDetailId not in  (Select max(pd.PromotionFocItemDetailId)
From PromotionFocItemDetail pd
where  
Convert(date,GETDATE()) between isnull(pd.FromDate,dateadd(dd,-360,Convert(date,getdate()))) and isnull(pd.ToDate,dateadd(dd,360,Convert(date,getdate())))
Group By pd.ItemCode
Having Count(*)>1)
	FOR XML path('PromotionFocItemDetailList'),ELEMENTS,ROOT('Json')) AS XML)
END
