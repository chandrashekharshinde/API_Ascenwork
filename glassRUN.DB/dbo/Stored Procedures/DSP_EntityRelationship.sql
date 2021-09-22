Create PROCEDURE [dbo].[DSP_EntityRelationship] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @PrimaryEntity bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @PrimaryEntity = tmp.[PrimaryEntity]
    
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PrimaryEntity] bigint
           
   )tmp ;


   
Update EntityRelationship SET IsActive=0 where PrimaryEntity=@PrimaryEntity

 SELECT @PrimaryEntity as PrimaryEntity FOR XML RAW('Json'),ELEMENTS
END
