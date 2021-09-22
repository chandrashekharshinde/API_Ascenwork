CREATE PROCEDURE [dbo].[DSP_Company] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @CompanyId bigint;
--Declare @EventMasterID12 bigint;
--Declare @NotificationTypeMasterID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
           
			)tmp ;


			
Update Company SET IsActive=0, ModifiedDate=GETDATE() where CompanyId=@CompanyId
			
Update [zonecode] SET IsActive=0, UpdatedDate=GETDATE() where CompanyId=@CompanyId
Update [companybranchplant] SET IsActive=0, UpdatedDate=GETDATE() where CompanyId=@CompanyId
Update [companyproducttype] SET IsActive=0, UpdatedDate=GETDATE() where CompanyId=@CompanyId
Update [contactinformation] SET IsActive=0, ModifiedDate=GETDATE() where ObjectId=@CompanyId and ObjectType='Company'
Update [transporteraccountdetail] SET IsActive=0, UpdatedDate=GETDATE() where ObjectId=@CompanyId and ObjectType='Company'
Update [LocationAndProductCategoryMapping]  SET IsActive=0, ModifiedDate=GETDATE() where ObjectId=@CompanyId and ObjectType='Company'

 SELECT @CompanyId as CompanyId FOR XML RAW('Json'),ELEMENTS
END
