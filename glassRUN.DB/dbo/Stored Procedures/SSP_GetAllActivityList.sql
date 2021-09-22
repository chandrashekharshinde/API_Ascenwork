
CREATE PROCEDURE [dbo].[SSP_GetAllActivityList] --'<Json><ServicesAction>GetAllActivityDetail</ServicesAction><RoleMasterId>13</RoleMasterId></Json>'
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @OrderId bigint
Declare @RoleId bigint
Declare @UserId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

SELECT @RoleId = tmp.[RoleMasterId]      FROM OPENXML(@intpointer,'Json',2)   WITH   (    [RoleMasterId] bigint      )tmp;

  


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,[ActivityId]
      ,[StatusCode]
      ,[Header]
      ,[ActivityName]
      ,[Sequence]
      ,[ServiceAction] 
	  ,@RoleId as RoleMasterId
	  ,(Select top 1 RoleWiseStatusId from RoleWiseStatus where StatusId=[Activity].StatusCode and RoleId=@RoleId) as RoleWiseStatusId
	  ,(Select top 1 Class from RoleWiseStatus where StatusId=[Activity].StatusCode and RoleId=@RoleId) as Class
	  ,(Select top 1 ResourceKey from RoleWiseStatus where StatusId=[Activity].StatusCode and RoleId=1) as ResourceKey
	  , (select cast ((SELECT  'true' AS [@json:Array],ResourceId,ResourceKey,(Select RoleName from RoleMaster where RoleMasterId=@RoleId) as RoleName,@RoleId as RoleMasterId,ResourceValue,(Select Name from LookUp where LookUpId=Resources.CultureId) as Name from Resources where ResourceKey in (Select ResourceKey from RoleWiseStatus where StatusId=[Activity].StatusCode and RoleId=@RoleId) and ResourceType='Status'
 FOR XML path('CultureList'),ELEMENTS) AS xml))

  from Activity
FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)	

END