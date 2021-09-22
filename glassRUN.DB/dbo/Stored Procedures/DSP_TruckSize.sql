CREATE PROCEDURE [dbo].[DSP_TruckSize] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @truckSizeId bigint;
Declare @IsActive bigint;
Declare @ModifiedBy bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @truckSizeId = tmp.[TruckSizeId],
	   @IsActive = tmp.[IsActive],
	   @ModifiedBy = tmp.[ModifiedBy]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TruckSizeId] bigint,
			[IsActive] bit,
            [ModifiedBy] bigint
           
			)tmp ;

	
Update TruckSize SET IsActive= @IsActive, UpdatedBy = @ModifiedBy, UpdatedDate = GETDATE() where TruckSizeId=@truckSizeId
 SELECT @truckSizeId as TruckSize FOR XML RAW('Json'),ELEMENTS
END
