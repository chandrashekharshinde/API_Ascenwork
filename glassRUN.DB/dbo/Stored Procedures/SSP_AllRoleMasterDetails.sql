

create PROCEDURE [dbo].[SSP_AllRoleMasterDetails] (
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @PageId Nvarchar(100)

SELECT  
		@PageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], [RoleMasterId],
       [RoleMasterId] as [Id],
		RoleName as [Name],
		[Description],
		IsActive,
		CreatedDate,
		CreatedBy,
		CreatedFromIPAddress,
		UpdatedDate,
		UpdatedBy,
		UpdatedFromIPAddress
  FROM [RoleMaster] WHERE IsActive = 1
  FOR XML path('RoleMasterList'),ELEMENTS,ROOT('Json')) AS XML)
END