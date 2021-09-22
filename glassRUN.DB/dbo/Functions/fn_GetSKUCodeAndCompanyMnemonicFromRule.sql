CREATE FUNCTION [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] 
(@RuleId Bigint,@SourceType nvarchar(max))
RETURNS nvarchar(max)
BEGIN
 Declare @finalOuptput nvarchar(max)


 Declare @SplitValues TABLE 
(
	SourceType nvarchar(max),
	SourcesValue nvarchar(max)
)

Declare @RuleText nvarchar(max)
Select @RuleText=RuleText from Rules where RuleId=@RuleId
set @RuleText=REPLACE(@RuleText,'''','')
set @RuleText=REPLACE(@RuleText,'{','')
set @RuleText=REPLACE(@RuleText,'}','')
set @RuleText=REPLACE(@RuleText,'(','')
set @RuleText=REPLACE(@RuleText,')','')
set @RuleText=REPLACE(@RuleText,'&','@')
set @RuleText=REPLACE(@RuleText,'||','@')
set @RuleText=REPLACE(@RuleText,'If','')

SELECT @RuleText=SUBSTRING(@RuleText,0,CHARINDEX('Then',@RuleText,0))

if CHARINDEX('Item.SKUCode in',@RuleText) > 0   
begin 
DECLARE @xml2 xml
SET @xml2 = N'<root><r>' + Replace(replace(@RuleText,'Item.SKUCode in','</r><r>'),' ','') + '</r></root>'

INSERT INTO @SplitValues(SourceType,SourcesValue)
Select * from (
SELECT 'SKUCode' as SourceType,Replace(r.value('.','nvarchar(max)'),'@','') as SourcesValue
FROM @xml2.nodes('//root/r') as records(r)) as Test Where SourcesValue not like '%Company.CompanyMnemonic%'
End
Else
Begin
DECLARE @xml xml
SET @xml = N'<root><r>' + Replace(replace(@RuleText,'Item.SKUCode ==','</r><r>'),' ','') + '</r></root>'

INSERT INTO @SplitValues(SourceType,SourcesValue)
Select * from (
SELECT 'SKUCode' as SourceType,Replace(r.value('.','nvarchar(max)'),'@','') as SourcesValue
FROM @xml.nodes('//root/r') as records(r)) as Test Where SourcesValue not like '%Company.CompanyMnemonic%'
end




DECLARE @xml1 xml

DECLARE @Text VARCHAR(MAX), @First VARCHAR(MAX), @Second VARCHAR(MAX)
SET @Text = @RuleText
SET @First = '{Company.CompanyMnemonic} == '
SET @Second = '@'

SELECT @RuleText=SUBSTRING(@Text, CHARINDEX(@First, @Text), 
                 CHARINDEX(@Second, @Text) - CHARINDEX(@First, @Text) + LEN(@Second))
SET @xml1 = N'<root><r>' + Replace(replace(@RuleText,'Company.CompanyMnemonic ==','</r><r>'),' ','') + '</r></root>'

INSERT INTO @SplitValues(SourceType,SourcesValue)
Select * from (
SELECT 'CompanyMnemonic'as SourceType,Replace(r.value('.','nvarchar(max)'),'@','') as SourcesValue
FROM @xml1.nodes('//root/r') as records(r)) as Test Where SourcesValue !=''



SELECT @finalOuptput=STUFF((SELECT ',' + SourcesValue from @SplitValues where SourceType=@SourceType FOR XML PATH('')),1, 1, '') 



 Return @finalOuptput
END