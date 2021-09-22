
CREATE PROCEDURE [dbo].[DSP_EventRetrySettings]

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventRetrySettingsId bigint;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventRetrySettingsId = tmp.[EventRetrySettingsId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventRetrySettingsId] bigint
           
			)tmp ;


			
Update EventRetrySettings SET IsActive=0 where EventRetrySettingsId=@EventRetrySettingsId


 SELECT @EventRetrySettingsId as EventRetrySettingsId FOR XML RAW('Json'),ELEMENTS
END
