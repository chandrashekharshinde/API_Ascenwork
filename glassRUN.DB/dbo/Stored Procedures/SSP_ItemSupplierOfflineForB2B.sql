CREATE PROCEDURE [dbo].[SSP_ItemSupplierOfflineForB2B] --'<Json><userName>Subd1</userName></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @username = tmp.[userName]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			userName nvarchar(max)

			)tmp;

If (select ISNULL(SettingValue,'0') from SettingMaster where SettingParameter = 'IsCatalogAvailableOffline') = '1'
Begin
	
	SELECT @companyId=(select top 1 ReferenceId from [Login] where UserName = @username)

	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,  
		  * from (
			select ItemId
				,ItemCode
				,ItemShortCode
				,CompanyId
				,CompanyMnemonic from ItemSupplier where IsActive = 1
			  and CompanyId in (SELECT hi.ParentCompanyId FROM [dbo].Hierarchy hi where hi.CompanyId = @companyId and ISNULL(hi.ParentCompanyId,0) != 0)
			  
			  UNION

				  select ItemId
				,ItemCode
				,ItemShortCode
				,CompanyId
				,CompanyMnemonic from ItemSupplier where IsActive = 1
			  and CompanyId = @companyId

			) tmp order by tmp.ItemCode
		  FOR XML PATH('ItemSupplierList'),ELEMENTS,ROOT('Json')) AS XML)
END
ELSE
Begin
	
	;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) select cast ((SELECT  'true' AS [@json:Array]  ,1 as data 
   FOR XML PATH('Json'),ELEMENTS)AS XML)

ENd

END
