CREATE PROCEDURE [dbo].[DSP_EmailEvent]
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @emailEventId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @emailEventId = tmp.[EmailEventId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			EmailEventId bigint
           
			)tmp ;


			
Update EmailEvent SET IsActive=0 where EmailEventId=@emailEventId
 SELECT @emailEventId as emailEventId FOR XML RAW('Json'),ELEMENTS
 END
