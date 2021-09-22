CREATE PROCEDURE [dbo].[SSP_GetContactInformationByCompanyId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @objectId bigint
Declare @objectType nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @objectId = tmp.[ObjectId],
	   @objectType=tmp.[ObjectType]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ObjectId] bigint,
			[ObjectType] nvarchar(50)
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[ContactInformationId]
      ,[ObjectId]
	  ,[ObjectType]
      ,[ContactType]
      ,[ContactPerson]
      ,[Contacts]
      ,[Purpose]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
				   FROM [ContactInformation]  
	  WHERE IsActive = 1 and [ObjectId]=@objectId and ObjectType=@objectType
	FOR XML path('ContactInformatList'),ELEMENTS,ROOT('Json')) AS XML)
END
