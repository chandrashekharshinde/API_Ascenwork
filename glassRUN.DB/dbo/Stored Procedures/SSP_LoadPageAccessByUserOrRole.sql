CREATE PROCEDURE [dbo].[SSP_LoadPageAccessByUserOrRole] --'<Json><ServicesAction>LoadPageAccessByRoleOrUser</ServicesAction><RoleId>8</RoleId><LoginId>0</LoginId></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
declare @roleId BIGINT
declare @loginId bigint
declare @whereclause nvarchar(max)
declare @whereclause1 nvarchar(max)
Declare @sql nvarchar(max)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @roleId = tmp.[RoleId],
	   @loginId = tmp.[LoginId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
							[RoleId] bigint,
							[LoginId] bigint
			)tmp;


			if @loginId = 0
				begin
				set @whereclause = 'RoleMasterId = '+Convert(nvarchar(50),@roleId)+''
				set @whereclause1 = 'RoleId = '+Convert(nvarchar(50),@roleId)+''
				end
			else
				begin
				set @whereclause = 'LoginId = '+Convert(nvarchar(50),@loginId)+''
				set @whereclause1 = 'LoginId = '+Convert(nvarchar(50),@loginId)+''
				end


			SET @sql = '
WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  

	   select cast ((SELECT ''true'' AS [@json:Array], [RoleWisePageMappingId]
			  ,[PageId]
			  ,[RoleMasterId]
			  ,[AccessId]
			  ,[CreatedBy]
			  ,[CreatedDate]
			  ,[ModifiedBy]
			  ,[ModifiedDate]
			  ,[IsActive]
					  ,(select cast ((SELECT ''true'' AS [@json:Array], RoleWiseFieldAccessId
					  ,[PageId]
					  ,[RoleId]
					  ,[LoginId]
					  ,[PageControlId]
					  ,[AccessId]
					  ,[CreatedBy]
					  ,[CreatedDate]
					  ,[UpdatedBy]
					  ,[UpdatedDate]
					  ,[IsActive]
					  from [RoleWiseFieldAccess] rwfm
					  WHERE rwfm.IsActive = 1 AND rwfm.PageId = rwpm.PageId AND '+@whereclause1+'
					  FOR XML path(''RoleWiseFieldAccessList''),ELEMENTS) AS xml))
				 from [RoleWisePageMapping] rwpm
				 WHERE rwpm.IsActive = 1 AND '+@whereclause+' 

				  FOR XML path(''PageAccessList''),ELEMENTS,ROOT(''Json'')) AS XML)'
 
 	PRINT @sql
	
	EXEC sp_executesql @sql

END
