
CREATE PROCEDURE [dbo].[SSP_CompanyDetailList_RoleId] --'<Json><ServicesAction>LoadAllCompanyDetailListByDropDown</ServicesAction><RoleMasterId>14</RoleMasterId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


declare @CompanyTypeId  bigint 


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @CompanyTypeId = tmp.CompanyTypeId

FROM OPENXML(@intpointer,'Json',2)
 WITH
 (CompanyTypeId bigint)tmp


;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((  select distinct 'true' AS [@json:Array]  
   ,c.CompanyId as id,c.CompanyMnemonic,c.CompanyName as [name]
  from  Company c Where c.CompanyType in (@CompanyTypeId)
  and c.CompanyId not in (Select PrimaryEntity from EntityRelationship)
FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)
   


END
