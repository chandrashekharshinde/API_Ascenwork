CREATE PROCEDURE [dbo].[DSP_Location] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @LocationId bigint;
Declare @IsActive bit;
Declare @ModifiedBy bigint;
--Declare @EventMasterID12 bigint;
--Declare @NotificationTypeMasterID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LocationId = tmp.[LocationId],
	   @IsActive = tmp.[IsActive],
	   @ModifiedBy = tmp.[ModifiedBy]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LocationId] bigint,
			[IsActive] bit,
			[ModifiedBy] bigint
           
			)tmp ;


			
Update Location SET IsActive=@IsActive, ModifiedBy = @ModifiedBy, ModifiedDate=GETDATE() where LocationId=@LocationId

 SELECT @LocationId as LocationId FOR XML RAW('Json'),ELEMENTS
END
