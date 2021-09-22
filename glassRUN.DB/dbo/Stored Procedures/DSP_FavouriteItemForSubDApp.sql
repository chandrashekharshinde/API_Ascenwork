
CREATE PROCEDURE [dbo].[DSP_FavouriteItemForSubDApp] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @CompanyId bigint;
Declare @ItemId bigint;
--Declare @EventMasterID12 bigint;
--Declare @NotificationTypeMasterID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],
		@ItemId = tmp.[ItemId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
			[ItemId] bigint
			)tmp ;


Delete from FavouriteItem where CompanyId = @CompanyId and ItemId = @ItemId

 SELECT @CompanyId as CompanyId FOR XML RAW('Json'),ELEMENTS
END
