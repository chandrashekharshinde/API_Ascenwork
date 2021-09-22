CREATE PROCEDURE [dbo].[SSP_GetRoleMasterDetailByRoleId] --'<Json><ServicesAction>EditRoleByRoleId</ServicesAction><roleMasterId>10035</roleMasterId></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
declare @roleId BIGINT



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @roleId = tmp.[RoleId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
							[RoleId] bigint
			)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

			Select Cast((SELECT	'true' AS [@json:Array], [RoleMasterId]
      ,[RoleName]
      ,[Description]
	  ,PolicyName
			  ,(select cast ((SELECT 'true' AS [@json:Array], [RoleWisePageMappingId]
			  ,[PageId]
			  ,[RoleMasterId]
			  ,[AccessId]
			  ,[CreatedBy]
			  ,[CreatedDate]
			  ,[ModifiedBy]
			  ,[ModifiedDate]
			  ,[IsActive]
					  ,(select cast ((SELECT 'true' AS [@json:Array], [RoleWisePageMappingId],RoleWiseFieldAccessId
					  ,[PageId]
					  ,[RoleId]
					  ,[LoginId]
					  ,[PageControlId]
					  ,[AccessId]
					  ,[CreatedBy]
					  ,[CreatedDate]
					  ,[ModifiedBy]
					  ,[ModifiedDate]
					  ,[IsActive]
					  from [RoleWiseFieldAccess] rwfm
					  WHERE rwfm.IsActive = 1 AND rwpm.PageId = rwfm.PageId  and RoleId = @roleId
					  FOR XML path('RoleWiseFieldAccessList'),ELEMENTS) AS xml))
				 from [RoleWisePageMapping] rwpm
				 WHERE rwpm.IsActive = 1 AND rwpm.RoleMasterId = RoleMaster.RoleMasterId 
				 FOR XML path('RoleWisePageMappingList'),ELEMENTS) AS xml))
				 


   from RoleMaster
   WHERE IsActive = 1 AND RoleMasterId = @roleId

       FOR XML path('RoleMasterList'),ELEMENTS,ROOT('Json')) AS XML)
 

END
