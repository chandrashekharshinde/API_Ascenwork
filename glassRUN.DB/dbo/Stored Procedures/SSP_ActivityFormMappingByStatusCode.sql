CREATE PROCEDURE [dbo].[SSP_ActivityFormMappingByStatusCode]
@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @StatusCode BIGINT



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @StatusCode = tmp.[StatusCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[StatusCode] bigint
			)tmp;
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
					[ActivityFormMappingId] ,
					[StatusCode] ,
					[FormName] 
					
	from [dbo].[ActivityFormMapping]
	 WHERE StatusCode=@StatusCode 
	FOR XML path('ActivityFormMappingList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
