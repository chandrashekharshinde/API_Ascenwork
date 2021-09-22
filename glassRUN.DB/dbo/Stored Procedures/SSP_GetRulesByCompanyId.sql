

CREATE PROCEDURE [dbo].[SSP_GetRulesByCompanyId] --'<Json><ServicesAction>GetCollectionPickUpDateForGrid</ServicesAction><DeliveryLocation /><Company /><Supplier /><RuleType>1</RuleType><Order><OrderTime></OrderTime><OrderDate></OrderDate><RequestTime></RequestTime><RequestedDate>30/07/2019</RequestedDate></Order></Json>'  
(  
@xmlDoc XML  
)  
AS  
  
DECLARE @intPointer INT;  
Declare @LocationId INT  
Declare @CompanyId INT  
Declare @CompanyMnemonic nvarchar(200)='0'  
Declare @SKUCode nvarchar(200)='0' 
Declare @RuleType bigint  
BEGIN  
  
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc  
  
SELECT   
      
   @CompanyId = tmp.[CompanyId],  
   @RuleType=tmp.[RuleType],  
   @CompanyMnemonic=tmp.[CompanyMnemonic]
   
  
FROM OPENXML(@intpointer,'Json',2)  
   WITH  
   (  
   [RuleType] bigint,  
   [CompanyId] int,  
   [CompanyMnemonic] nvarchar(200)    
   )tmp;  
  

  SELECT   
      @SKUCode = tmp1.[SKUCode]
	  

FROM OPENXML(@intpointer,'Json/Item',2)  
   WITH  
   (  
    [SKUCode] nvarchar(200)  
   )tmp1;


  
if @RuleType=8  
begin  
set @CompanyId='0'  
end;  
  
-------------FreeText Search----------------------
declare @ruletext nvarchar(4000)
 if @RuleType = 1
Begin
Set @ruletext=(SELECT [dbo].[fn_GetItemSearchText] (@CompanyMnemonic))
end
Else If @RuleType = 2 
 begin
 Set @ruletext=(SELECT [dbo].[fn_GetItemSearchText] (@SKUCode +' '+@CompanyMnemonic))
 end
 Else If @RuleType = 4
 begin
  Set @ruletext=(SELECT [dbo].[fn_GetItemSearchText] (@SKUCode))
 end
  Else 
 begin
  Set @ruletext='"**"'
 end
print @ruletext;





 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  Select CAST((Select 'true' AS [@json:Array]    
   ,r.[RuleId]  
      ,r.[RuleType]  
      ,r.[RuleText]  
      ,r.[Remarks]  
    ,Isnull((Select top 1 Field3 from LookUp where IsActive=1 and Code=convert(nvarchar(10),r.RuleType)),'0') as IsJsonRequiredFromServer     
	,ISNULL((Select top 1 Field4 from LookUp where IsActive=1 and Code=convert(nvarchar(10),r.RuleType)),'-') as ServicesAction   
   From [Rules] r   
   where   
  
   RuleType=@RuleType 
   and (@ruletext='"**"' or (CONTAINS (r.RuleText,@ruletext)))   
   --and ruletext like case when @RuleType = 1 Then '%'+@CompanyMnemonic+'%'  
			--			  when @RuleType = 2 or @RuleType = 4 Then '%'+@SKUCode+'%'
   --else ruletext end  
   and [Enable]=1  
   and Convert(date,GETDATE()) between isnull(FromDate,Convert(date,GETDATE())) and isnull(ToDate,Convert(date,GETDATE())) and r.IsActive = 1  
   order by ISNULL(r.ModifiedDate,r.CreatedDate) desc  
    FOR XML path('RuleList'),ELEMENTS,ROOT('Json')) AS XML)  
  
END  