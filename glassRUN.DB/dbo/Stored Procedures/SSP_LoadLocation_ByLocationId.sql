CREATE PROCEDURE [dbo].[SSP_LoadLocation_ByLocationId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>76580</OrderId><RoleId>3</RoleId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @locationId nvarchar(100)
declare @roleId BIGINT
declare @CultureId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @locationId = tmp.[LocationId]
       
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [LocationId] bigint

   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((Select 'true' AS [@json:Array]  ,[LocationId]
      [LocationId]
      ,[LocationName]
      ,[DisplayName]
      ,[LocationCode]
      ,[CompanyID]
      ,[LocationType]
      ,[LocationIdentifier]
      ,[Area]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[City]
      ,[State]
      ,[Pincode]
      ,[Country]
      ,[Email]
      ,[Parentid]
      ,[Capacity]
      ,[Safefill]
      ,[ProductCode]
      ,[Description]
      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
      ,[AddressNumber]
      ,[IsAutomatedWMS]
      ,[WMSBranchPlantCode]
      ,[WareHouseType]
      ,[BillType] 
	  ,(select cast ((SELECT  'true' AS [@json:Array]  ,[CompanyId] as Id
      ,[CompanyName]	  
   from [Company]
   WHERE IsActive = 1  and CompanyId=[Location].CompanyID
 FOR XML path('CompanyList'),ELEMENTS) AS xml))
 ,(select cast ((SELECT  'true' AS [@json:Array] ,				ObjectId as ContactTypeId,				ObjectType as ObjectType,				ContactType as ContactType,					ContactPerson as ContactPersonName,				Contacts as  ContactPersonNumber,					IsActive as IsActive,				CreatedBy as CreatedBy				from ContactInformation contact where contact.ObjectId=[Location].[LocationId] and ObjectType='Location'				FOR XML path('ContactInformationList'),ELEMENTS) AS xml))
 FROM [dbo].[Location] WHERE ([LocationId] = @locationId OR @locationId = '') --AND IsActive=1
 FOR XML path('LocationList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END