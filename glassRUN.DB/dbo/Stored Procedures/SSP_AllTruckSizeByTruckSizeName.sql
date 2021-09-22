Create PROCEDURE [dbo].[SSP_AllTruckSizeByTruckSizeName] --'<Json><CompanyId>1</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @truckSizeName nvarchar(100)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @truckSizeName = tmp.[TruckSize]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TruckSize] nvarchar(100)
			)tmp


SELECT CAST((SELECT  [TruckSizeId]
      ,[TruckSize]
      ,[TruckCapacityPalettes]
      ,[TruckCapacityWeight]
      ,[IsActive]
  FROM [TruckSize]
     
   WHERE IsActive =1 and TruckSize=@truckSizeName
	FOR XML RAW('TruckSizeList'),ELEMENTS,ROOT('TruckSize')) AS XML)
END
