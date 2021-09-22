CREATE PROCEDURE [dbo].[SSP_AllRoleMasterList] 
(
@xmlDoc XML
)

AS
BEGIN
Declare @PageId bigint;
DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@PageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageId] bigint
   )tmp;

--(Select PageId from RoleWisePageMapping where (RoleMasterId = @RoleId or @RoleId=0)

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array], RoleMasterId,
		RoleName,
		[Description],
		IsActive,
		CreatedDate,
		CreatedBy,
		CreatedFromIPAddress,
		UpdatedDate,
		UpdatedBy,
		UpdatedFromIPAddress
  FROM [RoleMaster] WHERE IsActive = 1 and (RoleMasterId in (Select distinct RoleMasterId from RoleWisePageMapping Where PageId=@PageId) or @PageId=0) 
  order by RoleName
	FOR XML path('RoleMasterList'),ELEMENTS,ROOT('Json')) AS XML)
END
