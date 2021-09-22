
CREATE PROCEDURE [dbo].[SSP_LoadAppFormList] 

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

DECLARE @UserId BIGINT
DECLARE @AppVersion NVARCHAR(50)
DECLARE @appType NVARCHAR(50)
DECLARE @RoleMasterId NVARCHAR(50)


SELECT @UserId = tmp.[UserId],
		@AppVersion = tmp.[AppVersion],
		@appType = tmp.[appType],
		@RoleMasterId = tmp.[RoleMasterId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
		UserId BIGINT,
		AppVersion NVARCHAR(50),
		appType NVARCHAR(50),
		RoleMasterId  NVARCHAR(50)
			)tmp;



DECLARE @dyanamicQuery nvarchar(max)=''
DECLARE @main nvarchar(max)=''


DECLARE @appFormsListOutput nvarchar(max)=''


--------------------Start-AppForms---------------------------

IF(@AppVersion ='')
begin

SET @dyanamicQuery = ' roleMasterid  IN (' + CONVERT(NVARCHAR(200),@RoleMasterId) +')  and apptype = '+ CONVERT(NVARCHAR(200),@appType)
END
ELSE
begin 
SET @dyanamicQuery = '  Version <> '''+ @AppVersion +''' AND roleMasterid  IN (' + CONVERT(NVARCHAR(200),@RoleMasterId) +') and apptype = '+ CONVERT(NVARCHAR(200),@appType)
end

EXEC  [dbo].[SSP_AppFormsList_SelectByCriteria] @dyanamicQuery,'',@appFormsListOutput OUTPUT


--------------------End-AppForms---------------------------


--------------------- Start --main query execution---------------------------

 SET @main=';WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT  ''true'' AS [@json:Array]  ,1 as data ,'+
@appFormsListOutput+
   ' FOR XML PATH(''Json''),ELEMENTS)AS XML)'

print 'glassrun'

 PRINT @main

 EXEC sp_executesql @main
 --Exec(@main1+@main2)

 --------------------- End --main query execution---------------------------

END
