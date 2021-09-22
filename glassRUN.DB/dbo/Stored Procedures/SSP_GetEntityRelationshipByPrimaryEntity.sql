CREATE PROCEDURE [dbo].[SSP_GetEntityRelationshipByPrimaryEntity] --'<Json><ServicesAction>LoadAllCompanyDetailListByDropDown</ServicesAction><RoleMasterId>14</RoleMasterId></Json>'
(
@xmlDoc XML
)
AS



BEGIN

DECLARE @intPointer INT;



declare @PrimaryEntity  bigint 
declare @PrimaryComapnyName  nvarchar(max) 
declare @PrimaryCompanyMnemonic  nvarchar(max)  


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @PrimaryEntity = tmp.[PrimaryEntity]

FROM OPENXML(@intpointer,'Json',2)
 WITH
 (PrimaryEntity bigint)tmp

 Select @PrimaryComapnyName=CompanyName,@PrimaryCompanyMnemonic=CompanyMnemonic from Company where CompanyId=@PrimaryEntity


;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((  select 'true' AS [@json:Array],  
 es.RelatedEntity,isnull(es.RuleId,0) as RuleId,isnull(r.RuleText,'-') as RuleText ,@PrimaryComapnyName as PrimaryComapnyName,@PrimaryCompanyMnemonic as PrimaryCompanyMnemonic,es.CompanyTypeId,c.CompanyId ,c.CompanyMnemonic,c.CompanyName 
  from   EntityRelationship es left join Company c  on c.CompanyId=es.RelatedEntity left join [Rules] r on es.Ruleid=r.RuleId  where PrimaryEntity=@PrimaryEntity
FOR XML path('EntityRelationshipList'),ELEMENTS,ROOT('Json')) AS XML)
   


END
