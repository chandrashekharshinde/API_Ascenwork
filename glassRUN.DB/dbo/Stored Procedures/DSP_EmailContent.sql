CREATE PROCEDURE [dbo].[DSP_EmailContent] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @emailcontentId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @emailcontentId = tmp.[EmailContentId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EmailContentId] bigint
           
			)tmp ;


			
Update EmailContent SET IsActive=0 where EmailContentId=@emailcontentId
 SELECT @emailcontentId as emailcontentId FOR XML RAW('Json'),ELEMENTS
END
