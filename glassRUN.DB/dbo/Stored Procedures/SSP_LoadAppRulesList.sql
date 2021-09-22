CREATE PROCEDURE [dbo].[SSP_LoadAppRulesList] --'<Json><ServicesAction>GetCollectionPickUpDateForGrid</ServicesAction><DeliveryLocation /><Company /><Supplier /><RuleType>1</RuleType><Order><OrderTime></OrderTime><OrderDate></OrderDate><RequestTime></RequestTime><RequestedDate>30/07/2019</RequestedDate></Order></Json>'  
(  
@xmlDoc XML  
)  
AS  
  
DECLARE @intPointer INT;  
Declare @LocationId INT  
Declare @CompanyId INT  
Declare @CompanyMnemonic nvarchar(200)='0'  
Declare @SKUCode nvarchar(200)='0' 
Declare @RuleTypes nvarchar(max)='0' 
BEGIN  
  
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc  
  
SELECT   
      
   @CompanyId = tmp.[CompanyId],  
   @RuleTypes=tmp.[RuleTypes],  
   @CompanyMnemonic=tmp.[CompanyMnemonic]
   
  
FROM OPENXML(@intpointer,'Json',2)  
   WITH  
   (  
   [RuleTypes] nvarchar(max),  
   [CompanyId] int,  
   [CompanyMnemonic] nvarchar(200)    
   )tmp;  
  





 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  Select CAST((Select 'true' AS [@json:Array]    
   ,r.[RuleId]  
      ,r.[RuleType]  
      ,r.[RuleText]  
      ,r.[Remarks]  
    ,Isnull((Select top 1 Field3 from LookUp where IsActive=1 and Code=convert(nvarchar(10),r.RuleType)),'0') as IsJsonRequiredFromServer     
	,ISNULL((Select top 1 Field4 from LookUp where IsActive=1 and Code=convert(nvarchar(10),r.RuleType)),'-') as ServicesAction   
   From [Rules] r   
   where   
  
   RuleType in (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] (@RuleTypes))
   --and (@ruletext='"**"' or (CONTAINS (r.RuleText,@ruletext)))   
   and [Enable]=1  
   and Convert(date,GETDATE()) between isnull(FromDate,Convert(date,GETDATE())) and isnull(ToDate,Convert(date,GETDATE())) and r.IsActive = 1  
   order by ISNULL(r.ModifiedDate,r.CreatedDate) desc  
    FOR XML path('RuleList'),ELEMENTS,ROOT('Json')) AS XML)  
  
END
