CREATE PROCEDURE [dbo].[SSP_LocationDetailsForB2BApp] 
@xmlDoc XML

AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @companyId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
@companyId = tmp.[CompanyId]
FROM OPENXML(@intpointer,'Json',2)
WITH
(
CompanyId bigint

)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array],
LocationId
,LocationName
,DisplayName
,LocationCode
,CompanyID
,LocationType
,LocationIdentifier
,Area
,AddressLine1
,AddressLine2
,AddressLine3
,AddressLine4
,City
,[State]
,Pincode
,Country
,Email
,Parentid
,Capacity
,Safefill
,ProductCode
,[Description]
,Remarks
,CreatedBy
,CreatedDate
,ModifiedBy
,ModifiedDate
,IsActive
,SequenceNo
,Field1
,Field2
,Field3
,Field4
,Field5
,Field6
,Field7
,Field8
,Field9
,Field10
,AddressNumber
,IsAutomatedWMS
,WMSBranchPlantCode
,WareHouseType
,BillType
,BusinessUnitCode
,ISNULL(ShipTo,0) As ShipTo
,ISNULL(BillTo,0) As BillTo 
,(select LoginId from [Login] where ReferenceId = @companyId) As UserId
from Location where CompanyId = @companyId and [Location].IsActive = 1
FOR XML path('LocationDetails'),ELEMENTS,ROOT('Json')) AS XML)
END