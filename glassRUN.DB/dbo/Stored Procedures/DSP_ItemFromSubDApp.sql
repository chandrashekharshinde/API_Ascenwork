

CREATE PROCEDURE [dbo].[DSP_ItemFromSubDApp] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @itemId bigint;
Declare @ModifiedBy bigint;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @itemId = tmp.[ItemId],
	   @ModifiedBy = tmp.[ModifiedBy]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemId] bigint,
            [ModifiedBy] bigint
			)tmp ;


Update Item SET IsActive= 0, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE()  where ItemId=@itemId
 SELECT @itemId as ItemId FOR XML RAW('Json'),ELEMENTS
END
