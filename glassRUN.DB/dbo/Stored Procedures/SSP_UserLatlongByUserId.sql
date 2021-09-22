CREATE PROCEDURE [dbo].[SSP_UserLatlongByUserId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
 WITH RECOMPILE  
AS
BEGIN


DECLARE @intPointer INT;
Declare @UserId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;
			
	SELECT 
	@UserId = tmp.[UserId]
	FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
	UserId Bigint

	)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
			
SELECT CAST((SELECT  'true' AS [@json:Array],
	   [UserLatLongId]
      ,[UserId]
      ,[Latitude]
      ,[Longitude]
      ,[CreatedBy]
      ,[CreatedDate]
  FROM [dbo].[UserLatLong]-- WHERE  isnull(UserId,0) = @UserId order by CreatedDate Asc
	FOR XML path('UserlatlongList'),ELEMENTS,ROOT('Json')) AS XML)
END


