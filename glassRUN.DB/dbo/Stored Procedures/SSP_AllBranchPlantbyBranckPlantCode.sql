Create PROCEDURE [dbo].[SSP_AllBranchPlantbyBranckPlantCode] --'<Json><CompanyId>1</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @branchPlantCode nvarchar(100)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @branchPlantCode = tmp.[Branchplant]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[Branchplant] nvarchar(100)
			)tmp


SELECT CAST((SELECT  [DeliveryLocationId]
      ,[DeliveryLocationName]
      ,[DeliveryLocationCode]
      ,[CompanyID]
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
  FROM [DeliveryLocation]
     
   WHERE IsActive =1 and DeliveryLocationCode=@branchPlantCode
	FOR XML RAW('DeliveryLocationList'),ELEMENTS,ROOT('DeliveryLocation')) AS XML)
END
