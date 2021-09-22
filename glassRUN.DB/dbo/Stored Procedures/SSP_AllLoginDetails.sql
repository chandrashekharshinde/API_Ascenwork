

CREATE PROCEDURE [dbo].[SSP_AllLoginDetails] (
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;
Declare @sql nvarchar(max)
Declare @RoleMasterId Nvarchar(max)
Declare @whereClause  NVARCHAR(max)

set  @whereClause =''
SELECT @RoleMasterId = tmp.[RoleMasterId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[RoleMasterId] Nvarchar(Max)
			)tmp;

			 PRINT @RoleMasterId
	IF @RoleMasterId != '0'
	BEGIN
	PRINT @RoleMasterId
	SET @whereClause ='RoleMasterId in ('+@RoleMasterId+ ')'
	PRINT @RoleMasterId
	END

    IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END;
 PRINT @RoleMasterId
set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  

SELECT CAST((
SELECT ''true'' AS [@json:Array], [LoginId] as [Id],
	[UserName] as [Name]
  FROM [Login] WHERE IsActive = 1 and '+@whereClause+'
  FOR XML path(''LoginDetailsList''),ELEMENTS,ROOT(''Json'')) AS XML)'
			

  PRINT @sql
 execute (@sql)

END