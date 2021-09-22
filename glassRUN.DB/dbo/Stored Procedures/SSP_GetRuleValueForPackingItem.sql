CREATE PROCEDURE [dbo].[SSP_GetRuleValueForPackingItem] --'<Json><ServicesAction>GetProposedDeliveryDate</ServicesAction><DeliveryLocation><LocationId>806</LocationId><DeliveryLocationCode>1111330</DeliveryLocationCode></DeliveryLocation><Company><CompanyId>671</CompanyId><CompanyMnemonic>1111330</CompanyMnemonic></Company><RuleType>1</RuleType><CompanyId>671</CompanyId><CompanyMnemonic>1111330</CompanyMnemonic><Order><OrderTime></OrderTime><OrderDate></OrderDate></Order></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;
Declare @LocationId INT
Declare @CompanyId INT
Declare @CompanyMnemonic nvarchar(max)='0'
Declare @SKUCode nvarchar(max)='0'
Declare @RuleType bigint
BEGIN

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   
	  @CompanyId = tmp.[CompanyId],
	  @RuleType=tmp.[RuleType],
	  @CompanyMnemonic=tmp.[CompanyMnemonic],
	  @SKUCode=tmp.[SKUCode]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[RuleType] bigint,
			[CompanyId] int,
			[CompanyMnemonic] nvarchar(max),
			[SKUCode] nvarchar(max)
           
			)tmp;


if @RuleType=8
begin
set @CompanyId='0'
end;


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  Select CAST((Select 'true' AS [@json:Array]  
	  ,r.[RuleId]
      ,r.[RuleType]
      ,r.[RuleText]
      ,r.[Remarks]
	  ,Isnull(l.Field3,'0') as IsJsonRequiredFromServer
	  ,Isnull(l.Field4,'-') as ServicesAction
	  From [Rules] r left join [LookUp] l on convert(nvarchar(10),r.[RuleType]) =l.Code
	  where 
	  RuleType=@RuleType 
	  and [Enable]=1
	  and Convert(date,GETDATE()) between isnull(FromDate,Convert(date,GETDATE())) and isnull(ToDate,Convert(date,GETDATE())) and r.IsActive = 1
	  and r.RuleText like '%'+@SKUCode+'%'
	  order by ISNULL(r.ModifiedDate,r.CreatedDate) desc
    FOR XML path('RuleList'),ELEMENTS,ROOT('Json')) AS XML)

END
